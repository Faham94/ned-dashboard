Imports System
Imports System.IO
Imports System.Web.Hosting

Module Bootstrapper
    Sub Main()
        Dim port As Integer = 8080
        Dim physicalDir As String = AppDomain.CurrentDomain.BaseDirectory
        
        ' Ensure the bin/ folder exists in the physical directory
        Dim binDir As String = Path.Combine(physicalDir, "bin")
        If Not Directory.Exists(binDir) Then
            Directory.CreateDirectory(binDir)
        End If

        ' Copy ServerLib.dll to the bin folder so the ASP.NET AppDomain can find the MyHost type.
        Dim dllName As String = "ServerLib.dll"
        Dim sourceDllPath As String = Path.Combine(physicalDir, dllName)
        Dim targetDllPath As String = Path.Combine(binDir, dllName)

        If File.Exists(sourceDllPath) Then
            Try
                File.Copy(sourceDllPath, targetDllPath, True)
            Catch ex As Exception
                Console.WriteLine("Warning: Could not copy ServerLib.dll to bin folder. " & ex.Message)
            End Try
        End If

        Console.WriteLine("Initializing ASP.NET Application Host...")
        Try
            ' Create the host instance in the ASP.NET AppDomain.
            ' We reference the MyHost class directly, which is defined in ServerLib.dll.
            Dim host As MyHost = CType(ApplicationHost.CreateApplicationHost(GetType(MyHost), "/", physicalDir), MyHost)
            
            ' Start the server listening on the specified port
            host.StartServer(port, physicalDir)
            
            ' Wait for user input if interactive, otherwise run background loop
            If Environment.UserInteractive Then
                Console.WriteLine("Press Enter to stop the server...")
                Console.ReadLine()
            Else
                Console.WriteLine("Non-interactive mode detected. Server is running in background loop...")
                While True
                    System.Threading.Thread.Sleep(5000)
                End While
            End If
        Catch ex As Exception
            Console.WriteLine("Fatal Error: " & ex.ToString())
            If Environment.UserInteractive Then
                Console.WriteLine("Press Enter to exit...")
                Console.ReadLine()
            End If
        End Try
    End Sub
End Module
