<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="DefaultPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Asset Management System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-gradient-start: #ffffff;
            --bg-gradient-end: #ffffff;
            --card-bg: #ffffff;
            --card-border: #e2e8f0;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --accent-primary: #6366f1;
            --accent-hover: #4f46e5;
            --input-bg: #f8fafc;
            --input-border: #cbd5e1;
            --error-color: #dc2626;
            --success-color: #16a34a;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Outfit', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: #ffffff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--text-primary);
            padding: 20px;
        }

        .container {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 24px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
        }

        h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 8px;
            background: linear-gradient(to right, #a5b4fc, #818cf8, #c084fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: var(--text-secondary);
            font-size: 0.95rem;
            margin-bottom: 32px;
            font-weight: 300;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-control {
            width: 100%;
            padding: 14px 16px;
            font-size: 1rem;
            color: var(--text-primary);
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 12px;
            outline: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: inherit;
        }

        .form-control:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            background: #ffffff;
        }

        .btn {
            width: 100%;
            padding: 14px;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            background: var(--accent-primary);
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
            font-family: inherit;
            margin-top: 10px;
        }

        .btn:hover {
            background: var(--accent-hover);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.4);
        }

        .btn:active {
            transform: translateY(1px);
            box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
        }

        .msg-label {
            display: block;
            margin-top: 15px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .error-msg {
            color: var(--error-color);
        }

        .success-msg {
            color: var(--success-color);
        }

        .footer-link {
            display: block;
            margin-top: 24px;
            color: var(--text-secondary);
            font-size: 0.9rem;
            text-decoration: none;
        }

        .footer-link a {
            color: var(--accent-primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s ease;
        }

        .footer-link a:hover {
            color: #818cf8;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <div class="container">
            <h1>Asset Management System</h1>
            <p class="subtitle">Sign in to your account</p>
            
            <div class="form-group">
                <label for="<%= txtEmail.ClientID %>" class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomplete="off" autofocus="autofocus"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="<%= txtPassword.ClientID %>" class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" autocomplete="off"></asp:TextBox>
            </div>
            
            <asp:Button ID="btnSubmit" runat="server" Text="Sign In" CssClass="btn" OnClick="btnSubmit_Click" />
            
            <asp:Label ID="lblMessage" runat="server" CssClass="msg-label"></asp:Label>

            <p class="footer-link">
                Don't have an account? <asp:HyperLink ID="lnkSignup" runat="server" NavigateUrl="Register.aspx">Sign Up</asp:HyperLink>
            </p>
        </div>
    </form>
    <script>
        (function () {
            var emailBox    = document.getElementById('<%= txtEmail.ClientID %>');
            var passwordBox = document.getElementById('<%= txtPassword.ClientID %>');
            var submitBtn   = document.getElementById('<%= btnSubmit.ClientID %>');

            // ── 1. Enter on the email / username field ──────────────────────
            // If password is still empty  → move focus to password field.
            // If password already has a value → let Enter submit normally
            //   (falls through to the browser's default form-submit behaviour).
            if (emailBox && passwordBox) {
                emailBox.addEventListener('keydown', function (e) {
                    if (e.key === 'Enter' || e.keyCode === 13) {
                        if (passwordBox.value === '') {
                            e.preventDefault();
                            passwordBox.focus();
                        }
                        // password already filled: default submit fires naturally
                    }
                });
            }

            // ── 2. Enter on the password field ─────────────────────────────
            // Explicitly click the Sign In button so the ASP.NET __doPostBack
            // wired to btnSubmit_Click is triggered — identical to a mouse click.
            if (passwordBox && submitBtn) {
                passwordBox.addEventListener('keydown', function (e) {
                    if (e.key === 'Enter' || e.keyCode === 13) {
                        e.preventDefault();
                        submitBtn.click();
                    }
                });
            }
        })();
    </script>
</body>
</html>
