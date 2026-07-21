Imports System
Imports Oracle.ManagedDataAccess.Client

Partial Public Class DefaultPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' Redirect to dashboard if the user is already authenticated
        If Session("CurrentUser") IsNot Nothing Then
            Response.Redirect("Dashboard.aspx")
        End If

        ' Show a success message if redirected from registration
        If Request.QueryString("registered") = "true" Then
            lblMessage.CssClass = "msg-label success-msg"
            lblMessage.Text = "Registration successful! Please sign in."
        End If
    End Sub

    ''' <summary>
    ''' Validates login credentials against the Oracle M_USERS table.
    ''' READ-ONLY: runs a single SELECT — no INSERT/UPDATE/DELETE.
    ''' Uses parameterised bind variables (:uid, :pwd) to prevent SQL injection.
    ''' </summary>
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim uid As String = txtEmail.Text.Trim()
        Dim pwd As String = txtPassword.Text

        ' ── Case 1: Username is empty ──────────────────────────────────────
        ' Keep password field value intact, set focus on username field.
        If String.IsNullOrEmpty(uid) Then
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "Please enter the username."
            txtEmail.Focus()
            Return
        End If

        ' ── Case 2: Username has a value AND password is empty ─────────────
        ' Keep username field value intact, move focus to password field.
        If String.IsNullOrEmpty(pwd) Then
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "Please enter the password."
            txtPassword.Focus()
            Return
        End If

        ' ── Both fields are filled — Query M_USERS database ────────────────
        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String = "SELECT USER_ID, USER_NAME, USER_PASSWORD FROM M_USERS WHERE USER_ID = :p_userid"

                Dim userFound As Boolean = False
                Dim dbPassword As String = String.Empty
                Dim dbUserId As String = String.Empty
                Dim dbUserName As String = String.Empty

                Using cmd As New OracleCommand(sql, conn)
                    cmd.Parameters.Add("p_userid", OracleDbType.Varchar2).Value = uid

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        If reader.Read() Then
                            userFound = True
                            dbUserId = reader("USER_ID").ToString()
                            dbUserName = If(reader("USER_NAME") IsNot DBNull.Value, reader("USER_NAME").ToString().Trim(), "")
                            dbPassword = If(reader("USER_PASSWORD") IsNot DBNull.Value, reader("USER_PASSWORD").ToString(), "")
                        End If
                    End Using
                End Using

                If userFound Then
                    If dbPassword = pwd Then
                        ' ── Case 5: Both match valid M_USERS row (Successful Login) ──
                        Session("CurrentUser") = dbUserId
                        Session("CurrentUserName") = If(String.IsNullOrEmpty(dbUserName), uid, dbUserName)
                        Response.Redirect("Dashboard.aspx")
                    Else
                        ' ── Case 3: Username exists, but Password wrong ────────────
                        lblMessage.CssClass = "msg-label error-msg"
                        lblMessage.Text = "Incorrect password, please try again."
                        txtPassword.Attributes("value") = ""
                        txtPassword.Focus()
                        Return
                    End If
                Else
                    ' ── Case 4: Username does NOT exist in M_USERS ──────────────────
                    lblMessage.CssClass = "msg-label error-msg"
                    lblMessage.Text = "Incorrect username or password."
                    ClearAndRefocus()
                    Return
                End If

            End Using
        Catch ex As Exception
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "Unable to connect to the server, please try again."
            ClearAndRefocus()
        End Try
    End Sub

    ''' <summary>
    ''' Clears both login fields and returns focus to the username field.
    ''' Called on every failed-login path so the user can retype from scratch.
    ''' </summary>
    Private Sub ClearAndRefocus()
        txtEmail.Text = ""
        txtPassword.Attributes("value") = ""  ' TextMode=Password never round-trips; clear via attribute
        txtEmail.Focus()
    End Sub

End Class
