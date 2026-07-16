Imports System
Imports System.IO
Imports System.Net
Imports System.Web
Imports System.Web.Hosting

''' <summary>
''' Custom ASP.NET host class that runs inside the ASP.NET AppDomain.
''' </summary>
Public Class MyHost
    Inherits MarshalByRefObject

    Private listener As HttpListener
    Private physicalDir As String
    Private virtualDir As String

    ''' <summary>
    ''' Starts the HttpListener and begins accepting incoming requests.
    ''' </summary>
    Public Sub StartServer(port As Integer, path As String)
        physicalDir = path
        virtualDir = "/"
        
        listener = New HttpListener()
        listener.Prefixes.Add("http://localhost:" & port & "/")
        listener.Start()
        
        Console.WriteLine("-------------------------------------------------")
        Console.WriteLine(" ASP.NET Web Forms + VB.NET Development Server")
        Console.WriteLine("-------------------------------------------------")
        Console.WriteLine("Server URL:   http://localhost:" & port & "/Default.aspx")
        Console.WriteLine("Physical Dir: " & physicalDir)
        Console.WriteLine("Status:       Running... Press Ctrl+C to stop.")
        Console.WriteLine("-------------------------------------------------")
        
        ' Start listening for requests asynchronously
        listener.BeginGetContext(AddressOf ProcessRequestCallback, Nothing)
    End Sub

    ''' <summary>
    ''' Callback method invoked when an HTTP request is received.
    ''' </summary>
    Private Sub ProcessRequestCallback(ar As IAsyncResult)
        Try
            Dim context As HttpListenerContext = listener.EndGetContext(ar)
            ' Immediately start waiting for the next request
            listener.BeginGetContext(AddressOf ProcessRequestCallback, Nothing)
            
            ' Process the current request in the ASP.NET runtime pipeline
            Dim worker As New MyWorkerRequest(context, virtualDir, physicalDir)
            HttpRuntime.ProcessRequest(worker)
        Catch ex As Exception
            Console.WriteLine("[Error] " & ex.Message)
        End Try
    End Sub
End Class

''' <summary>
''' Bridges the low-level HttpListenerContext request/response to the ASP.NET runtime.
''' </summary>
Public Class MyWorkerRequest
    Inherits HttpWorkerRequest

    Private _context As HttpListenerContext
    Private _virtualDir As String
    Private _physicalDir As String
    Private _preloadedBody As Byte()

    Public Sub New(context As HttpListenerContext, virtualDir As String, physicalDir As String)
        _context = context
        _virtualDir = virtualDir
        _physicalDir = physicalDir

        ' Read the entire POST request body (entity body) into memory if it exists.
        ' This is necessary for ASP.NET Web Forms postbacks (button clicks) to function.
        If _context.Request.HasEntityBody Then
            Using ms As New MemoryStream()
                _context.Request.InputStream.CopyTo(ms)
                _preloadedBody = ms.ToArray()
            End Using
        Else
            _preloadedBody = New Byte(-1) {}
        End If
    End Sub

    ' Abstract methods that must be overridden:

    Public Overrides Sub EndOfRequest()
        Try
            _context.Response.OutputStream.Close()
            _context.Response.Close()
        Catch
        End Try
    End Sub

    Public Overrides Sub FlushResponse(finalFlush As Boolean)
        Try
            _context.Response.OutputStream.Flush()
        Catch
        End Try
    End Sub

    Public Overrides Function GetHttpVerbName() As String
        Return _context.Request.HttpMethod
    End Function

    Public Overrides Function GetHttpVersion() As String
        Return "HTTP/" & _context.Request.ProtocolVersion.ToString()
    End Function

    Public Overrides Function GetLocalAddress() As String
        Return _context.Request.LocalEndPoint.Address.ToString()
    End Function

    Public Overrides Function GetLocalPort() As Integer
        Return _context.Request.LocalEndPoint.Port
    End Function

    Public Overrides Function GetQueryString() As String
        Dim url As String = _context.Request.RawUrl
        Dim idx As Integer = url.IndexOf("?"c)
        If idx = -1 Then Return String.Empty
        Return url.Substring(idx + 1)
    End Function

    Public Overrides Function GetRawUrl() As String
        Return _context.Request.RawUrl
    End Function

    Public Overrides Function GetRemoteAddress() As String
        Return _context.Request.RemoteEndPoint.Address.ToString()
    End Function

    Public Overrides Function GetRemotePort() As Integer
        Return _context.Request.RemoteEndPoint.Port
    End Function

    Public Overrides Function GetUriPath() As String
        Return _context.Request.Url.LocalPath
    End Function

    Public Overrides Sub SendKnownResponseHeader(index As Integer, value As String)
        Dim headerName As String = GetKnownResponseHeaderName(index)
        Try
            _context.Response.Headers(headerName) = value
        Catch
        End Try
    End Sub

    Public Overrides Sub SendResponseFromFile(filename As String, offset As Long, length As Long)
        If Not File.Exists(filename) Then Return
        Using fs As New FileStream(filename, FileMode.Open, FileAccess.Read, FileShare.ReadWrite)
            fs.Seek(offset, SeekOrigin.Begin)
            Dim buffer(4095) As Byte
            Dim remaining As Long = length
            While remaining > 0
                Dim toRead As Integer = CInt(Math.Min(remaining, buffer.Length))
                Dim read As Integer = fs.Read(buffer, 0, toRead)
                If read <= 0 Then Exit While
                _context.Response.OutputStream.Write(buffer, 0, read)
                remaining -= read
            End While
        End Using
    End Sub

    Public Overrides Sub SendResponseFromFile(handle As IntPtr, offset As Long, length As Long)
        ' Not supported/needed for basic ASP.NET hosting
    End Sub

    Public Overrides Sub SendResponseFromMemory(data As Byte(), length As Integer)
        If length > 0 Then
            Try
                _context.Response.OutputStream.Write(data, 0, length)
            Catch
            End Try
        End If
    End Sub

    Public Overrides Sub SendStatus(statusCode As Integer, statusDescription As String)
        _context.Response.StatusCode = statusCode
        _context.Response.StatusDescription = statusDescription
    End Sub

    Public Overrides Sub SendUnknownResponseHeader(name As String, value As String)
        Try
            _context.Response.Headers(name) = value
        Catch
        End Try
    End Sub

    ' Overridden virtual methods needed for routing and request body:

    Public Overrides Function GetAppPath() As String
        Return _virtualDir
    End Function

    Public Overrides Function GetAppPathTranslated() As String
        Return _physicalDir
    End Function

    Public Overrides Function GetFilePath() As String
        Return _context.Request.Url.LocalPath
    End Function

    Public Overrides Function GetFilePathTranslated() As String
        Return Path.Combine(_physicalDir, _context.Request.Url.LocalPath.TrimStart("/"c)).Replace("/"c, "\"c)
    End Function

    Public Overrides Function GetPathInfo() As String
        Return String.Empty
    End Function

    Public Overrides Function GetKnownRequestHeader(index As Integer) As String
        Dim headerName As String = GetKnownRequestHeaderName(index)
        Return _context.Request.Headers(headerName)
    End Function

    Public Overrides Function GetUnknownRequestHeader(name As String) As String
        Return _context.Request.Headers(name)
    End Function

    Public Overrides Function GetPreloadedEntityBody() As Byte()
        Return _preloadedBody
    End Function

    Public Overrides Function IsEntireEntityBodyIsPreloaded() As Boolean
        Return True
    End Function

    Public Overrides Function GetServerVariable(name As String) As String
        Select Case name
            Case "HTTPS"
                Return If(_context.Request.IsSecureConnection, "on", "off")
            Case "HTTP_HOST"
                Return _context.Request.Headers("Host")
            Case Else
                Return MyBase.GetServerVariable(name)
        End Select
    End Function
End Class
