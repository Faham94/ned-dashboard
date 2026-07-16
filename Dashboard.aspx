<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="DashboardPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>University Admin Dashboard</title>
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
            padding: 24px;
            max-width: 1400px;
            width: 100%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* 5. Split Panels */
        .panels-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        @media (max-width: 992px) {
            .panels-grid {
                grid-template-columns: 1fr;
            }
        }

        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.03);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .card-header {
            padding: 12px 18px;
            color: white;
            font-weight: 700;
            font-size: 1rem;
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
            padding: 20px;
            flex: 1;
        }

        /* 2-Column Grid Form */
        .form-grid {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 16px 12px;
            align-items: center;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.9rem;
            color: var(--text-primary);
            text-align: right;
        }

        .form-input-container {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-input-readonly {
            width: 100%;
            max-width: 120px;
            padding: 8px 12px;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-primary);
            background-color: var(--cream-bg);
            border: 1px solid var(--orange-border);
            border-radius: 4px;
            text-align: center;
        }

        .form-input-entry {
            width: 100%;
            padding: 8px 12px;
            font-size: 0.9rem;
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

        .btn-create {
            grid-column: 2;
            justify-self: start;
            background-color: var(--navy);
            color: white;
            border: none;
            padding: 8px 20px;
            font-size: 0.9rem;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-create:hover {
            background-color: #0b3c8f;
        }

        /* Status Badge */
        .status-box {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background-color: var(--success-bg);
            border: 1px solid var(--success-color);
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 0.8rem;
        }

        .status-indicator {
            width: 8px;
            height: 8px;
            background-color: var(--success-color);
            border-radius: 50%;
            display: inline-block;
        }

        .status-text {
            color: var(--success-color);
            font-weight: 700;
            text-transform: uppercase;
        }

        /* Data View empty placeholder */
        .empty-placeholder {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
            min-height: 180px;
            color: var(--text-secondary);
            font-style: italic;
            font-size: 0.95rem;
            text-align: center;
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

        /* Task List Management container */
        .tasks-section {
            margin-top: 12px;
        }

        .tasks-card-header {
            background-color: #475569;
            color: white;
            padding: 12px 18px;
            font-weight: 700;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-radius: 8px 8px 0 0;
        }

        .task-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .task-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            padding: 12px 18px;
            border-radius: 6px;
            transition: background-color 0.2s, border-color 0.2s;
        }

        .task-item:hover {
            background-color: #f1f5f9;
            border-color: #cbd5e1;
        }

        .task-item.completed {
            background-color: #f0fdf4;
            border-color: #bbf7d0;
        }

        .task-item.completed .task-text {
            text-decoration: line-through;
            color: #94a3b8;
        }

        .task-text {
            font-size: 0.9rem;
            font-weight: 500;
        }

        .task-actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 6px 12px;
            font-size: 0.75rem;
            font-weight: 600;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            border: none;
            font-family: inherit;
            transition: background-color 0.2s;
        }

        .toggle-btn {
            background-color: var(--accent-primary);
            color: white;
        }

        .toggle-btn:hover {
            background-color: var(--accent-hover);
        }

        .task-item.completed .toggle-btn {
            background-color: #e2e8f0;
            color: var(--text-primary);
        }

        .task-item.completed .toggle-btn:hover {
            background-color: #cbd5e1;
        }

        .delete-btn {
            background-color: rgba(220, 38, 38, 0.1);
            color: #dc2626;
        }

        .delete-btn:hover {
            background-color: rgba(220, 38, 38, 0.2);
        }

        .empty-tasks {
            text-align: center;
            color: var(--text-secondary);
            font-size: 0.9rem;
            padding: 30px 0;
            font-style: italic;
        }

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
            <span class="page-title">Dashboard Overview</span>
        </div>

        <!-- Main Content Area -->
        <main class="main-container">
            <!-- 5. Split Panels -->
            <div class="panels-grid">
                <!-- Left Panel: Data Entry -->
                <div class="card">
                    <div class="card-header data-entry">
                        Data Entry
                        <!-- Small green bold status badge placeholder -->
                        <div class="status-box">
                            <span class="status-indicator"></span>
                            <span class="status-text">Active</span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-grid">
                            <!-- Readonly display of stats metrics -->
                            <label class="form-label">Total Tasks:</label>
                            <div class="form-input-container">
                                <asp:TextBox ID="lblTotalTasks" runat="server" ReadOnly="true" CssClass="form-input-readonly">0</asp:TextBox>
                            </div>

                            <label class="form-label">Completed Tasks:</label>
                            <div class="form-input-container">
                                <asp:TextBox ID="lblCompletedTasks" runat="server" ReadOnly="true" CssClass="form-input-readonly">0</asp:TextBox>
                            </div>

                            <label class="form-label">Efficiency Metric:</label>
                            <div class="form-input-container">
                                <asp:TextBox ID="lblEfficiency" runat="server" ReadOnly="true" CssClass="form-input-readonly">0%</asp:TextBox>
                            </div>

                            <!-- Interactive Task Entry Row -->
                            <label class="form-label">New Task Name:</label>
                            <div class="form-input-container">
                                <asp:TextBox ID="txtTaskName" runat="server" CssClass="form-input-entry" placeholder="e.g., Verify science lab equipment assets" AutoCompleteType="Disabled"></asp:TextBox>
                            </div>

                            <asp:Button ID="btnAddTask" runat="server" Text="Create Task Entry" CssClass="btn-create" OnClick="btnAddTask_Click" />
                        </div>
                    </div>
                </div>

                <!-- Right Panel: Data View -->
                <div class="card">
                    <div class="card-header data-view">
                        Data View
                    </div>
                    <div class="card-body">
                        <!-- Empty placeholder content for data view -->
                        <div class="empty-placeholder">
                            No data selected
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hidden panel to keep controls active in code-behind but invisible on page -->
            <asp:Panel ID="pnlHiddenTasks" runat="server" Visible="false">
                <asp:Repeater ID="rptTasks" runat="server" OnItemCommand="rptTasks_ItemCommand">
                    <HeaderTemplate>
                        <ul class="task-list">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li class="task-item <%# If(Convert.ToBoolean(Eval("IsCompleted")), "completed", "") %>">
                            <span class="task-text"><%# HttpUtility.HtmlEncode(Eval("Name")) %></span>
                            <div class="task-actions">
                                <asp:LinkButton ID="btnToggle" runat="server" CommandName="Toggle" CommandArgument='<%# Eval("Id") %>' CssClass="action-btn toggle-btn" Text='<%# If(Convert.ToBoolean(Eval("IsCompleted")), "Undo", "Complete") %>' />
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Id") %>' CssClass="action-btn delete-btn" Text="Delete" />
                            </div>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>
                
                <asp:Panel ID="pnlNoTasks" runat="server" Visible="true" CssClass="empty-tasks">
                    No tasks in progress. Create your first task entry above to get started!
                </asp:Panel>
            </asp:Panel>
        </main>

        <!-- 6. Bottom Action Bar (Toolbar) -->
        <div class="action-toolbar">
            <button type="button" class="toolbar-btn" onclick="alert('New item action triggered (TODO)');"><span class="btn-icon-block bg-green"></span>New</button>
            <button type="button" class="toolbar-btn" onclick="alert('Edit action triggered (TODO)');"><span class="btn-icon-block bg-orange"></span>Edit</button>
            <button type="button" class="toolbar-btn" onclick="alert('Delete action triggered (TODO)');"><span class="btn-icon-block bg-red"></span>Delete</button>
            <button type="button" class="toolbar-btn" onclick="alert('Save action triggered (TODO)');"><span class="btn-icon-block bg-blue"></span>Save</button>
            <button type="button" class="toolbar-btn" onclick="alert('Cancel action triggered (TODO)');"><span class="btn-icon-block bg-gray"></span>Cancel</button>
            <button type="button" class="toolbar-btn" onclick="alert('Search action triggered (TODO)');"><span class="btn-icon-block bg-gray"></span>Search</button>
            <button type="button" class="toolbar-btn" onclick="alert('Print report action triggered (TODO)');"><span class="btn-icon-block bg-gray"></span>Print</button>
            
            <!-- Exit button wires to Logout (clears session and redirects) -->
            <asp:LinkButton ID="btnExit" runat="server" CssClass="toolbar-btn" OnClick="btnLogout_Click" UseSubmitBehavior="false"><span class="btn-icon-block bg-red"></span>Exit</asp:LinkButton>
        </div>

        <!-- 7. Footer -->
        <footer class="footer">
            Copyright &copy; <asp:Label ID="lblCopyrightDepartment" runat="server"></asp:Label>
        </footer>
    </form>
</body>
</html>
