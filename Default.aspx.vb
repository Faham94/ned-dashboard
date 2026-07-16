Imports System
Imports System.Collections.Generic

Partial Public Class DefaultPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' Initialize the session-based users database if it doesn't exist
        If Session("Users") Is Nothing Then
            Dim users As New Dictionary(Of String, String)(StringComparer.OrdinalIgnoreCase)
            users.Add("admin@example.com", "admin123") ' Default admin login
            Session("Users") = users
        End If

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
    ''' Validates login credentials and starts user session.
    ''' </summary>
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim email As String = txtEmail.Text.Trim()
        Dim password As String = txtPassword.Text

        ' Validation
        If String.IsNullOrEmpty(email) OrElse String.IsNullOrEmpty(password) Then
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "Please enter both email and password."
            Return
        End If

        Dim users As Dictionary(Of String, String) = CType(Session("Users"), Dictionary(Of String, String))

        ' Authenticate
        If users.ContainsKey(email) AndAlso users(email) = password Then
            ' Set session state variables
            Session("CurrentUser") = email
            ' Extract user name from email prefix (e.g. admin@example.com -> Admin)
            Dim displayName As String = email.Split("@"c)(0)
            displayName = Char.ToUpper(displayName(0)) & displayName.Substring(1)
            Session("CurrentUserName") = displayName
            
            ' Redirect to dashboard
            Response.Redirect("Dashboard.aspx")
        Else
            ' Render error message
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "Invalid email or password."
        End If
    End Sub
End Class
