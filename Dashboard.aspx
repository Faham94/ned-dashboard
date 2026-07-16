<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="DashboardPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Asset Information Form</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            /* Light theme university-style custom properties */
            --bg-color: #f4f6f9;
            --card-bg: #ffffff;
            --card-border: #cbd5e1;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            
            --maroon: #800000;
            --green: #1b5e20;
            --navy: #0d47a1;
            --orange-accent: #f57c00;
            --orange-light: #fff8e1;
            
            --header-bg: #ffffff;
            --info-bar-bg: #e2e8f0;
            --menu-bar-bg: #e65c00;
            --title-bar-bg: #e0f2fe;
            
            --data-entry-header: #1e3a8a;
            --data-view-header: #064e3b;
            
            --cream-bg: #fffdf0;
            --orange-border: #f97316;
            
            --accent-primary: #0288d1;
            --accent-hover: #01579b;
            --input-bg: #ffffff;
            --input-border: #cbd5e1;
            --success-color: #1b5e20;
            --success-bg: rgba(27, 94, 32, 0.1);
            --warning-color: #e65c00;
            --warning-bg: rgba(230, 92, 0, 0.1);
            --error-color: #b91c1c;
            --error-bg: rgba(185, 28, 28, 0.1);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', 'Outfit', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* 1. Top Header Bar */
        .top-header {
            background-color: var(--header-bg);
            border-bottom: 2px solid var(--maroon);
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .univ-logo {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            border: 2px solid var(--maroon);
            object-fit: cover;
        }

        .title-group {
            display: flex;
            flex-direction: column;
        }

        .main-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--maroon);
            line-height: 1.2;
        }

        .sub-title {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--green);
            margin-top: 2px;
        }

        .header-right {
            text-align: right;
        }

        .system-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--navy);
            letter-spacing: -0.5px;
        }

        /* 2. Sub-Header Info Bar */
        .info-bar {
            background-color: var(--info-bar-bg);
            padding: 8px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            border-bottom: 1px solid var(--card-border);
        }

        .user-welcome {
            font-weight: 500;
            color: var(--text-primary);
        }

        .user-welcome strong {
            color: var(--navy);
        }

        .info-actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .info-actions a, .info-actions .action-link {
            color: var(--navy);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
            cursor: pointer;
            background: none;
            border: none;
            font-size: 0.85rem;
            font-family: inherit;
        }

        .info-actions a:hover, .info-actions .action-link:hover {
            color: var(--maroon);
            text-decoration: underline;
        }

        .divider {
            color: var(--text-secondary);
        }

        /* 3. Orange Menu Bar */
        .menu-bar {
            background-color: var(--menu-bar-bg);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
            z-index: 50;
        }

        .menu-list {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0 16px;
        }

        .menu-item {
            position: relative;
        }

        .menu-link {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 12px 20px;
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: background-color 0.2s;
        }

        .menu-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        .arrow-down {
            font-size: 0.75rem;
        }

        /* Dropdown menus on hover */
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: white;
            min-width: 200px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.15);
            border: 1px solid var(--card-border);
            list-style: none;
            padding: 6px 0;
            border-radius: 0 0 4px 4px;
        }

        .menu-item:hover .dropdown-menu {
            display: block;
        }

        .dropdown-item a {
            display: block;
            padding: 10px 16px;
            color: var(--text-primary);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
            transition: background-color 0.2s, color 0.2s;
        }

        .dropdown-item a:hover {
            background-color: var(--orange-light);
            color: var(--orange-accent);
        }

        /* 4. Page Title Bar */
        .page-title-bar {
            background-color: var(--title-bar-bg);
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid var(--card-border);
        }

        .page-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--navy);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Main container layout */
        .main-container {
            flex: 1;
            padding: 20px;
            width: 100%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* 5. Split Panels */
        .panels-grid {
            display: grid;
            grid-template-columns: 2.2fr 1fr;
            gap: 20px;
        }

        @media (max-width: 1200px) {
            .panels-grid {
                grid-template-columns: 1fr;
            }
        }

        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.03);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .card-header {
            padding: 12px 18px;
            color: white;
            font-weight: 700;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header.data-entry {
            background-color: var(--data-entry-header);
        }

        .card-header.data-view {
            background-color: var(--data-view-header);
        }

        .card-body {
            padding: 16px;
            flex: 1;
        }

        /* Two-Column Form Layout */
        .form-columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 768px) {
            .form-columns {
                grid-template-columns: 1fr;
            }
        }

        .form-column {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 140px 1fr;
            gap: 10px;
            align-items: center;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.8rem;
            color: var(--text-primary);
            text-align: right;
        }

        .form-input-entry {
            width: 100%;
            padding: 6px 10px;
            font-size: 0.8rem;
            color: var(--text-primary);
            background-color: var(--cream-bg);
            border: 1px solid var(--orange-border);
            border-radius: 4px;
            outline: none;
            transition: box-shadow 0.2s;
        }

        .form-input-entry:focus {
            box-shadow: 0 0 0 3px rgba(249, 115, 22, 0.25);
        }

        .form-input-entry[readonly] {
            background-color: #f1f5f9;
            border-color: #cbd5e1;
            cursor: not-allowed;
        }

        /* Asset Tag Box */
        .asset-tag-box {
            background-color: #f8fafc;
            border: 1px solid var(--card-border);
            border-radius: 6px;
            padding: 10px 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 16px;
        }

        .tag-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .tag-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .status-badge-large {
            font-size: 1rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 4px 12px;
            border-radius: 4px;
            border: 1px solid;
            display: inline-block;
        }

        .status-active {
            color: #1b5e20;
            background-color: rgba(27, 94, 32, 0.1);
            border-color: #1b5e20;
        }

        .status-disposed {
            color: #b91c1c;
            background-color: rgba(185, 28, 28, 0.1);
            border-color: #b91c1c;
        }

        .qr-placeholder {
            width: 80px;
            height: 80px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .qr-image {
            width: 72px;
            height: 72px;
        }

        .btn-print-qr {
            background-color: #475569;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-print-qr:hover {
            background-color: #334155;
        }

        /* Data View (Right Panel) table styling */
        .search-box-container {
            display: flex;
            gap: 6px;
            margin-bottom: 12px;
        }

        .search-input {
            flex: 1;
            padding: 6px 10px;
            font-size: 0.8rem;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            outline: none;
        }

        .search-btn {
            background-color: var(--navy);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
        }

        .search-btn:hover {
            background-color: #0b3c8f;
        }

        .assets-table-container {
            overflow-y: auto;
            max-height: 520px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
        }

        .assets-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.8rem;
        }

        .assets-table th, .assets-table td {
            padding: 8px 10px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .assets-table th {
            background-color: #f8fafc;
            font-weight: 600;
            color: var(--text-secondary);
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .asset-row {
            transition: background-color 0.2s;
        }

        .asset-row:hover {
            background-color: #f1f5f9;
        }

        .select-link {
            color: var(--navy);
            text-decoration: none;
            font-weight: 700;
            cursor: pointer;
        }

        .select-link:hover {
            text-decoration: underline;
            color: var(--maroon);
        }

        .status-badge-small {
            font-size: 0.7rem;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 3px;
            text-transform: uppercase;
        }

        .badge-active {
            color: #16a34a;
            background-color: #f0fdf4;
            border: 1px solid #bbf7d0;
        }

        .badge-disposed {
            color: #dc2626;
            background-color: #fef2f2;
            border: 1px solid #fca5a5;
        }

        .empty-placeholder {
            text-align: center;
            color: var(--text-secondary);
            font-style: italic;
            padding: 20px 0;
        }

        /* 6. Bottom Action Bar (Toolbar) */
        .action-toolbar {
            background-color: #0f172a;
            border-top: 1px solid #1e3a8a; /* Thin lighter-blue top border */
            padding: 12px 24px;
            display: flex;
            justify-content: center; /* Horizontally centered tight group */
            align-items: center;
            gap: 8px;
            width: 100%;
            margin-top: auto; /* Push to the bottom of the flex body */
        }

        .toolbar-btn {
            background-color: #f4f6f9;
            color: #1e293b;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            padding: 4px 12px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.2s, border-color 0.2s, transform 0.1s;
        }

        .toolbar-btn:hover {
            background-color: #e2e8f0;
            border-color: #94a3b8;
        }

        .toolbar-btn:active {
            transform: scale(0.97);
        }

        .btn-icon-block {
            width: 14px;
            height: 14px;
            border-radius: 3px;
            display: inline-block;
        }

        .bg-green { background-color: #22c55e; }
        .bg-orange { background-color: #f97316; }
        .bg-red { background-color: #ef4444; }
        .bg-blue { background-color: #3b82f6; }
        .bg-gray { background-color: #94a3b8; }

        /* 7. Footer */
        .footer {
            background-color: #ffffff;
            border-top: 1px solid var(--card-border);
            padding: 14px;
            text-align: center;
            font-size: 0.8rem;
            color: var(--text-secondary);
            margin-top: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- 1. Top Header Bar -->
        <header class="top-header">
            <div class="header-left">
                <!-- Circular logo placeholder -->
                <img src="https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=150&auto=format&fit=crop" alt="University Logo" class="univ-logo" />
                <div class="title-group">
                    <span class="main-title">
                        <asp:Label ID="lblInstitutionName" runat="server">National University of Engineering & Development</asp:Label>
                    </span>
                    <span class="sub-title">
                        <asp:Label ID="lblDepartmentName" runat="server">Department of Information Technology</asp:Label>
                    </span>
                </div>
            </div>
            <div class="header-right">
                <span class="system-title">
                    <asp:Label ID="lblSystemTitle" runat="server">Asset Management System</asp:Label>
                </span>
            </div>
        </header>

        <!-- 2. Sub-Header Info Bar -->
        <div class="info-bar">
            <div class="user-welcome">
                Login User : <strong><asp:Label ID="lblUserName" runat="server"></asp:Label></strong>
            </div>
            <div class="info-actions">
                <!-- TODO: Change Password page / popup placeholder link -->
                <a href="#" onclick="alert('Change Password feature is not implemented yet. (TODO)'); return false;">Change Password</a>
                <span class="divider">|</span>
                <asp:LinkButton ID="btnLogout" runat="server" CssClass="action-link" OnClick="btnLogout_Click" UseSubmitBehavior="false" Text="Logout" />
            </div>
        </div>

        <!-- 3. Orange Horizontal Menu Bar -->
        <nav class="menu-bar">
            <ul class="menu-list">
                <li class="menu-item">
                    <a href="#" class="menu-link" onclick="return false;">
                        Master Information <span class="arrow-down">▼</span>
                    </a>
                    <!-- TODO: Submenu actions placeholder -->
                    <ul class="dropdown-menu">
                        <li class="dropdown-item"><a href="#" onclick="alert('Asset Master configuration is under development.'); return false;">Asset Master</a></li>
                        <li class="dropdown-item"><a href="#" onclick="alert('Location Master configuration is under development.'); return false;">Location Master</a></li>
                        <li class="dropdown-item"><a href="#" onclick="alert('Vendor Master configuration is under development.'); return false;">Vendor Master</a></li>
                    </ul>
                </li>
                <li class="menu-item">
                    <a href="#" class="menu-link" onclick="return false;">
                        Transactions <span class="arrow-down">▼</span>
                    </a>
                    <!-- TODO: Submenu actions placeholder -->
                    <ul class="dropdown-menu">
                        <li class="dropdown-item"><a href="#" onclick="alert('Asset Allocation screen is under development.'); return false;">Asset Allocation</a></li>
                        <li class="dropdown-item"><a href="#" onclick="alert('Asset Recovery screen is under development.'); return false;">Asset Recovery</a></li>
                        <li class="dropdown-item"><a href="#" onclick="alert('Maintenance Request screen is under development.'); return false;">Maintenance Request</a></li>
                    </ul>
                </li>
                <li class="menu-item">
                    <a href="#" class="menu-link" onclick="return false;">
                        Reports <span class="arrow-down">▼</span>
                    </a>
                    <!-- TODO: Submenu actions placeholder -->
                    <ul class="dropdown-menu">
                        <li class="dropdown-item"><a href="#" onclick="alert('Inventory Reports list is under development.'); return false;">Inventory Report</a></li>
                        <li class="dropdown-item"><a href="#" onclick="alert('Maintenance History report is under development.'); return false;">Maintenance Log</a></li>
                        <li class="dropdown-item"><a href="#" onclick="alert('Depreciation Report is under development.'); return false;">Depreciation Log</a></li>
                    </ul>
                </li>
            </ul>
        </nav>

        <!-- 4. Page Title Bar -->
        <div class="page-title-bar">
            <span class="page-title">Asset Information Form</span>
        </div>

        <!-- Main Content Area -->
        <main class="main-container">
            <!-- 5. Split Panels -->
            <div class="panels-grid">
                <!-- Left Panel: Data Entry -->
                <div class="card">
                    <div class="card-header data-entry">
                        Data Entry
                    </div>
                    <div class="card-body">
                        <!-- 3. Asset Tag box -->
                        <div class="asset-tag-box">
                            <div class="tag-left">
                                <span class="form-label" style="text-align: left;">Asset Status:</span>
                                <asp:Label ID="lblStatusText" runat="server" CssClass="status-badge-large status-active">Active</asp:Label>
                            </div>
                            <div class="tag-right">
                                <div class="qr-placeholder">
                                    <asp:Image ID="imgQRCode" runat="server" CssClass="qr-image" ImageUrl="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=Placeholder" AlternateText="QR Code" />
                                </div>
                                <button type="button" class="btn-print-qr" onclick="window.print();">Print Tag</button>
                            </div>
                        </div>

                        <!-- 2. Rebuilt Form Fields -->
                        <div class="form-columns">
                            <!-- Left Column: Asset Identity & Details -->
                            <div class="form-column">
                                <div class="form-row">
                                    <label class="form-label">Asset ID:</label>
                                    <asp:TextBox ID="txtAssetId" runat="server" CssClass="form-input-entry" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Asset Description:</label>
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-input-entry" placeholder="Description of the asset"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Asset Category:</label>
                                    <asp:TextBox ID="txtCategory" runat="server" CssClass="form-input-entry" placeholder="Category (e.g. Computers)"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Brand:</label>
                                    <asp:TextBox ID="txtBrand" runat="server" CssClass="form-input-entry" placeholder="e.g. Dell, Steelcase"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Model No.:</label>
                                    <asp:TextBox ID="txtModelNo" runat="server" CssClass="form-input-entry" placeholder="e.g. Latitude 5420"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Serial No.:</label>
                                    <asp:TextBox ID="txtSerialNo" runat="server" CssClass="form-input-entry" placeholder="Manufacturer serial number"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Section:</label>
                                    <asp:TextBox ID="txtSection" runat="server" CssClass="form-input-entry" placeholder="e.g. Academic, IT Support"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Location:</label>
                                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-input-entry" placeholder="e.g. Main Library, Room 402"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Employee:</label>
                                    <asp:TextBox ID="txtEmployee" runat="server" CssClass="form-input-entry" placeholder="Assigned to employee"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Budget utilized from:</label>
                                    <asp:TextBox ID="txtBudgetUtilizedFrom" runat="server" CssClass="form-input-entry" placeholder="Budget source/grant"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Supplier:</label>
                                    <asp:TextBox ID="txtSupplier" runat="server" CssClass="form-input-entry" placeholder="Vendor/Supplier name"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Invoice No.:</label>
                                    <asp:TextBox ID="txtInvoiceNo" runat="server" CssClass="form-input-entry" placeholder="Invoice number"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Contract Sch. No.:</label>
                                    <asp:TextBox ID="txtContractSchNo" runat="server" CssClass="form-input-entry" placeholder="Maintenance contract no."></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Status Mode:</label>
                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-input-entry">
                                        <asp:ListItem Value="Active">Active</asp:ListItem>
                                        <asp:ListItem Value="Disposed">Disposed</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- Right Column: Financials & Dates -->
                            <div class="form-column">
                                <div class="form-row">
                                    <label class="form-label">Original Cost:</label>
                                    <asp:TextBox ID="txtOriginalCost" runat="server" CssClass="form-input-entry" placeholder="0.00"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Current Value:</label>
                                    <asp:TextBox ID="txtCurrentValue" runat="server" CssClass="form-input-entry" placeholder="0.00"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Acc. Deprec.:</label>
                                    <asp:TextBox ID="txtAccDeprec" runat="server" CssClass="form-input-entry" placeholder="0.00"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">FY Opening Bal.:</label>
                                    <asp:TextBox ID="txtFYOpeningBal" runat="server" CssClass="form-input-entry" placeholder="0.00"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">FY Closing Bal.:</label>
                                    <asp:TextBox ID="txtFYClosingBal" runat="server" CssClass="form-input-entry" placeholder="0.00"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Dep. Start Date:</label>
                                    <asp:TextBox ID="txtDepStartDate" runat="server" CssClass="form-input-entry" placeholder="YYYY-MM-DD"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">First Depr. FY:</label>
                                    <asp:TextBox ID="txtFirstDeprFY" runat="server" CssClass="form-input-entry" placeholder="e.g. 2024-2025"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Last Depr. FY:</label>
                                    <asp:TextBox ID="txtLastDeprFY" runat="server" CssClass="form-input-entry" placeholder="e.g. 2029-2030"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Purchase Date:</label>
                                    <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="form-input-entry" placeholder="YYYY-MM-DD"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Purchase FY:</label>
                                    <asp:TextBox ID="txtPurchaseFY" runat="server" CssClass="form-input-entry" placeholder="e.g. 2024-2025"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Warranty Exp.:</label>
                                    <asp:TextBox ID="txtWarrantyExp" runat="server" CssClass="form-input-entry" placeholder="YYYY-MM-DD"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Disposal Date:</label>
                                    <asp:TextBox ID="txtDisposalDate" runat="server" CssClass="form-input-entry" placeholder="YYYY-MM-DD"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Dispos. Reason:</label>
                                    <asp:TextBox ID="txtDisposalReason" runat="server" CssClass="form-input-entry" placeholder="Reason if disposed"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Remarks:</label>
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-input-entry" placeholder="Any additional notes"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Enter By:</label>
                                    <asp:TextBox ID="txtEnterBy" runat="server" CssClass="form-input-entry" placeholder="Operator name"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Entry Date:</label>
                                    <asp:TextBox ID="txtEntryDate" runat="server" CssClass="form-input-entry" placeholder="YYYY-MM-DD"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Panel: Data View -->
                <div class="card">
                    <div class="card-header data-view">
                        Data View
                    </div>
                    <div class="card-body">
                        <!-- Search filtering container -->
                        <div class="search-box-container">
                            <asp:TextBox ID="txtSearchQuery" runat="server" placeholder="Search by ID or Desc..." CssClass="search-input"></asp:TextBox>
                            <asp:Button ID="btnPerformSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="search-btn" />
                        </div>

                        <!-- 4. Data View list -->
                        <div class="assets-table-container">
                            <table class="assets-table">
                                <thead>
                                    <tr>
                                        <th>Asset ID</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptAssets" runat="server" OnItemCommand="rptAssets_ItemCommand">
                                        <ItemTemplate>
                                            <tr class="asset-row">
                                                <td>
                                                    <asp:LinkButton ID="lnkSelect" runat="server" CommandName="Select" CommandArgument='<%# Eval("AssetId") %>' Text='<%# Eval("AssetId") %>' CssClass="select-link" />
                                                </td>
                                                <td><%# HttpUtility.HtmlEncode(Eval("Description")) %></td>
                                                <td>
                                                    <span class="status-badge-small <%# If(Eval("Status").ToString() = "Active", "badge-active", "badge-disposed") %>">
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                            <asp:Panel ID="pnlNoAssets" runat="server" Visible="false" CssClass="empty-placeholder">
                                No assets match this search.
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hidden container to keep old task-manager structures compile-friendly but completely invisible -->
            <asp:Panel ID="pnlHiddenTasks" runat="server" Visible="false">
                <asp:TextBox ID="txtTaskName" runat="server"></asp:TextBox>
                <asp:Button ID="btnAddTask" runat="server" OnClick="btnAddTask_Click" />
                <asp:Repeater ID="rptTasks" runat="server" OnItemCommand="rptTasks_ItemCommand">
                    <ItemTemplate></ItemTemplate>
                </asp:Repeater>
                <asp:Panel ID="pnlNoTasks" runat="server"></asp:Panel>
            </asp:Panel>
        </main>

        <!-- 6. Bottom Action Bar (Toolbar) -->
        <div class="action-toolbar">
            <asp:LinkButton ID="btnNew" runat="server" CssClass="toolbar-btn" OnClick="btnNew_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-green"></span>New
            </asp:LinkButton>
            <asp:LinkButton ID="btnEdit" runat="server" CssClass="toolbar-btn" OnClick="btnEdit_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-orange"></span>Edit
            </asp:LinkButton>
            <asp:LinkButton ID="btnDelete" runat="server" CssClass="toolbar-btn" OnClick="btnDelete_Click" UseSubmitBehavior="false" OnClientClick="return confirm('Are you sure you want to delete this asset?');">
                <span class="btn-icon-block bg-red"></span>Delete
            </asp:LinkButton>
            <asp:LinkButton ID="btnSave" runat="server" CssClass="toolbar-btn" OnClick="btnSave_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-blue"></span>Save
            </asp:LinkButton>
            <asp:LinkButton ID="btnCancel" runat="server" CssClass="toolbar-btn" OnClick="btnCancel_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-gray"></span>Cancel
            </asp:LinkButton>
            <asp:LinkButton ID="btnSearch" runat="server" CssClass="toolbar-btn" OnClick="btnSearch_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-gray"></span>Search
            </asp:LinkButton>
            <asp:LinkButton ID="btnPrint" runat="server" CssClass="toolbar-btn" OnClientClick="window.print(); return false;" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-gray"></span>Print
            </asp:LinkButton>
            <asp:LinkButton ID="btnExit" runat="server" CssClass="toolbar-btn" OnClick="btnLogout_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-red"></span>Exit
            </asp:LinkButton>
        </div>

        <!-- 7. Footer -->
        <footer class="footer">
            Copyright &copy; <asp:Label ID="lblCopyrightDepartment" runat="server"></asp:Label>
        </footer>
    </form>
</body>
</html>
