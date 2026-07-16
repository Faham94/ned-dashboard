Imports System
Imports System.Collections.Generic

Partial Public Class RegisterPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' Initialize global users dictionary in session state if not already set
        If Session("Users") Is Nothing Then
            Dim users As New Dictionary(Of String, String)(StringComparer.OrdinalIgnoreCase)
            users.Add("admin@example.com", "admin123")
            Session("Users") = users
        End If

        ' Initialize global display names dictionary in session state if not already set
        If Session("UserNames") Is Nothing Then
            Dim userNames As New Dictionary(Of String, String)(StringComparer.OrdinalIgnoreCase)
            userNames.Add("admin@example.com", "Administrator")
            Session("UserNames") = userNames
        End If
    End Sub

    ''' <summary>
    ''' Handles registration of a new user.
    ''' </summary>
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim fullName As String = txtFullName.Text.Trim()
        Dim email As String = txtEmail.Text.Trim()
        Dim password As String = txtPassword.Text
        Dim confirmPassword As String = txtConfirmPassword.Text

        ' Validate inputs
        If String.IsNullOrEmpty(fullName) OrElse String.IsNullOrEmpty(email) OrElse String.IsNullOrEmpty(password) Then
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "All fields are required."
            Return
        End If

        ' Validate passwords match
        If password <> confirmPassword Then
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "Passwords do not match."
            Return
        End If

        Dim users As Dictionary(Of String, String) = CType(Session("Users"), Dictionary(Of String, String))
        Dim userNames As Dictionary(Of String, String) = CType(Session("UserNames"), Dictionary(Of String, String))

        ' Check if user already exists
        If users.ContainsKey(email) Then
            lblMessage.CssClass = "msg-label error-msg"
            lblMessage.Text = "An account with this email already exists."
            Return
        End If

        ' Register user in Session state dictionaries
        users.Add(email, password)
        userNames.Add(email, fullName)

        ' Redirect to login page with registration flag
        Response.Redirect("Default.aspx?registered=true")
    End Sub
End Class
