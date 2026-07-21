<%@ WebHandler Language="VB" Class="LookupHandler" %>

Imports System
Imports System.Web
Imports System.Text
Imports Oracle.ManagedDataAccess.Client

Public Class LookupHandler
    Implements IHttpHandler

    ' ── Allowed field → SQL map (whitelist; never trust raw input) ──────────
    Private ReadOnly _queries As New Dictionary(Of String, FieldQuery)(StringComparer.OrdinalIgnoreCase) From {
        {"category",
            New FieldQuery("SELECT CATEGORY_ID, CATEGORY AS DISPLAY_NAME " &
                           "FROM M_CATEGORY " &
                           "WHERE UPPER(CATEGORY) LIKE UPPER(:prefix) || '%' " &
                           "ORDER BY CATEGORY")},
        {"brand",
            New FieldQuery("SELECT BRAND_ID, BRAND_NAME AS DISPLAY_NAME " &
                           "FROM M_BRANDS " &
                           "WHERE UPPER(BRAND_NAME) LIKE UPPER(:prefix) || '%' " &
                           "ORDER BY BRAND_NAME")},
        {"section",
            New FieldQuery("SELECT SECTION_ID, SECTION AS DISPLAY_NAME " &
                           "FROM M_SECTION " &
                           "WHERE UPPER(SECTION) LIKE UPPER(:prefix) || '%' " &
                           "ORDER BY SECTION")},
        {"budget",
            New FieldQuery("SELECT BUDGET_UTILIZING_ACC_ID, BUDGET_UTILIZING_ACC_NAME AS DISPLAY_NAME " &
                           "FROM M_BUDGET_UTILIZED_ACC " &
                           "WHERE UPPER(BUDGET_UTILIZING_ACC_NAME) LIKE UPPER(:prefix) || '%' " &
                           "ORDER BY BUDGET_UTILIZING_ACC_NAME")},
        {"supplier",
            New FieldQuery("SELECT SUPPLIER_ID, SUPPLIER_NAME AS DISPLAY_NAME " &
                           "FROM M_SUPPLIER " &
                           "WHERE UPPER(SUPPLIER_NAME) LIKE UPPER(:prefix) || '%' " &
                           "ORDER BY SUPPLIER_NAME")}
    }

    Public Sub ProcessRequest(context As HttpContext) Implements IHttpHandler.ProcessRequest
        ' ── CORS / cache headers ────────────────────────────────────────────
        context.Response.ContentType = "application/json; charset=utf-8"
        context.Response.Cache.SetCacheability(HttpCacheability.NoCache)

        ' ── Require authenticated session ───────────────────────────────────
        If context.Session("CurrentUser") Is Nothing Then
            context.Response.StatusCode = 401
            context.Response.Write("{""error"":""Unauthorized""}")
            Return
        End If

        ' ── Read and validate parameters ────────────────────────────────────
        Dim field  As String = (context.Request.QueryString("field")  ?? "").Trim().ToLower()
        Dim prefix As String = (context.Request.QueryString("prefix") ?? "").Trim()

        If Not _queries.ContainsKey(field) Then
            context.Response.StatusCode = 400
            context.Response.Write("{""error"":""Unknown field""}")
            Return
        End If

        Dim sql As String = _queries(field).Sql

        ' ── Execute query ───────────────────────────────────────────────────
        Dim sb As New StringBuilder("[")
        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Using cmd As New OracleCommand(sql, conn)
                    cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value =
                        If(String.IsNullOrEmpty(prefix), "", prefix)
                    ' Limit to 50 rows to keep the popup snappy
                    cmd.InitialLONGFetchSize = 50

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        Dim rowCount As Integer = 0
                        Dim first As Boolean = True
                        While reader.Read() AndAlso rowCount < 50
                            If Not first Then sb.Append(",")
                            first = False
                            Dim id   As String = JsonEscape(reader(0).ToString())
                            Dim name As String = JsonEscape(reader(1).ToString())
                            sb.AppendFormat("{{""id"":""{0}"",""name"":""{1}""}}", id, name)
                            rowCount += 1
                        End While
                    End Using
                End Using
            End Using
        Catch ex As Exception
            context.Response.StatusCode = 500
            context.Response.Write("{""error"":""Unable to load options: " & JsonEscape(ex.Message) & """}")
            Return
        End Try

        sb.Append("]")
        context.Response.Write(sb.ToString())
    End Sub

    Private Function JsonEscape(s As String) As String
        If s Is Nothing Then Return ""
        Return s.Replace("\", "\\").Replace("""", "\""").Replace(Chr(13), "\r").Replace(Chr(10), "\n").Replace(Chr(9), "\t")
    End Function

    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    ' ── Simple DTO ──────────────────────────────────────────────────────────
    Private Class FieldQuery
        Public ReadOnly Property Sql As String
        Public Sub New(sql As String)
            Me.Sql = sql
        End Sub
    End Class

End Class
