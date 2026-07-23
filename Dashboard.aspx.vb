Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports Oracle.ManagedDataAccess.Client

<Serializable>
Public Class CategoryItem
    Public Property CategoryId As String
    Public Property CategoryName As String
End Class

<Serializable>
Public Class BrandItem
    Public Property BrandId As String
    Public Property BrandName As String
End Class

<Serializable>
Public Class SectionItem
    Public Property SectionId As String
    Public Property Department As String
    Public Property SectionName As String
End Class

<Serializable>
Public Class BudgetItem
    Public Property BudgetAccountId As String
    Public Property BudgetAccountName As String
End Class

<Serializable>
Public Class SupplierItem
    Public Property SupplierId As String
    Public Property SupplierName As String
End Class

<Serializable>
Public Class FinancialYearItem
    Public Property FyId As String
    Public Property FyLabel As String
End Class

<Serializable>
Public Class DisposalReasonItem
    Public Property DisposalReasonId As String
    Public Property DisposalReasonName As String
End Class

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
        ' ── Always close every lookup modal first so no popup re-renders ──────
        CloseAllLookupModals()

        Dim description As String = txtDescription.Text.Trim()
        Dim category As String = txtCategory.Text.Trim()
        Dim brand As String = txtBrand.Text.Trim()
        Dim section As String = txtSection.Text.Trim()
        Dim budget As String = txtBudgetUtilizedFrom.Text.Trim()

        ' Validation of required fields (Supplier intentionally excluded from DB insert but still required for UX)
        Dim missingList As New List(Of String)()
        If String.IsNullOrEmpty(category) Then missingList.Add("Asset Category")
        If String.IsNullOrEmpty(brand) Then missingList.Add("Brand")
        If String.IsNullOrEmpty(section) Then missingList.Add("Section")
        If String.IsNullOrEmpty(budget) Then missingList.Add("Budget Utilized From")

        If missingList.Count > 0 Then
            lblFormMessage.Text = "Please fill " & String.Join(", ", missingList) & "."
            lblFormMessage.CssClass = "msg-label error-msg"
            lblFormMessage.Style("display") = "block"
            lblFormMessage.Visible = True
            Exit Sub
        End If

        ' Validate Purchase Date format (server-side check)
        Dim purchaseDate As String = txtPurchaseDate.Text.Trim()
        If Not String.IsNullOrEmpty(purchaseDate) Then
            Dim parsedDate As DateTime
            If Not DateTime.TryParseExact(purchaseDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, parsedDate) Then
                lblFormMessage.Text = "Please enter a valid date (DD/MM/YYYY)"
                lblFormMessage.CssClass = "msg-label error-msg"
                lblFormMessage.Style("display") = "block"
                lblFormMessage.Visible = True
                Exit Sub
            End If
        End If

        ' Validate Warranty Exp format (server-side check)
        Dim warrantyExp As String = txtWarrantyExp.Text.Trim()
        If Not String.IsNullOrEmpty(warrantyExp) Then
            Dim parsedDate As DateTime
            If Not DateTime.TryParseExact(warrantyExp, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, parsedDate) Then
                lblFormMessage.Text = "Please enter a valid date (DD/MM/YYYY)"
                lblFormMessage.CssClass = "msg-label error-msg"
                lblFormMessage.Style("display") = "block"
                lblFormMessage.Visible = True
                Exit Sub
            End If
        End If

        lblFormMessage.Text = String.Empty
        lblFormMessage.Style("display") = "none"

        Dim assets As List(Of AssetItem) = CType(Session("AssetList"), List(Of AssetItem))
        Dim mode As String = If(ViewState("CurrentMode") IsNot Nothing, ViewState("CurrentMode").ToString(), "View")

        If mode = "New" Then
            ' ── New mode: perform real Oracle INSERT ──────────────────────────
            Try
                Using conn As OracleConnection = DbHelper.GetConnection()

                    ' 1. Generate next ASSET_ID
                    Dim newAssetId As Long
                    Using cmd As New OracleCommand("SELECT NVL(MAX(ASSET_ID), 0) + 1 FROM ASSET_INFORMATION", conn)
                        newAssetId = Convert.ToInt64(cmd.ExecuteScalar())
                    End Using
                    Dim assetTag As String = newAssetId.ToString().PadLeft(10, "0"c)

                    ' 2. Look up BRAND_ID (nullable)
                    Dim brandId As Object = DBNull.Value
                    If Not String.IsNullOrEmpty(brand) Then
                        Using cmd As New OracleCommand("SELECT BRAND_ID FROM M_BRANDS WHERE UPPER(BRAND_NAME) = UPPER(:name)", conn)
                            cmd.BindByName = True
                            cmd.Parameters.Add("name", OracleDbType.Varchar2).Value = brand
                            Dim result As Object = cmd.ExecuteScalar()
                            If result IsNot Nothing AndAlso result IsNot DBNull.Value Then
                                brandId = result
                            Else
                                lblFormMessage.Text = "Brand """ & brand & """ not found. Please select a valid brand using the lookup."
                                lblFormMessage.CssClass = "msg-label error-msg"
                                lblFormMessage.Style("display") = "block"
                                lblFormMessage.Visible = True
                                Exit Sub
                            End If
                        End Using
                    End If

                    ' 3. Look up BUDGET_UTILIZING_ACC_ID (NOT NULL)
                    Dim budgetId As Object = DBNull.Value
                    Using cmd As New OracleCommand("SELECT BUDGET_UTILIZING_ACC_ID FROM M_BUDGET_UTILIZED_ACC WHERE UPPER(BUDGET_UTILIZING_ACC_NAME) = UPPER(:name)", conn)
                        cmd.BindByName = True
                        cmd.Parameters.Add("name", OracleDbType.Varchar2).Value = budget
                        Dim result As Object = cmd.ExecuteScalar()
                        If result IsNot Nothing AndAlso result IsNot DBNull.Value Then
                            budgetId = result
                        Else
                            lblFormMessage.Text = "Budget account """ & budget & """ not found. Please select a valid account using the lookup."
                            lblFormMessage.CssClass = "msg-label error-msg"
                            lblFormMessage.Style("display") = "block"
                            lblFormMessage.Visible = True
                            Exit Sub
                        End If
                    End Using

                    ' 4. Look up CATEGORY_ID (NOT NULL)
                    Dim categoryId As Object = DBNull.Value
                    Using cmd As New OracleCommand("SELECT CATEGORY_ID FROM M_CATEGORY WHERE UPPER(CATEGORY) = UPPER(:name)", conn)
                        cmd.BindByName = True
                        cmd.Parameters.Add("name", OracleDbType.Varchar2).Value = category
                        Dim result As Object = cmd.ExecuteScalar()
                        If result IsNot Nothing AndAlso result IsNot DBNull.Value Then
                            categoryId = result
                        Else
                            lblFormMessage.Text = "Category """ & category & """ not found. Please select a valid category using the lookup."
                            lblFormMessage.CssClass = "msg-label error-msg"
                            lblFormMessage.Style("display") = "block"
                            lblFormMessage.Visible = True
                            Exit Sub
                        End If
                    End Using

                    ' 5. Look up SECTION_ID (NOT NULL)
                    Dim sectionId As Object = DBNull.Value
                    Using cmd As New OracleCommand("SELECT SECTION_ID FROM M_SECTION WHERE UPPER(SECTION) = UPPER(:name)", conn)
                        cmd.BindByName = True
                        cmd.Parameters.Add("name", OracleDbType.Varchar2).Value = section
                        Dim result As Object = cmd.ExecuteScalar()
                        If result IsNot Nothing AndAlso result IsNot DBNull.Value Then
                            sectionId = result
                        Else
                            lblFormMessage.Text = "Section """ & section & """ not found. Please select a valid section using the lookup."
                            lblFormMessage.CssClass = "msg-label error-msg"
                            lblFormMessage.Style("display") = "block"
                            lblFormMessage.Visible = True
                            Exit Sub
                        End If
                    End Using

                    ' 6. Look up STATUS_ID (NOT NULL) — dropdown uses text like "Active", "Disposed"
                    Dim statusText As String = ddlStatus.SelectedValue
                    Dim statusId As Object = DBNull.Value
                    Using cmd As New OracleCommand("SELECT STATUS_ID FROM M_STATUS WHERE UPPER(STATUS_TYPE) = UPPER(:name)", conn)
                        cmd.BindByName = True
                        cmd.Parameters.Add("name", OracleDbType.Varchar2).Value = statusText
                        Dim result As Object = cmd.ExecuteScalar()
                        If result IsNot Nothing AndAlso result IsNot DBNull.Value Then
                            statusId = result
                        Else
                            statusId = 1 ' Default to Active if lookup fails
                        End If
                    End Using

                    ' 7. Parse dates
                    Dim purchaseDateVal As Object = DBNull.Value
                    If Not String.IsNullOrEmpty(purchaseDate) Then
                        Dim dt As DateTime
                        If DateTime.TryParseExact(purchaseDate, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
                            purchaseDateVal = dt
                        End If
                    End If
                    If purchaseDateVal Is DBNull.Value Then
                        purchaseDateVal = DateTime.Today   ' PURCHASE_DATE is NOT NULL — default to today
                    End If

                    Dim warrantyDateVal As Object = DBNull.Value
                    If Not String.IsNullOrEmpty(warrantyExp) Then
                        Dim dt As DateTime
                        If DateTime.TryParseExact(warrantyExp, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
                            warrantyDateVal = dt
                        End If
                    End If

                    ' 8. Resolve ORIGINAL_COST and LOCATION_ROOM
                    Dim originalCost As Decimal = SafeDecimal(txtOriginalCost.Text)
                    Dim locationRoom As String = txtLocation.Text.Trim()
                    If String.IsNullOrEmpty(locationRoom) Then locationRoom = "N/A"

                    ' 9. Execute parameterized INSERT
                    Dim insertSql As String =
                        "INSERT INTO ASSET_INFORMATION " &
                        "(ASSET_ID, ASSET_TAG, ASSET_NAME, ITEM_SERIAL_NO, MODEL_NO, " &
                        " BRAND_ID, BUDGET_UTILIZING_ACC_ID, ORIGINAL_COST, PURCHASE_DATE, " &
                        " WARRANTY_EXPIRY_DATE, CATEGORY_ID, SECTION_ID, EMP_NAME, " &
                        " LOCATION_ROOM, STATUS_ID, ORGANIZATION_ID) " &
                        "VALUES " &
                        "(:p_asset_id, :p_asset_tag, :p_asset_name, :p_serial_no, :p_model_no, " &
                        " :p_brand_id, :p_budget_id, :p_original_cost, :p_purchase_date, " &
                        " :p_warranty_date, :p_category_id, :p_section_id, :p_emp_name, " &
                        " :p_location_room, :p_status_id, :p_org_id)"

                    Using cmd As New OracleCommand(insertSql, conn)
                        cmd.BindByName = True
                        cmd.Parameters.Add("p_asset_id", OracleDbType.Int64).Value = newAssetId
                        cmd.Parameters.Add("p_asset_tag", OracleDbType.Varchar2).Value = assetTag
                        cmd.Parameters.Add("p_asset_name", OracleDbType.Varchar2).Value = If(String.IsNullOrEmpty(description), assetTag, description)
                        cmd.Parameters.Add("p_serial_no", OracleDbType.Varchar2).Value = If(String.IsNullOrEmpty(txtSerialNo.Text.Trim()), CType(DBNull.Value, Object), CType(txtSerialNo.Text.Trim(), Object))
                        cmd.Parameters.Add("p_model_no", OracleDbType.Varchar2).Value = If(String.IsNullOrEmpty(txtModelNo.Text.Trim()), CType(DBNull.Value, Object), CType(txtModelNo.Text.Trim(), Object))
                        cmd.Parameters.Add("p_brand_id", OracleDbType.Int64).Value = brandId
                        cmd.Parameters.Add("p_budget_id", OracleDbType.Int64).Value = budgetId
                        cmd.Parameters.Add("p_original_cost", OracleDbType.Decimal).Value = originalCost
                        cmd.Parameters.Add("p_purchase_date", OracleDbType.Date).Value = purchaseDateVal
                        cmd.Parameters.Add("p_warranty_date", OracleDbType.Date).Value = warrantyDateVal
                        cmd.Parameters.Add("p_category_id", OracleDbType.Int64).Value = categoryId
                        cmd.Parameters.Add("p_section_id", OracleDbType.Int64).Value = sectionId
                        cmd.Parameters.Add("p_emp_name", OracleDbType.Varchar2).Value = If(String.IsNullOrEmpty(txtEmployee.Text.Trim()), CType(DBNull.Value, Object), CType(txtEmployee.Text.Trim(), Object))
                        cmd.Parameters.Add("p_location_room", OracleDbType.Varchar2).Value = locationRoom
                        cmd.Parameters.Add("p_status_id", OracleDbType.Int64).Value = statusId
                        cmd.Parameters.Add("p_org_id", OracleDbType.Int64).Value = 1   ' Default org
                        cmd.ExecuteNonQuery()
                    End Using

                    ' 10. Add to in-memory session list so the Data View updates immediately
                    Dim newAsset As New AssetItem()
                    newAsset.AssetId = assetTag
                    newAsset.Description = If(String.IsNullOrEmpty(description), assetTag, description)
                    newAsset.Category = category
                    newAsset.Brand = brand
                    newAsset.ModelNo = txtModelNo.Text.Trim()
                    newAsset.SerialNo = txtSerialNo.Text.Trim()
                    newAsset.Section = section
                    newAsset.Location = locationRoom
                    newAsset.Employee = txtEmployee.Text.Trim()
                    newAsset.BudgetUtilizedFrom = budget
                    newAsset.Supplier = txtSupplier.Text.Trim()
                    newAsset.OriginalCost = originalCost
                    newAsset.PurchaseDate = purchaseDate
                    newAsset.WarrantyExp = warrantyExp
                    newAsset.Status = statusText
                    assets.Add(newAsset)
                    Session("AssetList") = assets

                    ViewState("SelectedAssetId") = assetTag
                    ViewState("CurrentMode") = "View"
                    SetFormReadOnly(True)
                    BindAssetList()
                    LoadAsset(assetTag)

                    ' Write success message AFTER LoadAsset() so it is not cleared
                    lblFormMessage.Text = "Asset """ & assetTag & """ saved successfully."
                    lblFormMessage.CssClass = "msg-label success-msg"
                    lblFormMessage.Style("display") = "block"
                    lblFormMessage.Visible = True
                End Using

            Catch ex As Exception
                lblFormMessage.Text = "Database error: " & ex.Message
                lblFormMessage.CssClass = "msg-label error-msg"
                lblFormMessage.Style("display") = "block"
                lblFormMessage.Visible = True
            End Try

        ElseIf mode = "Edit" Then
            Dim asset As AssetItem = Nothing
            If ViewState("SelectedAssetId") IsNot Nothing Then
                Dim selectedId As String = ViewState("SelectedAssetId").ToString()
                asset = assets.FirstOrDefault(Function(a) a.AssetId = selectedId)
            End If
            If asset Is Nothing Then
                ClientScript.RegisterStartupScript(Me.GetType(), "alert", "alert('Error: Loaded asset record could not be found.');", True)
                Exit Sub
            End If

            ' Update in-memory session list (Edit mode does not yet write to DB)
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
            asset.PurchaseDate = txtPurchaseDate.Text.Trim()
            asset.PurchaseFY = txtPurchaseFY.Text.Trim()
            asset.WarrantyExp = txtWarrantyExp.Text.Trim()
            asset.DepStartDate = txtDepStartDate.Text.Trim()
            asset.DisposalDate = txtDisposalDate.Text.Trim()
            asset.DisposalReason = txtDisposalReason.Text.Trim()
            asset.Remarks = txtRemarks.Text.Trim()
            asset.Status = ddlStatus.SelectedValue
            asset.EnterBy = txtEnterBy.Text.Trim()
            asset.EntryDate = txtEntryDate.Text.Trim()

            Session("AssetList") = assets
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
        If assets Is Nothing Then assets = New List(Of AssetItem)()
        Dim search As String = txtSearchQuery.Text.Trim().ToLower()

        Dim query = assets.AsEnumerable()
        If Not String.IsNullOrEmpty(search) Then
            query = query.Where(Function(a) a.AssetId.ToLower().Contains(search) OrElse a.Description.ToLower().Contains(search))
        End If

        Dim filteredList = query.OrderBy(Function(a) a.AssetId).ToList()
        rptAssets.DataSource = filteredList
        pnlNoAssets.Visible = (filteredList.Count = 0)
        rptAssets.DataBind()
    End Sub

    Private Sub PopulateForm(asset As AssetItem)
        lblFormMessage.Text = String.Empty
        lblFormMessage.Style("display") = "none"
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
        txtPurchaseDate.Text = FormatToDisplayDate(asset.PurchaseDate)
        txtPurchaseFY.Text = asset.PurchaseFY
        txtWarrantyExp.Text = FormatToDisplayDate(asset.WarrantyExp)
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
        lblFormMessage.Text = String.Empty
        lblFormMessage.Style("display") = "none"
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
        txtCurrentValue.ReadOnly = True
        txtAccDeprec.ReadOnly = True
        txtFYOpeningBal.ReadOnly = True
        txtFYClosingBal.ReadOnly = True
        
        txtDepStartDate.ReadOnly = isReadOnly
        txtFirstDeprFY.ReadOnly = True
        txtLastDeprFY.ReadOnly = True
        txtPurchaseDate.ReadOnly = isReadOnly
        txtPurchaseFY.ReadOnly = isReadOnly
        txtWarrantyExp.ReadOnly = isReadOnly
        txtDisposalDate.ReadOnly = isReadOnly
        txtDisposalReason.ReadOnly = isReadOnly
        txtRemarks.ReadOnly = isReadOnly
        txtEnterBy.ReadOnly = isReadOnly
        txtEntryDate.ReadOnly = isReadOnly
        
        ddlStatus.Enabled = Not isReadOnly
        
        ' Hide Asset Status box and QR / Print Tag section in New mode
        Dim mode As String = If(ViewState("CurrentMode") IsNot Nothing, ViewState("CurrentMode").ToString(), "View")
        If mode = "New" Then
            divAssetTagBox.Visible = False
        Else
            divAssetTagBox.Visible = True
        End If
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

    Private Function FormatToDisplayDate(dbDateStr As String) As String
        If String.IsNullOrEmpty(dbDateStr) Then Return String.Empty
        Dim dt As DateTime
        If DateTime.TryParseExact(dbDateStr, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
            Return dt.ToString("dd/MM/yyyy")
        End If
        If DateTime.TryParseExact(dbDateStr, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
            Return dt.ToString("dd/MM/yyyy")
        End If
        If DateTime.TryParse(dbDateStr, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
            Return dt.ToString("dd/MM/yyyy")
        End If
        Return dbDateStr
    End Function

    Private Function SafeParseDate(dateStr As String) As DateTime?
        If String.IsNullOrEmpty(dateStr) Then Return Nothing
        Dim dt As DateTime
        If DateTime.TryParseExact(dateStr, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
            Return dt
        End If
        If DateTime.TryParseExact(dateStr, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
            Return dt
        End If
        If DateTime.TryParse(dateStr, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, dt) Then
            Return dt
        End If
        Return Nothing
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

    Private Sub CloseAllLookupModals()
        IsSearchModalOpen = False
        IsCategoryLookupOpen = False
        IsBrandLookupOpen = False
        IsSectionLookupOpen = False
        IsBudgetLookupOpen = False
        IsSupplierLookupOpen = False
        IsPurchaseFYLookupOpen = False
        IsFirstDeprFYLookupOpen = False
        IsLastDeprFYLookupOpen = False
        IsDisposalReasonLookupOpen = False
    End Sub

    Protected Sub btnSearchOpen_Click(sender As Object, e As EventArgs)
        CloseAllLookupModals()
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
                    Dim assetDate As DateTime? = SafeParseDate(a.PurchaseDate)
                    If assetDate.HasValue Then
                        Return assetDate.Value.Date = parsedDate.Date
                    End If
                    Return False
                End Function)
            End If
        End If

        Dim resultList = filtered.OrderBy(Function(a) a.AssetId).ToList()
        rptModalResults.DataSource = resultList
        rptModalResults.DataBind()

        pnlNoModalResults.Visible = (resultList.Count = 0)
    End Sub

    ' ── Category Lookup Modal Logic ─────────────────────────────────────
    Public Property IsCategoryLookupOpen As Boolean
        Get
            If ViewState("IsCategoryLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsCategoryLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsCategoryLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenCategoryLookup_Click(sender As Object, e As EventArgs)
        If txtCategory.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtCategorySearch.Text = String.Empty
        BindCategoryLookupList(String.Empty)
        IsCategoryLookupOpen = True
    End Sub

    Protected Sub btnCategorySearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtCategorySearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtCategorySearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtCategorySearch.UniqueID).Trim()
        End If
        txtCategorySearch.Text = prefix
        BindCategoryLookupList(prefix)
        IsCategoryLookupOpen = True
    End Sub

    Protected Sub btnCloseCategoryLookup_Click(sender As Object, e As EventArgs)
        IsCategoryLookupOpen = False
    End Sub

    Protected Sub rptCategoryResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedCategory As String = e.CommandArgument.ToString()
            txtCategory.Text = selectedCategory
            IsCategoryLookupOpen = False
        End If
    End Sub

    Private Sub BindCategoryLookupList(prefix As String)
        lblCategoryError.Visible = False
        pnlNoCategoryResults.Visible = False
        Dim list As New List(Of CategoryItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT CATEGORY_ID, CATEGORY FROM M_CATEGORY ORDER BY CATEGORY_ID ASC"
                Else
                    sql = "SELECT CATEGORY_ID, CATEGORY FROM M_CATEGORY WHERE UPPER(CATEGORY) LIKE UPPER(:prefix) ORDER BY CATEGORY_ID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New CategoryItem() With {
                                .CategoryId = If(reader("CATEGORY_ID") IsNot DBNull.Value, reader("CATEGORY_ID").ToString(), ""),
                                .CategoryName = If(reader("CATEGORY") IsNot DBNull.Value, reader("CATEGORY").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptCategoryResults.DataSource = list
            rptCategoryResults.DataBind()

            If list.Count = 0 Then
                pnlNoCategoryResults.Visible = True
            End If
        Catch ex As Exception
            lblCategoryError.Text = "Unable to load categories"
            lblCategoryError.Visible = True
            rptCategoryResults.DataSource = Nothing
            rptCategoryResults.DataBind()
        End Try
    End Sub

    ' ── Brand Lookup Modal Logic ────────────────────────────────────────
    Public Property IsBrandLookupOpen As Boolean
        Get
            If ViewState("IsBrandLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsBrandLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsBrandLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenBrandLookup_Click(sender As Object, e As EventArgs)
        If txtBrand.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtBrandSearch.Text = String.Empty
        BindBrandLookupList(String.Empty)
        IsBrandLookupOpen = True
    End Sub

    Protected Sub btnBrandSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtBrandSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtBrandSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtBrandSearch.UniqueID).Trim()
        End If
        txtBrandSearch.Text = prefix
        BindBrandLookupList(prefix)
        IsBrandLookupOpen = True
    End Sub

    Protected Sub btnCloseBrandLookup_Click(sender As Object, e As EventArgs)
        IsBrandLookupOpen = False
    End Sub

    Protected Sub rptBrandResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedBrand As String = e.CommandArgument.ToString()
            txtBrand.Text = selectedBrand
            IsBrandLookupOpen = False
        End If
    End Sub

    Private Sub BindBrandLookupList(prefix As String)
        lblBrandError.Visible = False
        pnlNoBrandResults.Visible = False
        Dim list As New List(Of BrandItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT BRAND_ID, BRAND_NAME FROM M_BRANDS ORDER BY BRAND_ID ASC"
                Else
                    sql = "SELECT BRAND_ID, BRAND_NAME FROM M_BRANDS WHERE UPPER(BRAND_NAME) LIKE UPPER(:prefix) ORDER BY BRAND_ID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New BrandItem() With {
                                .BrandId = If(reader("BRAND_ID") IsNot DBNull.Value, reader("BRAND_ID").ToString(), ""),
                                .BrandName = If(reader("BRAND_NAME") IsNot DBNull.Value, reader("BRAND_NAME").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptBrandResults.DataSource = list
            rptBrandResults.DataBind()

            If list.Count = 0 Then
                pnlNoBrandResults.Visible = True
            End If
        Catch ex As Exception
            lblBrandError.Text = "Unable to load brands"
            lblBrandError.Visible = True
            rptBrandResults.DataSource = Nothing
            rptBrandResults.DataBind()
        End Try
    End Sub

    ' ── Section Lookup Modal Logic ──────────────────────────────────────
    Public Property IsSectionLookupOpen As Boolean
        Get
            If ViewState("IsSectionLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsSectionLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsSectionLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenSectionLookup_Click(sender As Object, e As EventArgs)
        If txtSection.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtSectionSearch.Text = String.Empty
        BindSectionLookupList(String.Empty)
        IsSectionLookupOpen = True
    End Sub

    Protected Sub btnSectionSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtSectionSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtSectionSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtSectionSearch.UniqueID).Trim()
        End If
        txtSectionSearch.Text = prefix
        BindSectionLookupList(prefix)
        IsSectionLookupOpen = True
    End Sub

    Protected Sub btnCloseSectionLookup_Click(sender As Object, e As EventArgs)
        IsSectionLookupOpen = False
    End Sub

    Protected Sub rptSectionResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedSection As String = e.CommandArgument.ToString()
            txtSection.Text = selectedSection
            IsSectionLookupOpen = False
        End If
    End Sub

    Private Sub BindSectionLookupList(prefix As String)
        lblSectionError.Visible = False
        pnlNoSectionResults.Visible = False
        Dim list As New List(Of SectionItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT s.SECTION_ID, d.DEPT, s.SECTION " &
                          "FROM M_SECTION s " &
                          "INNER JOIN M_DEPARTMENT d ON s.DEPT_ID = d.DEPT_ID " &
                          "AND s.ORGANIZATION_ID = d.ORGANIZATION_ID " &
                          "ORDER BY d.DEPT_ID"
                Else
                    sql = "SELECT s.SECTION_ID, d.DEPT, s.SECTION " &
                          "FROM M_SECTION s " &
                          "INNER JOIN M_DEPARTMENT d ON s.DEPT_ID = d.DEPT_ID " &
                          "AND s.ORGANIZATION_ID = d.ORGANIZATION_ID " &
                          "WHERE UPPER(s.SECTION) LIKE UPPER(:prefix) || '%' " &
                          "ORDER BY d.DEPT_ID"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim()
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New SectionItem() With {
                                .SectionId = If(reader("SECTION_ID") IsNot DBNull.Value, reader("SECTION_ID").ToString(), ""),
                                .Department = If(reader("DEPT") IsNot DBNull.Value, reader("DEPT").ToString(), ""),
                                .SectionName = If(reader("SECTION") IsNot DBNull.Value, reader("SECTION").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptSectionResults.DataSource = list
            rptSectionResults.DataBind()

            If list.Count = 0 Then
                pnlNoSectionResults.Visible = True
            End If
        Catch ex As Exception
            lblSectionError.Text = "Unable to load sections"
            lblSectionError.Visible = True
            rptSectionResults.DataSource = Nothing
            rptSectionResults.DataBind()
        End Try
    End Sub

    ' ── Budget Utilized From Lookup Modal Logic ─────────────────────────
    Public Property IsBudgetLookupOpen As Boolean
        Get
            If ViewState("IsBudgetLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsBudgetLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsBudgetLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenBudgetLookup_Click(sender As Object, e As EventArgs)
        If txtBudgetUtilizedFrom.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtBudgetSearch.Text = String.Empty
        BindBudgetLookupList(String.Empty)
        IsBudgetLookupOpen = True
    End Sub

    Protected Sub btnBudgetSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtBudgetSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtBudgetSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtBudgetSearch.UniqueID).Trim()
        End If
        txtBudgetSearch.Text = prefix
        BindBudgetLookupList(prefix)
        IsBudgetLookupOpen = True
    End Sub

    Protected Sub btnCloseBudgetLookup_Click(sender As Object, e As EventArgs)
        IsBudgetLookupOpen = False
    End Sub

    Protected Sub rptBudgetResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedBudget As String = e.CommandArgument.ToString()
            txtBudgetUtilizedFrom.Text = selectedBudget
            IsBudgetLookupOpen = False
        End If
    End Sub

    Private Sub BindBudgetLookupList(prefix As String)
        lblBudgetError.Visible = False
        pnlNoBudgetResults.Visible = False
        Dim list As New List(Of BudgetItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT BUDGET_UTILIZING_ACC_ID, BUDGET_UTILIZING_ACC_NAME FROM M_BUDGET_UTILIZED_ACC ORDER BY BUDGET_UTILIZING_ACC_ID ASC"
                Else
                    sql = "SELECT BUDGET_UTILIZING_ACC_ID, BUDGET_UTILIZING_ACC_NAME FROM M_BUDGET_UTILIZED_ACC WHERE UPPER(BUDGET_UTILIZING_ACC_NAME) LIKE UPPER(:prefix) ORDER BY BUDGET_UTILIZING_ACC_ID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New BudgetItem() With {
                                .BudgetAccountId = If(reader("BUDGET_UTILIZING_ACC_ID") IsNot DBNull.Value, reader("BUDGET_UTILIZING_ACC_ID").ToString(), ""),
                                .BudgetAccountName = If(reader("BUDGET_UTILIZING_ACC_NAME") IsNot DBNull.Value, reader("BUDGET_UTILIZING_ACC_NAME").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptBudgetResults.DataSource = list
            rptBudgetResults.DataBind()

            If list.Count = 0 Then
                pnlNoBudgetResults.Visible = True
            End If
        Catch ex As Exception
            lblBudgetError.Text = "Unable to load budget accounts"
            lblBudgetError.Visible = True
            rptBudgetResults.DataSource = Nothing
            rptBudgetResults.DataBind()
        End Try
    End Sub

    ' ── Supplier Lookup Modal Logic ─────────────────────────────────────
    Public Property IsSupplierLookupOpen As Boolean
        Get
            If ViewState("IsSupplierLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsSupplierLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsSupplierLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenSupplierLookup_Click(sender As Object, e As EventArgs)
        If txtSupplier.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtSupplierSearch.Text = String.Empty
        BindSupplierLookupList(String.Empty)
        IsSupplierLookupOpen = True
    End Sub

    Protected Sub btnSupplierSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtSupplierSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtSupplierSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtSupplierSearch.UniqueID).Trim()
        End If
        txtSupplierSearch.Text = prefix
        BindSupplierLookupList(prefix)
        IsSupplierLookupOpen = True
    End Sub

    Protected Sub btnCloseSupplierLookup_Click(sender As Object, e As EventArgs)
        IsSupplierLookupOpen = False
    End Sub

    Protected Sub rptSupplierResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedSupplier As String = e.CommandArgument.ToString()
            txtSupplier.Text = selectedSupplier
            IsSupplierLookupOpen = False
        End If
    End Sub

    Private Sub BindSupplierLookupList(prefix As String)
        lblSupplierError.Visible = False
        pnlNoSupplierResults.Visible = False
        Dim list As New List(Of SupplierItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT SUPPLIER_ID, SUPPLIER_NAME FROM M_SUPPLIER ORDER BY SUPPLIER_ID ASC"
                Else
                    sql = "SELECT SUPPLIER_ID, SUPPLIER_NAME FROM M_SUPPLIER WHERE UPPER(SUPPLIER_NAME) LIKE UPPER(:prefix) ORDER BY SUPPLIER_ID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New SupplierItem() With {
                                .SupplierId = If(reader("SUPPLIER_ID") IsNot DBNull.Value, reader("SUPPLIER_ID").ToString(), ""),
                                .SupplierName = If(reader("SUPPLIER_NAME") IsNot DBNull.Value, reader("SUPPLIER_NAME").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptSupplierResults.DataSource = list
            rptSupplierResults.DataBind()

            If list.Count = 0 Then
                pnlNoSupplierResults.Visible = True
            End If
        Catch ex As Exception
            lblSupplierError.Text = "Unable to load suppliers"
            lblSupplierError.Visible = True
            rptSupplierResults.DataSource = Nothing
            rptSupplierResults.DataBind()
        End Try
    End Sub

    ' ── Purchase FY Lookup Modal Logic ──────────────────────────────────
    Public Property IsPurchaseFYLookupOpen As Boolean
        Get
            If ViewState("IsPurchaseFYLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsPurchaseFYLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsPurchaseFYLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenPurchaseFYLookup_Click(sender As Object, e As EventArgs)
        If txtPurchaseFY.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtPurchaseFYSearch.Text = String.Empty
        BindPurchaseFYLookupList(String.Empty)
        IsPurchaseFYLookupOpen = True
    End Sub

    Protected Sub btnPurchaseFYSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtPurchaseFYSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtPurchaseFYSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtPurchaseFYSearch.UniqueID).Trim()
        End If
        txtPurchaseFYSearch.Text = prefix
        BindPurchaseFYLookupList(prefix)
        IsPurchaseFYLookupOpen = True
    End Sub

    Protected Sub btnClosePurchaseFYLookup_Click(sender As Object, e As EventArgs)
        IsPurchaseFYLookupOpen = False
    End Sub

    Protected Sub rptPurchaseFYResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedFY As String = e.CommandArgument.ToString()
            txtPurchaseFY.Text = selectedFY
            IsPurchaseFYLookupOpen = False
        End If
    End Sub

    Private Sub BindPurchaseFYLookupList(prefix As String)
        lblPurchaseFYError.Visible = False
        pnlNoPurchaseFYResults.Visible = False
        Dim list As New List(Of FinancialYearItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT FYID, TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY') AS FY_LABEL FROM M_FINANCIAL_YEAR WHERE ACTIVE = 'Y' ORDER BY FYID ASC"
                Else
                    sql = "SELECT FYID, TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY') AS FY_LABEL FROM M_FINANCIAL_YEAR WHERE ACTIVE = 'Y' AND (TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY')) LIKE :prefix ORDER BY FYID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New FinancialYearItem() With {
                                .FyId = If(reader("FYID") IsNot DBNull.Value, reader("FYID").ToString(), ""),
                                .FyLabel = If(reader("FY_LABEL") IsNot DBNull.Value, reader("FY_LABEL").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptPurchaseFYResults.DataSource = list
            rptPurchaseFYResults.DataBind()

            If list.Count = 0 Then
                pnlNoPurchaseFYResults.Visible = True
            End If
        Catch ex As Exception
            lblPurchaseFYError.Text = "Unable to load financial years"
            lblPurchaseFYError.Visible = True
            rptPurchaseFYResults.DataSource = Nothing
            rptPurchaseFYResults.DataBind()
        End Try
    End Sub

    ' ── First Depr FY Lookup Modal Logic ─────────────────────────────────
    Public Property IsFirstDeprFYLookupOpen As Boolean
        Get
            If ViewState("IsFirstDeprFYLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsFirstDeprFYLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsFirstDeprFYLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenFirstDeprFYLookup_Click(sender As Object, e As EventArgs)
        If txtFirstDeprFY.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtFirstDeprFYSearch.Text = String.Empty
        BindFirstDeprFYLookupList(String.Empty)
        IsFirstDeprFYLookupOpen = True
    End Sub

    Protected Sub btnFirstDeprFYSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtFirstDeprFYSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtFirstDeprFYSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtFirstDeprFYSearch.UniqueID).Trim()
        End If
        txtFirstDeprFYSearch.Text = prefix
        BindFirstDeprFYLookupList(prefix)
        IsFirstDeprFYLookupOpen = True
    End Sub

    Protected Sub btnCloseFirstDeprFYLookup_Click(sender As Object, e As EventArgs)
        IsFirstDeprFYLookupOpen = False
    End Sub

    Protected Sub rptFirstDeprFYResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedFY As String = e.CommandArgument.ToString()
            txtFirstDeprFY.Text = selectedFY
            IsFirstDeprFYLookupOpen = False
        End If
    End Sub

    Private Sub BindFirstDeprFYLookupList(prefix As String)
        lblFirstDeprFYError.Visible = False
        pnlNoFirstDeprFYResults.Visible = False
        Dim list As New List(Of FinancialYearItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT FYID, TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY') AS FY_LABEL FROM M_FINANCIAL_YEAR WHERE ACTIVE = 'Y' ORDER BY FYID ASC"
                Else
                    sql = "SELECT FYID, TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY') AS FY_LABEL FROM M_FINANCIAL_YEAR WHERE ACTIVE = 'Y' AND (TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY')) LIKE :prefix ORDER BY FYID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New FinancialYearItem() With {
                                .FyId = If(reader("FYID") IsNot DBNull.Value, reader("FYID").ToString(), ""),
                                .FyLabel = If(reader("FY_LABEL") IsNot DBNull.Value, reader("FY_LABEL").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptFirstDeprFYResults.DataSource = list
            rptFirstDeprFYResults.DataBind()

            If list.Count = 0 Then
                pnlNoFirstDeprFYResults.Visible = True
            End If
        Catch ex As Exception
            lblFirstDeprFYError.Text = "Unable to load financial years"
            lblFirstDeprFYError.Visible = True
            rptFirstDeprFYResults.DataSource = Nothing
            rptFirstDeprFYResults.DataBind()
        End Try
    End Sub

    ' ── Last Depr FY Lookup Modal Logic ──────────────────────────────────
    Public Property IsLastDeprFYLookupOpen As Boolean
        Get
            If ViewState("IsLastDeprFYLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsLastDeprFYLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsLastDeprFYLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenLastDeprFYLookup_Click(sender As Object, e As EventArgs)
        If txtLastDeprFY.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtLastDeprFYSearch.Text = String.Empty
        BindLastDeprFYLookupList(String.Empty)
        IsLastDeprFYLookupOpen = True
    End Sub

    Protected Sub btnLastDeprFYSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtLastDeprFYSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtLastDeprFYSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtLastDeprFYSearch.UniqueID).Trim()
        End If
        txtLastDeprFYSearch.Text = prefix
        BindLastDeprFYLookupList(prefix)
        IsLastDeprFYLookupOpen = True
    End Sub

    Protected Sub btnCloseLastDeprFYLookup_Click(sender As Object, e As EventArgs)
        IsLastDeprFYLookupOpen = False
    End Sub

    Protected Sub rptLastDeprFYResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedFY As String = e.CommandArgument.ToString()
            txtLastDeprFY.Text = selectedFY
            IsLastDeprFYLookupOpen = False
        End If
    End Sub

    Private Sub BindLastDeprFYLookupList(prefix As String)
        lblLastDeprFYError.Visible = False
        pnlNoLastDeprFYResults.Visible = False
        Dim list As New List(Of FinancialYearItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT FYID, TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY') AS FY_LABEL FROM M_FINANCIAL_YEAR WHERE ACTIVE = 'Y' ORDER BY FYID ASC"
                Else
                    sql = "SELECT FYID, TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY') AS FY_LABEL FROM M_FINANCIAL_YEAR WHERE ACTIVE = 'Y' AND (TO_CHAR(FROM_DATE,'YYYY') || '-' || TO_CHAR(TO_DATE,'YY')) LIKE :prefix ORDER BY FYID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New FinancialYearItem() With {
                                .FyId = If(reader("FYID") IsNot DBNull.Value, reader("FYID").ToString(), ""),
                                .FyLabel = If(reader("FY_LABEL") IsNot DBNull.Value, reader("FY_LABEL").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptLastDeprFYResults.DataSource = list
            rptLastDeprFYResults.DataBind()

            If list.Count = 0 Then
                pnlNoLastDeprFYResults.Visible = True
            End If
        Catch ex As Exception
            lblLastDeprFYError.Text = "Unable to load financial years"
            lblLastDeprFYError.Visible = True
            rptLastDeprFYResults.DataSource = Nothing
            rptLastDeprFYResults.DataBind()
        End Try
    End Sub

    ' ── Disposal Reason Lookup Modal Logic ─────────────────────────────
    Public Property IsDisposalReasonLookupOpen As Boolean
        Get
            If ViewState("IsDisposalReasonLookupOpen") IsNot Nothing Then
                Return DirectCast(ViewState("IsDisposalReasonLookupOpen"), Boolean)
            End If
            Return False
        End Get
        Set(value As Boolean)
            ViewState("IsDisposalReasonLookupOpen") = value
        End Set
    End Property

    Protected Sub btnOpenDisposalReasonLookup_Click(sender As Object, e As EventArgs)
        If txtDisposalReason.ReadOnly Then Exit Sub
        CloseAllLookupModals()
        txtDisposalReasonSearch.Text = String.Empty
        BindDisposalReasonLookupList(String.Empty)
        IsDisposalReasonLookupOpen = True
    End Sub

    Protected Sub btnDisposalReasonSearch_Click(sender As Object, e As EventArgs)
        Dim prefix As String = txtDisposalReasonSearch.Text.Trim()
        If String.IsNullOrEmpty(prefix) AndAlso Request.Form(txtDisposalReasonSearch.UniqueID) IsNot Nothing Then
            prefix = Request.Form(txtDisposalReasonSearch.UniqueID).Trim()
        End If
        txtDisposalReasonSearch.Text = prefix
        BindDisposalReasonLookupList(prefix)
        IsDisposalReasonLookupOpen = True
    End Sub

    Protected Sub btnCloseDisposalReasonLookup_Click(sender As Object, e As EventArgs)
        IsDisposalReasonLookupOpen = False
    End Sub

    Protected Sub rptDisposalReasonResults_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Select" Then
            Dim selectedReason As String = e.CommandArgument.ToString()
            txtDisposalReason.Text = selectedReason
            IsDisposalReasonLookupOpen = False
        End If
    End Sub

    Private Sub BindDisposalReasonLookupList(prefix As String)
        lblDisposalReasonError.Visible = False
        pnlNoDisposalReasonResults.Visible = False
        Dim list As New List(Of DisposalReasonItem)()

        Try
            Using conn As OracleConnection = DbHelper.GetConnection()
                Dim sql As String
                If String.IsNullOrEmpty(prefix) Then
                    sql = "SELECT DISPOSAL_REASON_ID, DISPOSAL_REASON FROM M_DISPOSAL_REASON ORDER BY DISPOSAL_REASON_ID ASC"
                Else
                    sql = "SELECT DISPOSAL_REASON_ID, DISPOSAL_REASON FROM M_DISPOSAL_REASON WHERE UPPER(DISPOSAL_REASON) LIKE UPPER(:prefix) ORDER BY DISPOSAL_REASON_ID ASC"
                End If

                Using cmd As New OracleCommand(sql, conn)
                    cmd.BindByName = True
                    If Not String.IsNullOrEmpty(prefix) Then
                        cmd.Parameters.Add("prefix", OracleDbType.Varchar2).Value = prefix.Trim() & "%"
                    End If

                    Using reader As OracleDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            list.Add(New DisposalReasonItem() With {
                                .DisposalReasonId = If(reader("DISPOSAL_REASON_ID") IsNot DBNull.Value, reader("DISPOSAL_REASON_ID").ToString(), ""),
                                .DisposalReasonName = If(reader("DISPOSAL_REASON") IsNot DBNull.Value, reader("DISPOSAL_REASON").ToString(), "")
                            })
                        End While
                    End Using
                End Using
            End Using

            rptDisposalReasonResults.DataSource = list
            rptDisposalReasonResults.DataBind()

            If list.Count = 0 Then
                pnlNoDisposalReasonResults.Visible = True
            End If
        Catch ex As Exception
            lblDisposalReasonError.Text = "Unable to load disposal reasons"
            lblDisposalReasonError.Visible = True
            rptDisposalReasonResults.DataSource = Nothing
            rptDisposalReasonResults.DataBind()
        End Try
    End Sub

    ' Stubs for legacy task control compiler-friendliness
    Protected Sub btnAddTask_Click(sender As Object, e As EventArgs)
        ' Legacy handler stub (no functional implementation needed)
    End Sub

    Protected Sub rptTasks_ItemCommand(source As Object, e As Global.System.Web.UI.WebControls.RepeaterCommandEventArgs)
        ' Legacy handler stub (no functional implementation needed)
    End Sub
    Protected Sub btnPrintTag_Click(sender As Object, e As EventArgs)
        Try
            Dim assetId As String = txtAssetId.Text
            Dim description As String = txtDescription.Text

            If String.IsNullOrWhiteSpace(assetId) Then
                assetId = "UNKNOWN"
            End If

            Dim zpl As String = "^XA" & vbCrLf &
                                "^PW406" & vbCrLf &
                                "^LL406" & vbCrLf &
                                "^FO50,50^BQN,2,6^FDQA," & assetId & "^FS" & vbCrLf &
                                "^FO50,250^A0N,20,20^FDID: " & assetId & "^FS" & vbCrLf &
                                "^FO50,280^A0N,20,20^FD" & description & "^FS" & vbCrLf &
                                "^XZ"

            Dim bSuccess As Boolean = RawPrinterHelper.SendStringToPrinter("ZDesigner GK888t", zpl)
            If bSuccess Then
                ClientScript.RegisterStartupScript(Me.GetType(), "PrintAlert", "alert('Sent to printer.');", True)
            Else
                ClientScript.RegisterStartupScript(Me.GetType(), "PrintAlert", "alert('Unable to reach the Zebra printer - please confirm it is connected and powered on.');", True)
            End If
        Catch ex As Exception
            ClientScript.RegisterStartupScript(Me.GetType(), "PrintAlert", "alert('Unable to reach the Zebra printer - please confirm it is connected and powered on.');", True)
        End Try
    End Sub
End Class
