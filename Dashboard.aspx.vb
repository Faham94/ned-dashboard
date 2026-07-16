Imports System
Imports System.Collections.Generic
Imports System.Linq

<Serializable>
Public Class TaskItem
    Public Property Id As String
    Public Property Name As String
    Public Property IsCompleted As Boolean
End Class

Partial Public Class DashboardPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' 1. Check if user is authenticated
        If Session("CurrentUser") Is Nothing Then
            Response.Redirect("Default.aspx")
        End If

        ' 2. Initialize TaskList session storage
        If Session("TaskList") Is Nothing Then
            Session("TaskList") = New List(Of TaskItem)()
        End If

        If Not IsPostBack Then
            ' 3. Populate university dashboard labels
            ' These can be configured programmatically or loaded from a configuration/database source.
            lblInstitutionName.Text = "National University of Engineering & Development"
            lblDepartmentName.Text = "Department of Information Technology"
            lblSystemTitle.Text = "Asset Management System"
            lblCopyrightDepartment.Text = "Department of Information Technology"

            ' TODO: Add change password redirection or modal logic here.
            ' TODO: Wire submenu click events or page routing.
            ' TODO: Load asset details or grid data from database data source instead of empty view.

            ' 4. Populate user profile details
            Dim email As String = Session("CurrentUser").ToString()
            Dim userName As String = If(Session("CurrentUserName") IsNot Nothing, Session("CurrentUserName").ToString(), email.Split("@"c)(0))
            
            lblUserName.Text = userName

            ' 5. Bind initial state
            BindTaskList()
        End If
    End Sub

    ''' <summary>
    ''' Handles adding a new task to the user session.
    ''' </summary>
    Protected Sub btnAddTask_Click(sender As Object, e As EventArgs)
        Dim taskName As String = txtTaskName.Text.Trim()
        If Not String.IsNullOrEmpty(taskName) Then
            Dim tasks As List(Of TaskItem) = CType(Session("TaskList"), List(Of TaskItem))
            
            Dim newItem As New TaskItem() With {
                .Id = Guid.NewGuid().ToString(),
                .Name = taskName,
                .IsCompleted = False
            }
            
            tasks.Add(newItem)
            Session("TaskList") = tasks
            txtTaskName.Text = String.Empty
            
            BindTaskList()
        End If
    End Sub

    ''' <summary>
    ''' Handles toggling or deleting specific task items.
    ''' </summary>
    Protected Sub rptTasks_ItemCommand(source As Object, e As Global.System.Web.UI.WebControls.RepeaterCommandEventArgs)
        Dim taskId As String = e.CommandArgument.ToString()
        Dim tasks As List(Of TaskItem) = CType(Session("TaskList"), List(Of TaskItem))
        Dim targetTask As TaskItem = Nothing
        For Each t In tasks
            If t.Id = taskId Then
                targetTask = t
                Exit For
            End If
        Next

        If targetTask IsNot Nothing Then
            If e.CommandName = "Toggle" Then
                targetTask.IsCompleted = Not targetTask.IsCompleted
            ElseIf e.CommandName = "Delete" Then
                tasks.Remove(targetTask)
            End If
            
            Session("TaskList") = tasks
            BindTaskList()
        End If
    End Sub

    ''' <summary>
    ''' Handles signing out of the dashboard.
    ''' </summary>
    Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
        ' Sign out by clearing session variables
        Session("CurrentUser") = Nothing
        Session("CurrentUserName") = Nothing
        Response.Redirect("Default.aspx")
    End Sub

    ''' <summary>
    ''' Binds the session tasks to the repeater control and updates display statistics.
    ''' </summary>
    Private Sub BindTaskList()
        Dim tasks As List(Of TaskItem) = CType(Session("TaskList"), List(Of TaskItem))
        
        rptTasks.DataSource = tasks
        rptTasks.DataBind()

        ' Control placeholder visibility
        pnlNoTasks.Visible = (tasks.Count = 0)

        ' Refresh dashboard numbers
        CalculateStats(tasks)
    End Sub

    ''' <summary>
    ''' Computes and updates metrics labels.
    ''' </summary>
    Private Sub CalculateStats(tasks As List(Of TaskItem))
        Dim total As Integer = tasks.Count
        Dim completed As Integer = 0
        For Each t In tasks
            If t.IsCompleted Then
                completed += 1
            End If
        Next
        Dim efficiency As Integer = 0

        If total > 0 Then
            efficiency = CInt(Math.Round((completed / total) * 100))
        End If

        lblTotalTasks.Text = total.ToString()
        lblCompletedTasks.Text = completed.ToString()
        lblEfficiency.Text = efficiency.ToString() & "%"
    End Sub
End Class
