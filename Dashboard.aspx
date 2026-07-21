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

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        body {
            font-family: 'Inter', 'Outfit', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-primary);
        }

        form#form1 {
            display: flex;
            flex-direction: column;
            height: 100vh;
            height: 100dvh;
            overflow: hidden;
            margin: 0;
            padding: 0;
        }

        /* 1. Top Header Bar */
        .top-header {
            background-color: var(--header-bg);
            border-bottom: 2px solid var(--maroon);
            padding: 6px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            flex-shrink: 0;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .title-group {
            display: flex;
            flex-direction: column;
        }

        .main-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--maroon);
            line-height: 1.15;
        }

        .sub-title {
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--green);
            margin-top: 1px;
        }

        .role-line {
            font-size: 0.72rem;
            font-weight: 500;
            color: var(--navy);
            margin-top: 1px;
            letter-spacing: 0.2px;
        }

        .header-right {
            text-align: right;
        }

        .system-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--navy);
            letter-spacing: -0.5px;
        }

        /* 2. Sub-Header Info Bar */
        .info-bar {
            background-color: var(--info-bar-bg);
            padding: 4px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.78rem;
            border-bottom: 1px solid var(--card-border);
            flex-shrink: 0;
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
            font-size: 0.78rem;
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
            flex-shrink: 0;
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
            padding: 6px 14px;
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.82rem;
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
            padding: 4px 0;
            border-radius: 0 0 4px 4px;
        }

        .menu-item:hover .dropdown-menu {
            display: block;
        }

        .dropdown-item a {
            display: block;
            padding: 8px 14px;
            color: var(--text-primary);
            text-decoration: none;
            font-size: 0.8rem;
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
            padding: 4px;
            text-align: center;
            border-bottom: 1px solid var(--card-border);
            flex-shrink: 0;
        }

        .page-title {
            font-size: 0.92rem;
            font-weight: 700;
            color: var(--navy);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Main container layout */
        .main-container {
            flex: 1;
            min-height: 0;
            padding: 8px 12px;
            width: 100%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 8px;
            overflow: hidden;
        }

        /* 5. Split Panels */
        .panels-grid {
            flex: 1;
            min-height: 0;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 8px;
            overflow: hidden;
        }

        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.03);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
            min-height: 0;
        }

        .card-header {
            padding: 6px 12px;
            color: white;
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }

        .card-header.data-entry {
            background-color: var(--data-entry-header);
        }

        .card-header.data-view {
            background-color: var(--data-view-header);
        }

        .card-body {
            padding: 8px 12px;
            flex: 1;
            min-height: 0;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }

        /* Two-Column Form Layout */
        .form-columns {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        @media (max-width: 768px) {
            .form-columns {
                grid-template-columns: 1fr;
            }
        }

        .form-column {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 130px 1fr;
            gap: 4px;
            align-items: center;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.79rem;
            color: var(--text-primary);
            text-align: right;
        }

        .form-input-entry {
            width: 100%;
            height: 29px;
            padding: 4px 8px;
            font-size: 0.79rem;
            color: #1e293b;
            background-color: #ffffff;
            border: 1px solid #fca5a5; /* Light Red Border */
            border-radius: 4px;
            outline: none;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s, background-color 0.2s;
        }

        .form-input-entry:focus {
            border-color: #ef4444;
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.18);
        }

        .form-input-entry[readonly] {
            background-color: #f8fafc;
            border-color: #fca5a5;
            color: #475569;
            cursor: not-allowed;
        }

        /* Search / Lookup fields with icon buttons (Slightly darker shade to differentiate from normal textboxes) */
        .input-with-icon .form-input-entry {
            background-color: #eef2f7; /* Subtle darker shade than normal pure white textboxes */
            border: 1px solid #f87171; /* Light Red Border */
            padding-right: 32px; /* room for small blue square search icon */
        }

        .input-with-icon .form-input-entry:focus {
            background-color: #e2e8f0;
            border-color: #ef4444;
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.2);
        }

        .input-with-icon .form-input-entry[readonly] {
            background-color: #e2e8f0;
            border-color: #fca5a5;
            color: #475569;
        }

        /* Asset Tag Box */
        .asset-tag-box {
            background-color: #f8fafc;
            border: 1px solid var(--card-border);
            border-radius: 6px;
            padding: 4px 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 8px;
            flex-shrink: 0;
        }

        .tag-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .tag-right {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .status-badge-large {
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 2px 8px;
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
            width: 48px;
            height: 48px;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .qr-image {
            width: 42px;
            height: 42px;
        }

        .btn-print-qr {
            background-color: #475569;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 4px 8px;
            font-size: 0.7rem;
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
            margin-bottom: 6px;
            flex-shrink: 0;
            align-items: center;
        }

        .search-input {
            flex: 1;
            height: 29px;
            padding: 4px 8px;
            font-size: 0.79rem;
            color: #1e293b;
            background-color: #ffffff;
            border: 1px solid #fca5a5; /* Light Red Border */
            border-radius: 4px;
            outline: none;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .search-input:focus {
            border-color: #ef4444;
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.18);
        }

        .search-btn {
            background-color: var(--navy);
            color: white;
            border: none;
            border-radius: 4px;
            height: 28px;
            padding: 0 12px;
            font-size: 0.76rem;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .search-btn:hover {
            background-color: #0b3c8f;
        }

        .assets-table-container {
            flex: 1;
            min-height: 0;
            overflow-y: auto;
            max-height: none;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
        }

        .assets-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.76rem;
        }

        .assets-table th, .assets-table td {
            padding: 5px 8px;
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

        /* Error / Notification Message Styling */
        .msg-label {
            display: block;
            font-size: 0.78rem;
            padding: 6px 12px;
            border-radius: 4px;
            margin-bottom: 8px;
            text-align: center;
            font-weight: 600;
            flex-shrink: 0;
        }

        .error-msg {
            color: #b91c1c;
            background-color: #fef2f2;
            border: 1px solid #fca5a5;
        }

        /* 6. Bottom Action Bar (Toolbar) */
        .action-toolbar {
            background-color: #0f172a;
            border-top: 1px solid #1e3a8a; /* Thin lighter-blue top border */
            padding: 6px 16px;
            display: flex;
            justify-content: center; /* Horizontally centered tight group */
            align-items: center;
            gap: 6px;
            width: 100%;
            margin-top: 0;
            flex-shrink: 0;
        }

        .toolbar-btn {
            background-color: #f4f6f9;
            color: #1e293b;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            height: 29px;
            padding: 0 12px;
            font-size: 0.79rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.2s, border-color 0.2s, transform 0.1s;
        }

        .footer {
            background-color: #0f172a;
            color: #94a3b8;
            padding: 4px 16px;
            text-align: center;
            font-size: 0.72rem;
            border-top: 1px solid #1e293b;
            flex-shrink: 0;
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

        body.no-scroll {
            overflow: hidden !important;
        }

        /* Strict background interaction block when modal is open */
        body.no-scroll .top-header,
        body.no-scroll .info-bar,
        body.no-scroll .menu-bar,
        body.no-scroll .page-title-bar,
        body.no-scroll .main-container,
        body.no-scroll .action-toolbar,
        body.no-scroll .footer {
            pointer-events: none !important;
            user-select: none !important;
        }

        /* Search Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.65); /* Dimmed background */
            z-index: 999999;
            display: flex;
            justify-content: center;
            align-items: center;
            pointer-events: auto !important;
            backdrop-filter: blur(3px);
        }

        .modal-box {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #ffffff;
            border: 1px solid var(--card-border);
            border-radius: 8px;
            width: 480px;
            max-width: 90vw;
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.35);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            z-index: 1000000;
            animation: modalFadeIn 0.2s ease-out;
            pointer-events: auto !important;
        }

        @keyframes modalFadeIn {
            from { transform: translate(-50%, -50%) scale(0.95); opacity: 0; }
            to { transform: translate(-50%, -50%) scale(1); opacity: 1; }
        }

        .modal-search-grid {
            display: grid;
            grid-template-columns: 120px 1fr;
            gap: 10px 8px;
            align-items: center;
            margin-bottom: 12px;
        }

        .modal-label {
            font-weight: 600;
            font-size: 0.8rem;
            color: var(--text-primary);
            text-align: right;
        }

        .modal-input {
            width: 100%;
            padding: 6px 10px;
            font-size: 0.8rem;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            outline: none;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        .modal-input:focus {
            border-color: var(--orange-border);
        }

        .modal-header {
            background-color: var(--data-entry-header);
            color: #ffffff;
            padding: 12px 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-weight: 700;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .modal-close-btn {
            background: rgba(255, 255, 255, 0.15);
            border: none;
            color: #ffffff;
            font-size: 1.25rem;
            font-weight: 700;
            font-family: Arial, sans-serif;
            cursor: pointer;
            transition: background-color 0.2s, opacity 0.2s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
            border-radius: 4px;
            line-height: 1;
        }

        .modal-close-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: #ffffff;
            text-decoration: none;
            opacity: 1;
        }

        .modal-body {
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .modal-search-inputs {
            display: flex;
            gap: 8px;
        }

        .modal-search-input {
            flex: 1;
            padding: 8px 12px;
            font-size: 0.85rem;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            outline: none;
            transition: border-color 0.2s;
        }

        .modal-search-input:focus {
            border-color: var(--orange-border);
        }

        .modal-search-btn {
            background-color: var(--navy);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 16px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .modal-search-btn:hover {
            background-color: #0b3c8f;
        }

        .modal-results-container {
            max-height: 250px;
            overflow-y: auto;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
        }

        .modal-results-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.8rem;
        }

        .modal-results-table th, .modal-results-table td {
            padding: 8px 10px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .modal-results-table th {
            background-color: #f8fafc;
            font-weight: 600;
            color: var(--text-secondary);
            position: sticky;
            top: 0;
            z-index: 5;
        }

        .modal-row {
            cursor: pointer;
            transition: background-color 0.15s;
        }

        .modal-row:hover {
            background-color: #f1f5f9;
        }

        .modal-row-id {
            color: var(--navy);
            font-weight: 700;
        }

        .modal-no-results {
            padding: 16px;
            text-align: center;
            color: var(--text-secondary);
            font-style: italic;
            font-size: 0.85rem;
        }

        .modal-footer {
            padding: 12px 16px;
            border-top: 1px solid #cbd5e1;
            display: flex;
            justify-content: flex-end;
            background-color: #f8fafc;
        }

        .modal-footer-cancel-btn {
            background-color: #e2e8f0;
            color: var(--text-primary);
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            padding: 6px 14px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .modal-footer-cancel-btn:hover {
            background-color: #cbd5e1;
        }

        body.no-scroll {
            overflow: hidden !important;
            height: 100vh !important;
            width: 100vw !important;
            position: fixed !important;
        }

        /* ── Lookup icon wrapper ─────────────────────────────────────────── */
        .input-with-icon {
            position: relative;
            display: flex;
            align-items: center;
            width: 100%;
        }

        .lookup-icon {
            position: absolute;
            right: 4px;
            width: 22px;
            height: 22px;
            background-color: #2563eb; /* Small blue square search icon */
            color: #ffffff;
            border: none;
            border-radius: 3px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.72rem;
            cursor: pointer;
            text-decoration: none;
            line-height: 1;
            transition: background-color 0.2s, transform 0.1s;
            box-shadow: 0 1px 2px rgba(0,0,0,0.12);
        }

        .lookup-icon:hover {
            background-color: #1d4ed8;
        }

        .lookup-icon:active {
            transform: scale(0.95);
        }

        /* Disable icon while field is read-only */
        .form-input-entry[readonly] ~ .lookup-icon {
            opacity: 0.4;
            pointer-events: none;
            cursor: default;
        }

        /* ── Lookup popup ────────────────────────────────────────────────── */
        .lookup-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.45);
            z-index: 2000;
            display: none;
            justify-content: center;
            align-items: center;
        }

        .lookup-overlay.is-open {
            display: flex;
        }

        .lookup-box {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #ffffff;
            border: 1px solid var(--card-border);
            border-radius: 8px;
            width: 380px;
            max-width: 92vw;
            box-shadow: 0 10px 28px rgba(0,0,0,0.18);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            animation: modalFadeIn 0.18s ease-out;
        }

        .lookup-header {
            background: var(--data-entry-header);
            color: #fff;
            padding: 10px 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .lookup-title {
            font-weight: 700;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        .lookup-close {
            background: none;
            border: none;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            transition: opacity 0.2s;
            padding: 0;
            line-height: 1;
        }

        .lookup-close:hover { opacity: 0.75; }

        .lookup-body {
            padding: 12px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .lookup-search-input {
            width: 100%;
            padding: 7px 10px;
            font-size: 0.82rem;
            border: 1px solid #cbd5e1;
            border-radius: 4px;
            outline: none;
            font-family: inherit;
            transition: border-color 0.2s;
            box-sizing: border-box;
        }

        .lookup-search-input:focus {
            border-color: var(--orange-border);
            box-shadow: 0 0 0 2px rgba(249,115,22,0.2);
        }

        .lookup-results {
            max-height: 240px;
            overflow-y: auto;
            border: 1px solid #e2e8f0;
            border-radius: 4px;
        }

        .lookup-item {
            padding: 8px 12px;
            font-size: 0.82rem;
            cursor: pointer;
            border-bottom: 1px solid #f1f5f9;
            transition: background 0.12s;
            color: var(--text-primary);
        }

        .lookup-item:last-child { border-bottom: none; }

        .lookup-item:hover {
            background: #eff6ff;
            color: var(--navy);
            font-weight: 600;
        }

        .lookup-msg {
            padding: 14px;
            text-align: center;
            font-size: 0.82rem;
            color: var(--text-secondary);
            font-style: italic;
        }

        .lookup-msg.error {
            color: var(--error-color);
            font-style: normal;
        }
    </style>
</head>
<body class='<%= If(IsSearchModalOpen OrElse IsCategoryLookupOpen OrElse IsBrandLookupOpen OrElse IsSectionLookupOpen OrElse IsBudgetLookupOpen OrElse IsSupplierLookupOpen OrElse IsPurchaseFYLookupOpen OrElse IsFirstDeprFYLookupOpen OrElse IsLastDeprFYLookupOpen OrElse IsDisposalReasonLookupOpen, "no-scroll", "") %>'>
    <form id="form1" runat="server" autocomplete="off">
        <!-- 1. Top Header Bar -->
        <header class="top-header">
            <div class="header-left">
                <div class="title-group">
                    <span class="main-title">
                        <asp:Label ID="lblInstitutionName" runat="server">NED University of Engineering & Technology</asp:Label>
                    </span>
                    <span class="sub-title">
                        <asp:Label ID="lblDepartmentName" runat="server">Department of Information Technology</asp:Label>
                    </span>
                    <span class="role-line">
                        <asp:Label ID="lblUserRole" runat="server">Role: Admin</asp:Label>
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
                        <asp:Label ID="lblFormMessage" runat="server" CssClass="msg-label error-msg" style="display:none;"></asp:Label>
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
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                 <div class="form-row">
                                     <label class="form-label">Asset Category:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtCategory" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenCategoryLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenCategoryLookup_Click" UseSubmitBehavior="false" Title="Browse categories">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                 <div class="form-row">
                                     <label class="form-label">Brand:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtBrand" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenBrandLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenBrandLookup_Click" UseSubmitBehavior="false" Title="Browse brands">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                <div class="form-row">
                                    <label class="form-label">Model No.:</label>
                                    <asp:TextBox ID="txtModelNo" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Serial No.:</label>
                                    <asp:TextBox ID="txtSerialNo" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                 <div class="form-row">
                                     <label class="form-label">Section:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtSection" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenSectionLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenSectionLookup_Click" UseSubmitBehavior="false" Title="Browse sections">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                <div class="form-row">
                                    <label class="form-label">Location:</label>
                                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Employee:</label>
                                    <asp:TextBox ID="txtEmployee" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                 <div class="form-row">
                                     <label class="form-label">Budget utilized from:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtBudgetUtilizedFrom" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenBudgetLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenBudgetLookup_Click" UseSubmitBehavior="false" Title="Browse budget accounts">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                 <div class="form-row">
                                     <label class="form-label">Supplier:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtSupplier" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenSupplierLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenSupplierLookup_Click" UseSubmitBehavior="false" Title="Browse suppliers">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                <div class="form-row">
                                    <label class="form-label">Invoice No.:</label>
                                    <asp:TextBox ID="txtInvoiceNo" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Contract Sch. No.:</label>
                                    <asp:TextBox ID="txtContractSchNo" runat="server" CssClass="form-input-entry"></asp:TextBox>
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
                                    <asp:TextBox ID="txtOriginalCost" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Current Value:</label>
                                    <asp:TextBox ID="txtCurrentValue" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Acc. Deprec.:</label>
                                    <asp:TextBox ID="txtAccDeprec" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">FY Opening Bal.:</label>
                                    <asp:TextBox ID="txtFYOpeningBal" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">FY Closing Bal.:</label>
                                    <asp:TextBox ID="txtFYClosingBal" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Dep. Start Date:</label>
                                    <asp:TextBox ID="txtDepStartDate" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                 <div class="form-row">
                                     <label class="form-label">First Depr. FY:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtFirstDeprFY" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenFirstDeprFYLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenFirstDeprFYLookup_Click" UseSubmitBehavior="false" Title="Browse financial years">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                 <div class="form-row">
                                     <label class="form-label">Last Depr. FY:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtLastDeprFY" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenLastDeprFYLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenLastDeprFYLookup_Click" UseSubmitBehavior="false" Title="Browse financial years">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                 <div class="form-row">
                                     <label class="form-label">Purchase Date:</label>
                                     <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                 </div>
                                 <div class="form-row">
                                     <label class="form-label">Purchase FY:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtPurchaseFY" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenPurchaseFYLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenPurchaseFYLookup_Click" UseSubmitBehavior="false" Title="Browse financial years">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                <div class="form-row">
                                    <label class="form-label">Warranty Exp.:</label>
                                    <asp:TextBox ID="txtWarrantyExp" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Disposal Date:</label>
                                    <asp:TextBox ID="txtDisposalDate" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                 <div class="form-row">
                                     <label class="form-label">Dispos. Reason:</label>
                                     <div class="input-with-icon">
                                         <asp:TextBox ID="txtDisposalReason" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                         <asp:LinkButton ID="btnOpenDisposalReasonLookup" runat="server" CssClass="lookup-icon" OnClick="btnOpenDisposalReasonLookup_Click" UseSubmitBehavior="false" Title="Browse disposal reasons">&#128269;</asp:LinkButton>
                                     </div>
                                 </div>
                                <div class="form-row">
                                    <label class="form-label">Remarks:</label>
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Enter By:</label>
                                    <asp:TextBox ID="txtEnterBy" runat="server" CssClass="form-input-entry"></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <label class="form-label">Entry Date:</label>
                                    <asp:TextBox ID="txtEntryDate" runat="server" CssClass="form-input-entry"></asp:TextBox>
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
                            <asp:TextBox ID="txtSearchQuery" runat="server" CssClass="search-input"></asp:TextBox>
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
            <asp:LinkButton ID="btnSave" runat="server" CssClass="toolbar-btn" OnClick="btnSave_Click" OnClientClick="return validateDataEntryForm();" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-blue"></span>Save
            </asp:LinkButton>
            <asp:LinkButton ID="btnCancel" runat="server" CssClass="toolbar-btn" OnClick="btnCancel_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-gray"></span>Cancel
            </asp:LinkButton>
            <asp:LinkButton ID="btnSearch" runat="server" CssClass="toolbar-btn" OnClick="btnSearchOpen_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-gray"></span>Search
            </asp:LinkButton>
            <asp:LinkButton ID="btnPrint" runat="server" CssClass="toolbar-btn" OnClientClick="window.print(); return false;" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-gray"></span>Print
            </asp:LinkButton>
            <asp:LinkButton ID="btnExit" runat="server" CssClass="toolbar-btn" OnClick="btnLogout_Click" UseSubmitBehavior="false">
                <span class="btn-icon-block bg-red"></span>Exit
            </asp:LinkButton>
        </div>

        <!-- Overlay for Search Modal -->
        <div id="searchModalOverlay" class="modal-overlay" style='<%= If(IsSearchModalOpen, "display:flex;", "display:none;") %>'>
            <div id="searchModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Search Assets</span>
                    <asp:LinkButton ID="btnModalClose" runat="server" OnClick="btnCloseModal_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div class="modal-search-grid">
                        <label class="modal-label">Asset ID:</label>
                        <asp:TextBox ID="txtModalAssetId" runat="server" CssClass="modal-input"></asp:TextBox>
                        
                        <label class="modal-label">Purchase Date:</label>
                        <asp:TextBox ID="txtModalPurchaseDate" runat="server" CssClass="modal-input"></asp:TextBox>
                        
                        <label class="modal-label">Brand:</label>
                        <asp:TextBox ID="txtModalBrand" runat="server" CssClass="modal-input"></asp:TextBox>
                        
                        <label class="modal-label">Category:</label>
                        <asp:TextBox ID="txtModalCategory" runat="server" CssClass="modal-input"></asp:TextBox>
                        
                        <label class="modal-label">Section:</label>
                        <asp:TextBox ID="txtModalSection" runat="server" CssClass="modal-input"></asp:TextBox>
                    </div>
                    <div style="text-align: right; margin-bottom: 8px;">
                        <asp:Button ID="btnModalSearch" runat="server" Text="Search" OnClick="btnModalSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>Asset ID</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptModalResults" runat="server" OnItemCommand="rptModalResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="var link = document.getElementById('<%# CType(Container.FindControl("lnkSelectModalAsset"), LinkButton).ClientID %>'); if(link) link.click();">
                                            <td class="modal-row-id">
                                                <asp:LinkButton ID="lnkSelectModalAsset" runat="server" CommandName="Select" CommandArgument='<%# Eval("AssetId") %>' Text='<%# Eval("AssetId") %>' style="display:none;" />
                                                <%# Eval("AssetId") %>
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
                        <asp:Panel ID="pnlNoModalResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No assets matched your search.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnModalCancel" runat="server" OnClick="btnCloseModal_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Category Lookup Modal -->
        <div id="categoryLookupOverlay" class="modal-overlay" style='<%= If(IsCategoryLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="categoryLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Category</span>
                    <asp:LinkButton ID="btnCloseCategoryLookup" runat="server" OnClick="btnCloseCategoryLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtCategorySearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnCategorySearch" runat="server" Text="Search" OnClick="btnCategorySearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblCategoryError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load categories</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>Category ID</th>
                                    <th>Category Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptCategoryResults" runat="server" OnItemCommand="rptCategoryResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectCategoryValue('<%# HttpUtility.JavaScriptStringEncode(Eval("CategoryName").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("CategoryId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("CategoryName")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoCategoryResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No categories found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnCategoryCancel" runat="server" OnClick="btnCloseCategoryLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Brand Lookup Modal -->
        <div id="brandLookupOverlay" class="modal-overlay" style='<%= If(IsBrandLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="brandLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Brand</span>
                    <asp:LinkButton ID="btnCloseBrandLookup" runat="server" OnClick="btnCloseBrandLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtBrandSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnBrandSearch" runat="server" Text="Search" OnClick="btnBrandSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblBrandError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load brands</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>Brand ID</th>
                                    <th>Brand Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptBrandResults" runat="server" OnItemCommand="rptBrandResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectBrandValue('<%# HttpUtility.JavaScriptStringEncode(Eval("BrandName").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("BrandId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("BrandName")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoBrandResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No brands found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnBrandCancel" runat="server" OnClick="btnCloseBrandLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Section Lookup Modal -->
        <div id="sectionLookupOverlay" class="modal-overlay" style='<%= If(IsSectionLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="sectionLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Section</span>
                    <asp:LinkButton ID="btnCloseSectionLookup" runat="server" OnClick="btnCloseSectionLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtSectionSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnSectionSearch" runat="server" Text="Search" OnClick="btnSectionSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblSectionError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load sections</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>Section ID</th>
                                    <th>Section Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptSectionResults" runat="server" OnItemCommand="rptSectionResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectSectionValue('<%# HttpUtility.JavaScriptStringEncode(Eval("SectionName").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("SectionId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("SectionName")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoSectionResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No sections found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnSectionCancel" runat="server" OnClick="btnCloseSectionLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Budget Utilized From Lookup Modal -->
        <div id="budgetLookupOverlay" class="modal-overlay" style='<%= If(IsBudgetLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="budgetLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Budget Account</span>
                    <asp:LinkButton ID="btnCloseBudgetLookup" runat="server" OnClick="btnCloseBudgetLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtBudgetSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnBudgetSearch" runat="server" Text="Search" OnClick="btnBudgetSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblBudgetError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load budget accounts</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>Account ID</th>
                                    <th>Budget Account Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptBudgetResults" runat="server" OnItemCommand="rptBudgetResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectBudgetValue('<%# HttpUtility.JavaScriptStringEncode(Eval("BudgetAccountName").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("BudgetAccountId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("BudgetAccountName")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoBudgetResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No budget accounts found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnBudgetCancel" runat="server" OnClick="btnCloseBudgetLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Supplier Lookup Modal -->
        <div id="supplierLookupOverlay" class="modal-overlay" style='<%= If(IsSupplierLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="supplierLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Supplier</span>
                    <asp:LinkButton ID="btnCloseSupplierLookup" runat="server" OnClick="btnCloseSupplierLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtSupplierSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnSupplierSearch" runat="server" Text="Search" OnClick="btnSupplierSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblSupplierError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load suppliers</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>Supplier ID</th>
                                    <th>Supplier Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptSupplierResults" runat="server" OnItemCommand="rptSupplierResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectSupplierValue('<%# HttpUtility.JavaScriptStringEncode(Eval("SupplierName").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("SupplierId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("SupplierName")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoSupplierResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No suppliers found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnSupplierCancel" runat="server" OnClick="btnCloseSupplierLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Purchase FY Lookup Modal -->
        <div id="purchaseFYLookupOverlay" class="modal-overlay" style='<%= If(IsPurchaseFYLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="purchaseFYLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Purchase Financial Year</span>
                    <asp:LinkButton ID="btnClosePurchaseFYLookup" runat="server" OnClick="btnClosePurchaseFYLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtPurchaseFYSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnPurchaseFYSearch" runat="server" Text="Search" OnClick="btnPurchaseFYSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblPurchaseFYError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load financial years</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>FY ID</th>
                                    <th>Financial Year</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptPurchaseFYResults" runat="server" OnItemCommand="rptPurchaseFYResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectPurchaseFYValue('<%# HttpUtility.JavaScriptStringEncode(Eval("FyLabel").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("FyId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("FyLabel")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoPurchaseFYResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No financial years found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnPurchaseFYCancel" runat="server" OnClick="btnClosePurchaseFYLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for First Depr FY Lookup Modal -->
        <div id="firstDeprFYLookupOverlay" class="modal-overlay" style='<%= If(IsFirstDeprFYLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="firstDeprFYLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select First Depr Financial Year</span>
                    <asp:LinkButton ID="btnCloseFirstDeprFYLookup" runat="server" OnClick="btnCloseFirstDeprFYLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtFirstDeprFYSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnFirstDeprFYSearch" runat="server" Text="Search" OnClick="btnFirstDeprFYSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblFirstDeprFYError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load financial years</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>FY ID</th>
                                    <th>Financial Year</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptFirstDeprFYResults" runat="server" OnItemCommand="rptFirstDeprFYResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectFirstDeprFYValue('<%# HttpUtility.JavaScriptStringEncode(Eval("FyLabel").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("FyId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("FyLabel")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoFirstDeprFYResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No financial years found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnFirstDeprFYCancel" runat="server" OnClick="btnCloseFirstDeprFYLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Last Depr FY Lookup Modal -->
        <div id="lastDeprFYLookupOverlay" class="modal-overlay" style='<%= If(IsLastDeprFYLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="lastDeprFYLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Last Depr Financial Year</span>
                    <asp:LinkButton ID="btnCloseLastDeprFYLookup" runat="server" OnClick="btnCloseLastDeprFYLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtLastDeprFYSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnLastDeprFYSearch" runat="server" Text="Search" OnClick="btnLastDeprFYSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblLastDeprFYError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load financial years</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>FY ID</th>
                                    <th>Financial Year</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptLastDeprFYResults" runat="server" OnItemCommand="rptLastDeprFYResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectLastDeprFYValue('<%# HttpUtility.JavaScriptStringEncode(Eval("FyLabel").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("FyId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("FyLabel")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoLastDeprFYResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No financial years found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnLastDeprFYCancel" runat="server" OnClick="btnCloseLastDeprFYLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <!-- Overlay for Disposal Reason Lookup Modal -->
        <div id="disposalReasonLookupOverlay" class="modal-overlay" style='<%= If(IsDisposalReasonLookupOpen, "display:flex;", "display:none;") %>'>
            <div id="disposalReasonLookupModalBox" class="modal-box">
                <div class="modal-header">
                    <span class="modal-title">Select Disposal Reason</span>
                    <asp:LinkButton ID="btnCloseDisposalReasonLookup" runat="server" OnClick="btnCloseDisposalReasonLookup_Click" CssClass="modal-close-btn" Text="&amp;times;" UseSubmitBehavior="false" />
                </div>
                <div class="modal-body">
                    <div style="display: flex; gap: 8px; margin-bottom: 8px;">
                        <asp:TextBox ID="txtDisposalReasonSearch" runat="server" CssClass="modal-search-input"></asp:TextBox>
                        <asp:Button ID="btnDisposalReasonSearch" runat="server" Text="Search" OnClick="btnDisposalReasonSearch_Click" CssClass="modal-search-btn" UseSubmitBehavior="true" />
                    </div>
                    <div class="modal-results-container">
                        <asp:Label ID="lblDisposalReasonError" runat="server" CssClass="modal-no-results" Visible="false">Unable to load disposal reasons</asp:Label>
                        <table class="modal-results-table">
                            <thead>
                                <tr>
                                    <th>Reason ID</th>
                                    <th>Disposal Reason</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptDisposalReasonResults" runat="server" OnItemCommand="rptDisposalReasonResults_ItemCommand">
                                    <ItemTemplate>
                                        <tr class="modal-row" ondblclick="selectDisposalReasonValue('<%# HttpUtility.JavaScriptStringEncode(Eval("DisposalReasonName").ToString()) %>');">
                                            <td class="modal-row-id"><%# Eval("DisposalReasonId") %></td>
                                            <td>
                                                <span class="select-link"><%# HttpUtility.HtmlEncode(Eval("DisposalReasonName")) %></span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <asp:Panel ID="pnlNoDisposalReasonResults" runat="server" Visible="false" CssClass="modal-no-results">
                            No disposal reasons found.
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnDisposalReasonCancel" runat="server" OnClick="btnCloseDisposalReasonLookup_Click" CssClass="modal-footer-cancel-btn" Text="Cancel" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var modalConfigs = [
                { overlayId: "searchModalOverlay", boxId: "searchModalBox", inputId: "<%= txtModalAssetId.ClientID %>", closeBtnId: "<%= btnModalClose.ClientID %>" },
                { overlayId: "categoryLookupOverlay", boxId: "categoryLookupModalBox", inputId: "<%= txtCategorySearch.ClientID %>", closeBtnId: "<%= btnCloseCategoryLookup.ClientID %>" },
                { overlayId: "brandLookupOverlay", boxId: "brandLookupModalBox", inputId: "<%= txtBrandSearch.ClientID %>", closeBtnId: "<%= btnCloseBrandLookup.ClientID %>" },
                { overlayId: "sectionLookupOverlay", boxId: "sectionLookupModalBox", inputId: "<%= txtSectionSearch.ClientID %>", closeBtnId: "<%= btnCloseSectionLookup.ClientID %>" },
                { overlayId: "budgetLookupOverlay", boxId: "budgetLookupModalBox", inputId: "<%= txtBudgetSearch.ClientID %>", closeBtnId: "<%= btnCloseBudgetLookup.ClientID %>" },
                { overlayId: "supplierLookupOverlay", boxId: "supplierLookupModalBox", inputId: "<%= txtSupplierSearch.ClientID %>", closeBtnId: "<%= btnCloseSupplierLookup.ClientID %>" },
                { overlayId: "purchaseFYLookupOverlay", boxId: "purchaseFYLookupModalBox", inputId: "<%= txtPurchaseFYSearch.ClientID %>", closeBtnId: "<%= btnClosePurchaseFYLookup.ClientID %>" },
                { overlayId: "firstDeprFYLookupOverlay", boxId: "firstDeprFYLookupModalBox", inputId: "<%= txtFirstDeprFYSearch.ClientID %>", closeBtnId: "<%= btnCloseFirstDeprFYLookup.ClientID %>" },
                { overlayId: "lastDeprFYLookupOverlay", boxId: "lastDeprFYLookupModalBox", inputId: "<%= txtLastDeprFYSearch.ClientID %>", closeBtnId: "<%= btnCloseLastDeprFYLookup.ClientID %>" },
                { overlayId: "disposalReasonLookupOverlay", boxId: "disposalReasonLookupModalBox", inputId: "<%= txtDisposalReasonSearch.ClientID %>", closeBtnId: "<%= btnCloseDisposalReasonLookup.ClientID %>" }
            ];

            function initModalOverlayHandlers() {
                modalConfigs.forEach(function(m) {
                    var overlay = document.getElementById(m.overlayId);
                    var box = document.getElementById(m.boxId);
                    if (overlay && box) {
                        if (!overlay.getAttribute("data-handlers-attached")) {
                            overlay.setAttribute("data-handlers-attached", "true");

                            // Stop click and double click inside modal box from bubbling up to backdrop overlay
                            box.addEventListener("click", function(e) { e.stopPropagation(); });
                            box.addEventListener("dblclick", function(e) { e.stopPropagation(); });

                            // Any click (single, double, multiple) on backdrop overlay: absorb click, keep popup open, refocus search input
                            overlay.addEventListener("click", function(e) {
                                if (e.target === overlay || !box.contains(e.target)) {
                                    e.stopPropagation();
                                    e.preventDefault();
                                    var inp = document.getElementById(m.inputId);
                                    if (inp) inp.focus();
                                }
                            });

                            // Focus trap: keep Tab navigation inside the popup box
                            box.addEventListener("keydown", function(e) {
                                if (e.key === "Tab") {
                                    var focusables = box.querySelectorAll("input, button, a[href], select, textarea, [tabindex]:not([tabindex='-1'])");
                                    if (focusables.length === 0) return;
                                    var first = focusables[0];
                                    var last = focusables[focusables.length - 1];

                                    if (e.shiftKey) {
                                        if (document.activeElement === first) {
                                            last.focus();
                                            e.preventDefault();
                                        }
                                    } else {
                                        if (document.activeElement === last) {
                                            first.focus();
                                            e.preventDefault();
                                        }
                                    }
                                }
                            });
                        }

                        // Auto focus search field when opened
                        if (overlay.style.display !== "none" && getComputedStyle(overlay).display !== "none") {
                            document.body.classList.add("no-scroll");
                            setTimeout(function() {
                                var inp = document.getElementById(m.inputId);
                                if (inp) {
                                    inp.focus();
                                    if (typeof inp.select === "function") inp.select();
                                }
                            }, 50);
                        }
                    }
                });
            }

            // Bind handlers on load, DOMContentLoaded, window load, and WebForms request end
            initModalOverlayHandlers();
            document.addEventListener("DOMContentLoaded", initModalOverlayHandlers);
            window.addEventListener("load", initModalOverlayHandlers);
            if (typeof Sys !== "undefined" && Sys.WebForms && Sys.WebForms.PageRequestManager) {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(initModalOverlayHandlers);
            }

            // Disable browser autocomplete dropdowns site-wide
            function disableAutocompleteSiteWide() {
                var inputs = document.querySelectorAll("input, select, textarea");
                inputs.forEach(function(el) {
                    el.setAttribute("autocomplete", "off");
                    el.setAttribute("autocorrect", "off");
                    el.setAttribute("autocapitalize", "off");
                    el.setAttribute("spellcheck", "false");
                });
            }
            disableAutocompleteSiteWide();
            document.addEventListener("DOMContentLoaded", disableAutocompleteSiteWide);
            window.addEventListener("load", disableAutocompleteSiteWide);
            if (typeof Sys !== "undefined" && Sys.WebForms && Sys.WebForms.PageRequestManager) {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(disableAutocompleteSiteWide);
            }

            function hideAllModalOverlays() {
                var modals = ['searchModalOverlay', 'categoryLookupOverlay', 'brandLookupOverlay', 'sectionLookupOverlay', 'budgetLookupOverlay', 'supplierLookupOverlay', 'purchaseFYLookupOverlay', 'firstDeprFYLookupOverlay', 'lastDeprFYLookupOverlay', 'disposalReasonLookupOverlay'];
                modals.forEach(function(id) {
                    var el = document.getElementById(id);
                    if (el) el.style.display = 'none';
                });
                document.body.classList.remove('no-scroll');
            }

            function selectCategoryValue(val) {
                var input = document.getElementById('<%= txtCategory.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectBrandValue(val) {
                var input = document.getElementById('<%= txtBrand.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectSectionValue(val) {
                var input = document.getElementById('<%= txtSection.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectBudgetValue(val) {
                var input = document.getElementById('<%= txtBudgetUtilizedFrom.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectSupplierValue(val) {
                var input = document.getElementById('<%= txtSupplier.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectPurchaseFYValue(val) {
                var input = document.getElementById('<%= txtPurchaseFY.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectFirstDeprFYValue(val) {
                var input = document.getElementById('<%= txtFirstDeprFY.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectLastDeprFYValue(val) {
                var input = document.getElementById('<%= txtLastDeprFY.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function selectDisposalReasonValue(val) {
                var input = document.getElementById('<%= txtDisposalReason.ClientID %>');
                if (input) input.value = val;
                hideAllModalOverlays();
            }

            function checkAllModalsClosed() {
                var modals = ['searchModalOverlay', 'categoryLookupOverlay', 'brandLookupOverlay', 'sectionLookupOverlay', 'budgetLookupOverlay', 'supplierLookupOverlay', 'purchaseFYLookupOverlay', 'firstDeprFYLookupOverlay', 'lastDeprFYLookupOverlay', 'disposalReasonLookupOverlay'];
                var anyOpen = false;
                modals.forEach(function(id) {
                    var el = document.getElementById(id);
                    if (el && el.style.display !== 'none' && getComputedStyle(el).display !== 'none') {
                        anyOpen = true;
                    }
                });
                if (!anyOpen) {
                    document.body.classList.remove('no-scroll');
                }
            }

            function validateDataEntryForm() {
                var categoryEl = document.getElementById('<%= txtCategory.ClientID %>');
                var brandEl = document.getElementById('<%= txtBrand.ClientID %>');
                var sectionEl = document.getElementById('<%= txtSection.ClientID %>');
                var budgetEl = document.getElementById('<%= txtBudgetUtilizedFrom.ClientID %>');
                var supplierEl = document.getElementById('<%= txtSupplier.ClientID %>');

                var category = categoryEl ? categoryEl.value.trim() : '';
                var brand = brandEl ? brandEl.value.trim() : '';
                var section = sectionEl ? sectionEl.value.trim() : '';
                var budget = budgetEl ? budgetEl.value.trim() : '';
                var supplier = supplierEl ? supplierEl.value.trim() : '';

                var missing = [];
                if (!category) missing.push("Asset Category");
                if (!brand) missing.push("Brand");
                if (!section) missing.push("Section");
                if (!budget) missing.push("Budget Utilized From");
                if (!supplier) missing.push("Supplier");

                var msgLabel = document.getElementById('<%= lblFormMessage.ClientID %>');

                if (missing.length > 0) {
                    var errorMsg = "Please fill " + missing.join(", ") + ".";
                    if (msgLabel) {
                        msgLabel.innerText = errorMsg;
                        msgLabel.style.display = "block";
                    }
                    return false;
                }

                if (msgLabel) {
                    msgLabel.innerText = "";
                    msgLabel.style.display = "none";
                }
                return true;
            }
        </script>

        <!-- 7. Footer -->
        <footer class="footer">
            Copyright &copy; <asp:Label ID="lblCopyrightDepartment" runat="server"></asp:Label>
        </footer>
    </form>
</body>
</html>

