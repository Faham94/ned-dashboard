Imports System
Imports System.Collections.Generic
Imports System.Linq

<Serializable>
Public Class AssetItem
    Public Property AssetId As String
    Public Property Description As String
    Public Property Category As String
    Public Property Brand As String
    Public Property ModelNo As String
    Public Property SerialNo As String
    Public Property Section As String
    Public Property Location As String
    Public Property Employee As String
    Public Property BudgetUtilizedFrom As String
    Public Property Supplier As String
    Public Property InvoiceNo As String
    Public Property ContractSchNo As String
    
    Public Property OriginalCost As Decimal
    Public Property CurrentValue As Decimal
    Public Property AccDeprec As Decimal
    Public Property FYOpeningBal As Decimal
    Public Property FYClosingBal As Decimal
    Public Property PurchaseDate As String
    Public Property PurchaseFY As String
    Public Property WarrantyExp As String
    Public Property DepStartDate As String
    Public Property FirstDeprFY As String
    Public Property LastDeprFY As String
    Public Property DisposalDate As String
    Public Property DisposalReason As String
    Public Property Remarks As String
    Public Property Status As String ' "Active" or "Disposed"
    Public Property EnterBy As String
    Public Property EntryDate As String
End Class

Partial Public Class DashboardPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ' 1. Check if user is authenticated
        If Session("CurrentUser") Is Nothing Then
            Response.Redirect("Default.aspx")
        End If

        ' 2. Initialize AssetList session storage (in-memory mock database pattern)
        If Session("AssetList") Is Nothing Then
            Dim initialList As New List(Of AssetItem)()
            
            ' Seed mock data to populate list (9 assets total)
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000001",
                .Description = "Bending Machine",
                .Category = "Industrial Machinery",
                .Brand = "Accurpress",
                .ModelNo = "AP-76-23",
                .SerialNo = "BND-88992",
                .Section = "Heavy Machinery Dept",
                .Location = "Machinery Hall A",
                .Employee = "Prof. Richard Feynman",
                .BudgetUtilizedFrom = "State Lab Grant FY24",
                .Supplier = "Accurpress Tech",
                .InvoiceNo = "INV-7762",
                .ContractSchNo = "MNT-BND-01",
                .OriginalCost = 15000.00D,
                .CurrentValue = 12500.00D,
                .AccDeprec = 2500.00D,
                .FYOpeningBal = 15000.00D,
                .FYClosingBal = 12500.00D,
                .DepStartDate = "2024-03-01",
                .FirstDeprFY = "2023-2024",
                .LastDeprFY = "2028-2029",
                .PurchaseDate = "2024-02-15",
                .PurchaseFY = "2023-2024",
                .WarrantyExp = "2027-02-15",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "Main bending unit, calibrated.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2024-02-15"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000002",
                .Description = "Lathe Machine",
                .Category = "Industrial Machinery",
                .Brand = "Mazak",
                .ModelNo = "QuickTurn 250",
                .SerialNo = "MZK-1122",
                .Section = "Mechanical Engineering Lab",
                .Location = "Room 104 Lab",
                .Employee = "Dr. Robert Goddard",
                .BudgetUtilizedFrom = "University CapEx Fund",
                .Supplier = "Mazak USA",
                .InvoiceNo = "INV-1109",
                .ContractSchNo = "MNT-MZK-88",
                .OriginalCost = 22000.00D,
                .CurrentValue = 18000.00D,
                .AccDeprec = 4000.00D,
                .FYOpeningBal = 22000.00D,
                .FYClosingBal = 18000.00D,
                .DepStartDate = "2024-08-01",
                .FirstDeprFY = "2024-2025",
                .LastDeprFY = "2029-2030",
                .PurchaseDate = "2024-07-10",
                .PurchaseFY = "2024-2025",
                .WarrantyExp = "2029-07-10",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "Precision lathe, high throughput.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2024-07-10"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000003",
                .Description = "Drilling Machine",
                .Category = "Industrial Machinery",
                .Brand = "HP Printer & Mach",
                .ModelNo = "Drill-Pro 50",
                .SerialNo = "DRL-449",
                .Section = "Mechanical Engineering Lab",
                .Location = "Room 104 Lab",
                .Employee = "Office Pool",
                .BudgetUtilizedFrom = "General Budget",
                .Supplier = "Tool Depot",
                .InvoiceNo = "INV-445566",
                .ContractSchNo = "MNT-HP-882",
                .OriginalCost = 8500.00D,
                .CurrentValue = 0.00D,
                .AccDeprec = 8500.00D,
                .FYOpeningBal = 1500.00D,
                .FYClosingBal = 0.00D,
                .DepStartDate = "2021-02-01",
                .FirstDeprFY = "2020-2021",
                .LastDeprFY = "2024-2025",
                .PurchaseDate = "2021-01-20",
                .PurchaseFY = "2020-2021",
                .WarrantyExp = "2024-01-20",
                .DisposalDate = "2025-05-15",
                .DisposalReason = "Accidental structural fracture",
                .Remarks = "Written off after frame cracked.",
                .Status = "Disposed",
                .EnterBy = "system_op",
                .EntryDate = "2021-01-20"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000004",
                .Description = "Dell Latitude Laptop 5420",
                .Category = "Computers & Electronics",
                .Brand = "Dell",
                .ModelNo = "L5420",
                .SerialNo = "DELL-12345",
                .Section = "IT Dept",
                .Location = "IT Support Room",
                .Employee = "Prof. John Doe",
                .BudgetUtilizedFrom = "Department Grant FY25",
                .Supplier = "Dell Premier Services",
                .InvoiceNo = "INV-998877",
                .ContractSchNo = "MNT-2025-01",
                .OriginalCost = 1200.00D,
                .CurrentValue = 900.00D,
                .AccDeprec = 300.00D,
                .FYOpeningBal = 1200.00D,
                .FYClosingBal = 900.00D,
                .DepStartDate = "2025-01-15",
                .FirstDeprFY = "2024-2025",
                .LastDeprFY = "2028-2029",
                .PurchaseDate = "2025-01-10",
                .PurchaseFY = "2024-2025",
                .WarrantyExp = "2028-01-10",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "Excellent working condition.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2025-01-10"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000005",
                .Description = "Ergonomic Desk Chair",
                .Category = "Office Furniture",
                .Brand = "Steelcase",
                .ModelNo = "Gesture",
                .SerialNo = "SC-98765",
                .Section = "Admin Dept",
                .Location = "Office 302",
                .Employee = "Sarah Connor",
                .BudgetUtilizedFrom = "Admin Overhead Fund",
                .Supplier = "Steelcase Retailer",
                .InvoiceNo = "INV-112233",
                .ContractSchNo = "N/A",
                .OriginalCost = 850.00D,
                .CurrentValue = 750.00D,
                .AccDeprec = 100.00D,
                .FYOpeningBal = 850.00D,
                .FYClosingBal = 750.00D,
                .DepStartDate = "2024-07-01",
                .FirstDeprFY = "2024-2025",
                .LastDeprFY = "2029-2030",
                .PurchaseDate = "2024-06-15",
                .PurchaseFY = "2023-2024",
                .WarrantyExp = "2034-06-15",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "Used daily, fully adjustable.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2024-06-15"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000006",
                .Description = "Oscilloscope Pro",
                .Category = "Computers & Electronics",
                .Brand = "Tektronix",
                .ModelNo = "TBS1052B",
                .SerialNo = "TEK-90088",
                .Section = "Electronics Lab",
                .Location = "Lab Room 202",
                .Employee = "Dr. Nikola Tesla",
                .BudgetUtilizedFrom = "Research Grant B",
                .Supplier = "Tektronix Corp",
                .InvoiceNo = "INV-554411",
                .ContractSchNo = "N/A",
                .OriginalCost = 2800.00D,
                .CurrentValue = 2400.00D,
                .AccDeprec = 400.00D,
                .FYOpeningBal = 2800.00D,
                .FYClosingBal = 2400.00D,
                .DepStartDate = "2024-06-01",
                .FirstDeprFY = "2024-2025",
                .LastDeprFY = "2029-2030",
                .PurchaseDate = "2024-05-20",
                .PurchaseFY = "2024-2025",
                .WarrantyExp = "2027-05-20",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "Calibrated Tektronix Oscilloscope.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2024-05-20"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000007",
                .Description = "DeWalt Mitre Saw 12 Inch",
                .Category = "Power Tools",
                .Brand = "DeWalt",
                .ModelNo = "DWS779",
                .SerialNo = "DW-33445",
                .Section = "Woodworking Shop",
                .Location = "Maintenance Workshop",
                .Employee = "Bob Builder",
                .BudgetUtilizedFrom = "Facilities Budget",
                .Supplier = "Home Depot Pro",
                .InvoiceNo = "INV-7865",
                .ContractSchNo = "N/A",
                .OriginalCost = 650.00D,
                .CurrentValue = 450.00D,
                .AccDeprec = 200.00D,
                .FYOpeningBal = 650.00D,
                .FYClosingBal = 450.00D,
                .DepStartDate = "2023-12-01",
                .FirstDeprFY = "2023-2024",
                .LastDeprFY = "2028-2029",
                .PurchaseDate = "2023-11-05",
                .PurchaseFY = "2023-2024",
                .WarrantyExp = "2026-11-05",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "Heavy duty workshop saw.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2023-11-05"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000008",
                .Description = "Office Desk Organizer",
                .Category = "Office Furniture",
                .Brand = "n/a",
                .ModelNo = "ORG-01",
                .SerialNo = "N/A",
                .Section = "Admin Dept",
                .Location = "Main Reception Desk",
                .Employee = "Receptionist",
                .BudgetUtilizedFrom = "General Budget",
                .Supplier = "Local Stationers",
                .InvoiceNo = "INV-902",
                .ContractSchNo = "N/A",
                .OriginalCost = 85.00D,
                .CurrentValue = 75.00D,
                .AccDeprec = 10.00D,
                .FYOpeningBal = 85.00D,
                .FYClosingBal = 75.00D,
                .DepStartDate = "2025-04-01",
                .FirstDeprFY = "2025-2026",
                .LastDeprFY = "2029-2030",
                .PurchaseDate = "2025-03-12",
                .PurchaseFY = "2024-2025",
                .WarrantyExp = "2026-03-12",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "Basic plastic desk organizer.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2025-03-12"
            })
            initialList.Add(New AssetItem() With {
                .AssetId = "0000000009",
                .Description = "HP EliteDesk Desktop PC",
                .Category = "Computers & Electronics",
                .Brand = "HP",
                .ModelNo = "EliteDesk 800",
                .SerialNo = "HP-ED-7788",
                .Section = "IT Dept",
                .Location = "IT Support Room",
                .Employee = "Helpdesk Operator",
                .BudgetUtilizedFrom = "Department Grant FY25",
                .Supplier = "HP Direct",
                .InvoiceNo = "INV-998899",
                .ContractSchNo = "MNT-HP-2025",
                .OriginalCost = 1100.00D,
                .CurrentValue = 950.00D,
                .AccDeprec = 150.00D,
                .FYOpeningBal = 1100.00D,
                .FYClosingBal = 950.00D,
                .DepStartDate = "2025-03-01",
                .FirstDeprFY = "2024-2025",
                .LastDeprFY = "2029-2030",
                .PurchaseDate = "2025-02-28",
                .PurchaseFY = "2024-2025",
                .WarrantyExp = "2028-02-28",
                .DisposalDate = "",
                .DisposalReason = "",
                .Remarks = "IT support agent desktop PC.",
                .Status = "Active",
                .EnterBy = "faham_admin",
                .EntryDate = "2025-02-28"
            })
            Session("AssetList") = initialList
        End If

        Dim assetsList As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))

        If Not IsPostBack Then
            ' 3. Populate university dashboard labels
            lblInstitutionName.Text = "National University of Engineering & Development"
            lblDepartmentName.Text = "Department of Information Technology"
            lblSystemTitle.Text = "Asset Management System"
            lblCopyrightDepartment.Text = "Department of Information Technology"

            ' 4. Populate user profile details
            Dim email As String = Session("CurrentUser").ToString()
            Dim userName As String = If(Session("CurrentUserName") IsNot Nothing, Session("CurrentUserName").ToString(), email.Split("@"c)(0))
            lblUserName.Text = userName

            ' 5. Load first asset or start in "New" mode if empty
            If assetsList.Count > 0 Then
                ViewState("SelectedAssetId") = assetsList(0).AssetId
                ViewState("CurrentMode") = "View"
                LoadAsset(assetsList(0).AssetId)
            Else
                btnNew_Click(Nothing, Nothing)
            End If

            BindAssetList()
        End If
    End Sub

    ''' <summary>
    ''' Clears form fields, generates next asset ID, sets editing state to active.
    ''' </summary>
    Protected Sub btnNew_Click(sender As Object, e As EventArgs)
        ViewState("CurrentMode") = "New"
        ViewState("SelectedAssetId") = Nothing
        ClearForm()
        
        ' Generate next Asset ID (zero-padded 10-digit number)
        Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
        Dim nextIdVal As Integer = 1
        If assets.Count > 0 Then
            Dim maxId As Integer = 0
            For Each a In assets
                Dim currentIdNum As Integer = 0
                If Integer.TryParse(a.AssetId, currentIdNum) Then
                    If currentIdNum > maxId Then
                        maxId = currentIdNum
                    End If
                End If
            Next
            nextIdVal = maxId + 1
        End If
        
        txtAssetId.Text = nextIdVal.ToString("D10")
        SetFormReadOnly(False)
    End Sub

    ''' <summary>
    ''' Enables editing of the currently loaded asset.
    ''' </summary>
    Protected Sub btnEdit_Click(sender As Object, e As EventArgs)
        If ViewState("SelectedAssetId") IsNot Nothing Then
            ViewState("CurrentMode") = "Edit"
            SetFormReadOnly(False)
        Else
            ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('Please select an asset from the Data View panel first to edit.');", True)
        End If
    End Sub

    ''' <summary>
    ''' Deletes currently selected asset from Session and refreshes list.
    ''' </summary>
    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        If ViewState("SelectedAssetId") IsNot Nothing Then
            Dim selectedId As String = ViewState("SelectedAssetId").ToString()
            Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
            Dim assetToDelete As AssetItem = assets.FirstOrDefault(Function(a) a.AssetId = selectedId)
            
            If assetToDelete IsNot Nothing Then
                assets.Remove(assetToDelete)
                Session("AssetList") = assets
            End If
            
            ViewState("SelectedAssetId") = Nothing
            ViewState("CurrentMode") = "View"
            ClearForm()
            BindAssetList()
            
            ' Load first asset in list if exists
            If assets.Count > 0 Then
                LoadAsset(assets(0).AssetId)
            Else
                SetFormReadOnly(True)
            End If
        Else
            ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('Please select an asset to delete.');", True)
        End If
    End Sub

    ''' <summary>
    ''' Validates form and inserts or updates asset record in Session.
    ''' </summary>
    Protected Sub btnSave_Click(sender As Object, e As EventArgs)
        Dim assetId As String = txtAssetId.Text.Trim()
        Dim description As String = txtDescription.Text.Trim()
        Dim category As String = txtCategory.Text.Trim()

        ' Validation of required fields
        If String.IsNullOrEmpty(assetId) OrElse String.IsNullOrEmpty(description) OrElse String.IsNullOrEmpty(category) Then
            ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('Validation Failure: Asset ID, Description, and Category are required fields!');", True)
            Exit Sub
        End If

        Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
        Dim asset As AssetItem = Nothing
        Dim mode As String = If(ViewState("CurrentMode") IsNot Nothing, ViewState("CurrentMode").ToString(), "View")

        If mode = "New" Then
            ' Assert uniqueness
            If assets.Any(Function(a) a.AssetId = assetId) Then
                ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('Conflict: Asset ID already exists!');", True)
                Exit Sub
            End If
            asset = New AssetItem()
            asset.AssetId = assetId
            assets.Add(asset)
        ElseIf mode = "Edit" Then
            If ViewState("SelectedAssetId") IsNot Nothing Then
                Dim selectedId As String = ViewState("SelectedAssetId").ToString()
                asset = assets.FirstOrDefault(Function(a) a.AssetId = selectedId)
            End If
            If asset Is Nothing Then
                ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('Error: Loaded asset record could not be found.');", True)
                Exit Sub
            End If
        End If

        If asset IsNot Nothing Then
            ' Set input properties
            asset.Description = description
            asset.Category = category
            asset.Brand = txtBrand.Text.Trim()
            asset.ModelNo = txtModelNo.Text.Trim()
            asset.SerialNo = txtSerialNo.Text.Trim()
            asset.Section = txtSection.Text.Trim()
            asset.Location = txtLocation.Text.Trim()
            asset.Employee = txtEmployee.Text.Trim()
            asset.BudgetUtilizedFrom = txtBudgetUtilizedFrom.Text.Trim()
            asset.Supplier = txtSupplier.Text.Trim()
            asset.InvoiceNo = txtInvoiceNo.Text.Trim()
            asset.ContractSchNo = txtContractSchNo.Text.Trim()
            
            asset.OriginalCost = SafeDecimal(txtOriginalCost.Text)
            asset.CurrentValue = SafeDecimal(txtCurrentValue.Text)
            asset.AccDeprec = SafeDecimal(txtAccDeprec.Text)
            asset.FYOpeningBal = SafeDecimal(txtFYOpeningBal.Text)
            asset.FYClosingBal = SafeDecimal(txtFYClosingBal.Text)
            
            asset.PurchaseDate = txtPurchaseDate.Text.Trim()
            asset.PurchaseFY = txtPurchaseFY.Text.Trim()
            asset.WarrantyExp = txtWarrantyExp.Text.Trim()
            asset.DepStartDate = txtDepStartDate.Text.Trim()
            asset.FirstDeprFY = txtFirstDeprFY.Text.Trim()
            asset.LastDeprFY = txtLastDeprFY.Text.Trim()
            asset.DisposalDate = txtDisposalDate.Text.Trim()
            asset.DisposalReason = txtDisposalReason.Text.Trim()
            asset.Remarks = txtRemarks.Text.Trim()
            asset.Status = ddlStatus.SelectedValue
            asset.EnterBy = txtEnterBy.Text.Trim()
            asset.EntryDate = txtEntryDate.Text.Trim()

            Session("AssetList") = assets
            ViewState("SelectedAssetId") = asset.AssetId
            ViewState("CurrentMode") = "View"

            SetFormReadOnly(True)
            BindAssetList()
            LoadAsset(asset.AssetId)
        End If
    End Sub

    ''' <summary>
    ''' Cancels current modifications and reverts to view state.
    ''' </summary>
    Protected Sub btnCancel_Click(sender As Object, e As EventArgs)
        Dim mode As String = If(ViewState("CurrentMode") IsNot Nothing, ViewState("CurrentMode").ToString(), "View")
        If mode = "Edit" AndAlso ViewState("SelectedAssetId") IsNot Nothing Then
            LoadAsset(ViewState("SelectedAssetId").ToString())
        Else
            Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
            If assets.Count > 0 Then
                LoadAsset(assets(0).AssetId)
            Else
                ClearForm()
                SetFormReadOnly(True)
            End If
        End If
        ViewState("CurrentMode") = "View"
    End Sub

    ''' <summary>
    ''' Triggers keyword filter search across assets list.
    ''' </summary>
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        BindAssetList()
    End Sub

    ''' <summary>
    ''' Handles row selection inside the Data View repeater control.
    ''' </summary>
    Protected Sub rptAssets_ItemCommand(source As Object, e As Global.System.Web.UI.WebControls.RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim assetId As String = e.CommandArgument.ToString()
            LoadAsset(assetId)
        End If
    End Sub

    ''' <summary>
    ''' Handles signing out of the dashboard.
    ''' </summary>
    Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
        Session("CurrentUser") = Nothing
        Session("CurrentUserName") = Nothing
        Response.Redirect("Default.aspx")
    End Sub

    ' Helpers

    Private Sub LoadAsset(assetId As String)
        Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
        Dim asset As AssetItem = assets.FirstOrDefault(Function(a) a.AssetId = assetId)
        If asset IsNot Nothing Then
            ViewState("SelectedAssetId") = assetId
            ViewState("CurrentMode") = "View"
            PopulateForm(asset)
            SetFormReadOnly(True)
        End If
    End Sub

    Private Sub BindAssetList()
        Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
        Dim search As String = txtSearchQuery.Text.Trim().ToLower()

        If Not String.IsNullOrEmpty(search) Then
            Dim filtered = assets.Where(Function(a) a.AssetId.ToLower().Contains(search) OrElse a.Description.ToLower().Contains(search)).ToList()
            rptAssets.DataSource = filtered
            pnlNoAssets.Visible = (filtered.Count = 0)
        Else
            rptAssets.DataSource = assets
            pnlNoAssets.Visible = (assets.Count = 0)
        End If
        rptAssets.DataBind()
    End Sub

    Private Sub PopulateForm(asset As AssetItem)
        txtAssetId.Text = asset.AssetId
        txtDescription.Text = asset.Description
        txtCategory.Text = asset.Category
        txtBrand.Text = asset.Brand
        txtModelNo.Text = asset.ModelNo
        txtSerialNo.Text = asset.SerialNo
        txtSection.Text = asset.Section
        txtLocation.Text = asset.Location
        txtEmployee.Text = asset.Employee
        txtBudgetUtilizedFrom.Text = asset.BudgetUtilizedFrom
        txtSupplier.Text = asset.Supplier
        txtInvoiceNo.Text = asset.InvoiceNo
        txtContractSchNo.Text = asset.ContractSchNo
        
        txtOriginalCost.Text = asset.OriginalCost.ToString("F2")
        txtCurrentValue.Text = asset.CurrentValue.ToString("F2")
        txtAccDeprec.Text = asset.AccDeprec.ToString("F2")
        txtFYOpeningBal.Text = asset.FYOpeningBal.ToString("F2")
        txtFYClosingBal.Text = asset.FYClosingBal.ToString("F2")
        
        txtDepStartDate.Text = asset.DepStartDate
        txtFirstDeprFY.Text = asset.FirstDeprFY
        txtLastDeprFY.Text = asset.LastDeprFY
        txtPurchaseDate.Text = asset.PurchaseDate
        txtPurchaseFY.Text = asset.PurchaseFY
        txtWarrantyExp.Text = asset.WarrantyExp
        txtDisposalDate.Text = asset.DisposalDate
        txtDisposalReason.Text = asset.DisposalReason
        txtRemarks.Text = asset.Remarks
        txtEnterBy.Text = asset.EnterBy
        txtEntryDate.Text = asset.EntryDate

        If ddlStatus.Items.FindByValue(asset.Status) IsNot Nothing Then
            ddlStatus.SelectedValue = asset.Status
        End If

        UpdateStatusBadge(asset.Status)

        ' Display dynamic QR code using public free API
        imgQRCode.ImageUrl = "https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=" & Server.UrlEncode(asset.AssetId & " | " & asset.Description)
    End Sub

    Private Sub ClearForm()
        txtAssetId.Text = String.Empty
        txtDescription.Text = String.Empty
        txtCategory.Text = String.Empty
        txtBrand.Text = String.Empty
        txtModelNo.Text = String.Empty
        txtSerialNo.Text = String.Empty
        txtSection.Text = String.Empty
        txtLocation.Text = String.Empty
        txtEmployee.Text = String.Empty
        txtBudgetUtilizedFrom.Text = String.Empty
        txtSupplier.Text = String.Empty
        txtInvoiceNo.Text = String.Empty
        txtContractSchNo.Text = String.Empty
        
        txtOriginalCost.Text = "0.00"
        txtCurrentValue.Text = "0.00"
        txtAccDeprec.Text = "0.00"
        txtFYOpeningBal.Text = "0.00"
        txtFYClosingBal.Text = "0.00"
        
        txtDepStartDate.Text = String.Empty
        txtFirstDeprFY.Text = String.Empty
        txtLastDeprFY.Text = String.Empty
        txtPurchaseDate.Text = String.Empty
        txtPurchaseFY.Text = String.Empty
        txtWarrantyExp.Text = String.Empty
        txtDisposalDate.Text = String.Empty
        txtDisposalReason.Text = String.Empty
        txtRemarks.Text = String.Empty
        txtEnterBy.Text = If(Session("CurrentUserName") IsNot Nothing, Session("CurrentUserName").ToString(), "Admin")
        txtEntryDate.Text = DateTime.Now.ToString("yyyy-MM-dd")

        ddlStatus.SelectedValue = "Active"
        UpdateStatusBadge("Active")

        imgQRCode.ImageUrl = "https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=NEW_ASSET"
    End Sub

    Private Sub SetFormReadOnly(isReadOnly As Boolean)
        txtAssetId.ReadOnly = True ' Always read-only because it's auto-generated
        txtDescription.ReadOnly = isReadOnly
        txtCategory.ReadOnly = isReadOnly
        txtBrand.ReadOnly = isReadOnly
        txtModelNo.ReadOnly = isReadOnly
        txtSerialNo.ReadOnly = isReadOnly
        txtSection.ReadOnly = isReadOnly
        txtLocation.ReadOnly = isReadOnly
        txtEmployee.ReadOnly = isReadOnly
        txtBudgetUtilizedFrom.ReadOnly = isReadOnly
        txtSupplier.ReadOnly = isReadOnly
        txtInvoiceNo.ReadOnly = isReadOnly
        txtContractSchNo.ReadOnly = isReadOnly
        
        txtOriginalCost.ReadOnly = isReadOnly
        txtCurrentValue.ReadOnly = isReadOnly
        txtAccDeprec.ReadOnly = isReadOnly
        txtFYOpeningBal.ReadOnly = isReadOnly
        txtFYClosingBal.ReadOnly = isReadOnly
        
        txtDepStartDate.ReadOnly = isReadOnly
        txtFirstDeprFY.ReadOnly = isReadOnly
        txtLastDeprFY.ReadOnly = isReadOnly
        txtPurchaseDate.ReadOnly = isReadOnly
        txtPurchaseFY.ReadOnly = isReadOnly
        txtWarrantyExp.ReadOnly = isReadOnly
        txtDisposalDate.ReadOnly = isReadOnly
        txtDisposalReason.ReadOnly = isReadOnly
        txtRemarks.ReadOnly = isReadOnly
        txtEnterBy.ReadOnly = isReadOnly
        txtEntryDate.ReadOnly = isReadOnly
        
        ddlStatus.Enabled = Not isReadOnly
    End Sub

    Private Sub UpdateStatusBadge(status As String)
        lblStatusText.Text = status
        If status = "Active" Then
            lblStatusText.CssClass = "status-badge-large status-active"
        Else
            lblStatusText.CssClass = "status-badge-large status-disposed"
        End If
    End Sub

    Private Function SafeDecimal(text As String) As Decimal
        Dim val As Decimal = 0
        If Decimal.TryParse(text.Replace("$", "").Replace(",", "").Trim(), val) Then
            Return val
        End If
        Return 0
    End Function

    Public Property IsSearchModalOpen As Boolean
        Get
            If ViewState("IsSearchModalOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsSearchModalOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsSearchModalOpen") = value
        End Set
    End Property

    Protected Sub btnSearchOpen_Click(sender As Object, e As EventArgs)
        txtModalAssetId.Text = String.Empty
        txtModalPurchaseDate.Text = String.Empty
        txtModalBrand.Text = String.Empty
        txtModalCategory.Text = String.Empty
        txtModalSection.Text = String.Empty
        
        BindModalAssetList()
        IsSearchModalOpen = True
    End Sub

    Protected Sub btnModalSearch_Click(sender As Object, e As EventArgs)
        BindModalAssetList()
        IsSearchModalOpen = True
    End Sub

    Protected Sub btnCloseModal_Click(sender As Object, e As EventArgs)
        IsSearchModalOpen = False
    End Sub

    Protected Sub rptModalResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim assetId As String = e.CommandArgument.ToString()
            LoadAsset(assetId)
            IsSearchModalOpen = False
        End If
    End Sub

    Private Sub BindModalAssetList()
        Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
        If assets Is Nothing Then
            assets = New List(Of AssetItem)()
        End If

        Dim filtered As IEnumerable(Of AssetItem) = assets

        ' 1. Asset ID filter (partial contains)
        Dim searchId As String = txtModalAssetId.Text.Trim()
        If Not String.IsNullOrEmpty(searchId) Then
            filtered = filtered.Where(Function(a) a.AssetId.IndexOf(searchId, StringComparison.OrdinalIgnoreCase) >= 0)
        End If

        ' 2. Brand filter (partial contains)
        Dim searchBrand As String = txtModalBrand.Text.Trim()
        If Not String.IsNullOrEmpty(searchBrand) Then
            filtered = filtered.Where(Function(a) a.Brand.IndexOf(searchBrand, StringComparison.OrdinalIgnoreCase) >= 0)
        End If

        ' 3. Category filter (partial contains)
        Dim searchCategory As String = txtModalCategory.Text.Trim()
        If Not String.IsNullOrEmpty(searchCategory) Then
            filtered = filtered.Where(Function(a) a.Category.IndexOf(searchCategory, StringComparison.OrdinalIgnoreCase) >= 0)
        End If

        ' 4. Section filter (partial contains)
        Dim searchSection As String = txtModalSection.Text.Trim()
        If Not String.IsNullOrEmpty(searchSection) Then
            filtered = filtered.Where(Function(a) a.Section.IndexOf(searchSection, StringComparison.OrdinalIgnoreCase) >= 0)
        End If

        ' 5. Purchase Date filter (exact date matching, parsed using dd/MM/yyyy)
        Dim searchDateStr As String = txtModalPurchaseDate.Text.Trim()
        If Not String.IsNullOrEmpty(searchDateStr) Then
            Dim parsedDate As DateTime
            If DateTime.TryParseExact(searchDateStr, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, parsedDate) Then
                filtered = filtered.Where(Function(a)
                    Dim assetDate As DateTime
                    If DateTime.TryParse(a.PurchaseDate, assetDate) Then
                        Return assetDate.Date = parsedDate.Date
                    End If
                    Return False
                End Function)
            End If
        End If

        Dim resultList = filtered.ToList()
        rptModalResults.DataSource = resultList
        rptModalResults.DataBind()

        pnlNoModalResults.Visible = (resultList.Count = 0)
    End Sub

    ' Stubs for legacy task control compiler-friendliness
    Protected Sub btnAddTask_Click(sender As Object, e As EventArgs)
        ' Legacy handler stub (no functional implementation needed)
    End Sub

    Protected Sub rptTasks_ItemCommand(source As Object, e As Global.System.Web.UI.WebControls.RepeaterCommandEventArgs)
        ' Legacy handler stub (no functional implementation needed)
    End Sub
End Class
