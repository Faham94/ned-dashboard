Imports System
Imports System.Net

Module DiagTest
    Sub Main()
        Console.WriteLine("Testing HttpListener on port 8080...")
        Try
            Dim listener As New HttpListener()
            listener.Prefixes.Add("http://localhost:8080/")
            listener.Start()
            Console.WriteLine("SUCCESS - listening on http://localhost:8080/")
            Console.WriteLine("Press Enter to stop...")
            Console.ReadLine()
            listener.Stop()
        Catch ex As Exception
            Console.WriteLine("FAILED: " & ex.GetType().Name)
            Console.WriteLine(ex.Message)
        End Try
    End Sub
End Module
