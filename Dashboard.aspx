<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="DashboardPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - VB.NET Web App</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-gradient-start: #0b0f19;
            --bg-gradient-end: #111827;
            --card-bg: rgba(255, 255, 255, 0.04);
            --card-border: rgba(255, 255, 255, 0.08);
            --sidebar-bg: rgba(17, 24, 39, 0.95);
            --text-primary: #f9fafb;
            --text-secondary: #9ca3af;
            --accent-primary: #6366f1;
            --accent-hover: #4f46e5;
            --input-bg: rgba(17, 24, 39, 0.6);
            --input-border: rgba(255, 255, 255, 0.1);
            --success-color: #10b981;
            --success-bg: rgba(16, 185, 129, 0.1);
            --warning-color: #f59e0b;
            --warning-bg: rgba(245, 158, 11, 0.1);
            --error-color: #ef4444;
            --error-bg: rgba(239, 68, 68, 0.1);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Outfit', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: radial-gradient(circle at top right, #1e1b4b 0%, var(--bg-gradient-start) 60%), var(--bg-gradient-end);
            min-height: 100vh;
            color: var(--text-primary);
            display: flex;
        }

        /* Sidebar Styling */
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--card-border);
            display: flex;
            flex-direction: column;
            padding: 30px 20px;
            position: fixed;
            height: 100vh;
            z-index: 100;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 40px;
            padding-left: 8px;
        }

        .logo-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #818cf8, #c084fc);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: white;
            font-size: 1.1rem;
        }

        .logo-text {
            font-weight: 700;
            font-size: 1.25rem;
            background: linear-gradient(to right, #a5b4fc, #c084fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .nav-item a, .logout-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            color: var(--text-secondary);
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.2s ease;
            font-weight: 500;
            border: none;
            background: transparent;
            cursor: pointer;
            width: 100%;
            text-align: left;
            font-family: inherit;
            font-size: 0.95rem;
        }

        .nav-item.active a, .nav-item a:hover {
            color: var(--text-primary);
            background: rgba(255, 255, 255, 0.05);
        }

        .nav-item.active a {
            background: rgba(99, 102, 241, 0.15);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.2);
        }

        .sidebar-footer {
            margin-top: auto;
        }

        .logout-btn {
            color: #f87171;
            padding: 12px 16px;
            border-radius: 12px;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            border: none;
            background: transparent;
            text-align: left;
            font-family: inherit;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logout-btn:hover {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        /* Main Content Styling */
        .main-content {
            margin-left: 260px;
            flex: 1;
            padding: 40px;
            max-width: 1200px;
        }

        /* Header area */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .welcome-title h2 {
            font-size: 1.75rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .welcome-title p {
            color: var(--text-secondary);
            font-size: 0.95rem;
            margin-top: 4px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            padding: 8px 16px;
            border-radius: 50px;
        }

        .avatar {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #6366f1, #a855f7);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            color: white;
            font-size: 0.9rem;
        }

        .user-info {
            text-align: left;
        }

        .user-name {
            font-size: 0.9rem;
            font-weight: 600;
        }

        .user-role {
            font-size: 0.75rem;
            color: var(--text-secondary);
        }

        /* Grid Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            padding: 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            border-color: rgba(255, 255, 255, 0.15);
            background: rgba(255, 255, 255, 0.06);
        }

        .stat-info h3 {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-secondary);
            margin-bottom: 8px;
        }

        .stat-info p {
            font-size: 2rem;
            font-weight: 700;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stat-icon.total {
            background: rgba(99, 102, 241, 0.15);
            color: #818cf8;
        }

        .stat-icon.completed {
            background: rgba(16, 185, 129, 0.15);
            color: #34d399;
        }

        .stat-icon.efficiency {
            background: rgba(168, 85, 247, 0.15);
            color: #c084fc;
        }

        /* Split columns */
        .content-split {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 30px;
            align-items: start;
        }

        @media (max-width: 900px) {
            .content-split {
                grid-template-columns: 1fr;
            }
        }

        .card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 24px;
            padding: 30px;
        }

        .card h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            font-size: 0.95rem;
            color: var(--text-primary);
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 12px;
            outline: none;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-control:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.25);
        }

        .btn {
            width: 100%;
            padding: 12px;
            font-size: 0.95rem;
            font-weight: 600;
            color: white;
            background: var(--accent-primary);
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.25);
            font-family: inherit;
        }

        .btn:hover {
            background: var(--accent-hover);
            transform: translateY(-1px);
        }

        /* Task List Styling */
        .task-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .task-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--card-border);
            padding: 14px 20px;
            border-radius: 14px;
            transition: all 0.2s ease;
        }

        .task-item:hover {
            background: rgba(255, 255, 255, 0.04);
            border-color: rgba(255, 255, 255, 0.12);
        }

        .task-item.completed {
            border-color: rgba(16, 185, 129, 0.2);
            background: rgba(16, 185, 129, 0.02);
        }

        .task-item.completed .task-text {
            text-decoration: line-through;
            color: var(--text-secondary);
        }

        .task-text {
            font-size: 0.95rem;
            font-weight: 500;
        }

        .task-actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 6px 12px;
            font-size: 0.8rem;
            font-weight: 600;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
            font-family: inherit;
        }

        .toggle-btn {
            background: var(--accent-primary);
            color: white;
        }

        .toggle-btn:hover {
            background: var(--accent-hover);
        }

        .task-item.completed .toggle-btn {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        .task-item.completed .toggle-btn:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .delete-btn {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
        }

        .delete-btn:hover {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
        }

        .empty-tasks {
            text-align: center;
            color: var(--text-secondary);
            font-size: 0.95rem;
            padding: 40px 0;
            font-style: italic;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="logo-section">
                <div class="logo-icon">🎛️</div>
                <div class="logo-text">NedApp</div>
            </div>
            
            <ul class="nav-list">
                <li class="nav-item active"><a href="#">Overview</a></li>
                <li class="nav-item"><a href="#" onclick="alert('Analytics feature is disabled in demo mode.'); return false;">Analytics</a></li>
                <li class="nav-item"><a href="#" onclick="alert('Settings feature is disabled in demo mode.'); return false;">Settings</a></li>
            </ul>

            <div class="sidebar-footer">
                <asp:Button ID="btnLogout" runat="server" Text="Log Out" CssClass="logout-btn" OnClick="btnLogout_Click" UseSubmitBehavior="false" />
            </div>
        </div>

        <!-- Main Workspace -->
        <div class="main-content">
            <!-- Header section -->
            <div class="header">
                <div class="welcome-title">
                    <h2>Hello, <asp:Label ID="lblUserName" runat="server"></asp:Label>!</h2>
                    <p>Welcome to your personal workspace. Here is your overview.</p>
                </div>

                <div class="user-profile">
                    <div class="avatar">
                        <asp:Label ID="lblAvatar" runat="server"></asp:Label>
                    </div>
                    <div class="user-info">
                        <div class="user-name"><asp:Label ID="lblProfileName" runat="server"></asp:Label></div>
                        <div class="user-role">Member Account</div>
                    </div>
                </div>
            </div>

            <!-- Stats Grid row -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Total Tasks</h3>
                        <p><asp:Label ID="lblTotalTasks" runat="server">0</asp:Label></p>
                    </div>
                    <div class="stat-icon total">📋</div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Completed</h3>
                        <p><asp:Label ID="lblCompletedTasks" runat="server">0</asp:Label></p>
                    </div>
                    <div class="stat-icon completed">✅</div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <h3>Efficiency</h3>
                        <p><asp:Label ID="lblEfficiency" runat="server">0%</asp:Label></p>
                    </div>
                    <div class="stat-icon efficiency">⚡</div>
                </div>
            </div>

            <!-- Action panels Split -->
            <div class="content-split">
                <!-- Column 1: Add task form -->
                <div class="card">
                    <h3>Add Task</h3>
                    <div class="form-group">
                        <asp:TextBox ID="txtTaskName" runat="server" CssClass="form-control" placeholder="e.g. Design homepage layout" AutoCompleteType="Disabled"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnAddTask" runat="server" Text="Create Task" CssClass="btn" OnClick="btnAddTask_Click" />
                </div>

                <!-- Column 2: Tasks list view -->
                <div class="card">
                    <h3>Current Tasks</h3>
                    
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
                        No tasks in progress. Create your first task to get started!
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
