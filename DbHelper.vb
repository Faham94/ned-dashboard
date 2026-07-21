Imports System.Configuration
Imports Oracle.ManagedDataAccess.Client

''' <summary>
''' Centralised Oracle database helper.
''' All pages/modules that need Oracle access should call
'''   DbHelper.GetConnection()
''' to receive an already-opened OracleConnection.
'''
''' IMPORTANT: Always dispose the connection when done:
'''   Using conn As OracleConnection = DbHelper.GetConnection()
'''       Dim cmd As New OracleCommand("SELECT ...", conn)
'''       ...
'''   End Using
''' </summary>
Public Module DbHelper

    ''' <summary>
    ''' Opens and returns an OracleConnection using the
    ''' "OracleDbConnection" connection string from web.config.
    ''' The caller is responsible for disposing (closing) the connection.
    ''' </summary>
    Public Function GetConnection() As OracleConnection
        Dim connStr As String = ConfigurationManager.ConnectionStrings("OracleDbConnection").ConnectionString
        Dim conn As New OracleConnection(connStr)
        conn.Open()
        Return conn
    End Function

End Module
