<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Usuarios.aspx.cs" Inherits="WebApplicationClinica.WebForm_Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .42), rgba(255, 255, 255, .42)), url('Images/fondoInicio.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .navbar {
            margin: 16px;
            border-radius: 14px;
            background: rgba(255, 255, 255, .72) !important;
            box-shadow: 0 12px 32px rgba(15, 23, 42, .12);
            backdrop-filter: blur(10px);
        }

        .navbar .nav-link,
        .navbar .navbar-brand {
            color: #172033;
            font-weight: 500;
        }

        .navbar .navbar-brand {
            color: #0d6efd;
            font-weight: 700;
        }

        .navbar .btn-outline-dark {
            background: rgba(255, 255, 255, .65);
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 8px 20px rgba(15, 23, 42, .08);
        }

        .usuarios-panel {
            margin: 48px auto 72px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .86);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .usuarios-header {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 32px;
        }

        .usuarios-header-icon {
            width: 72px;
            height: 72px;
            border-radius: 16px;
            background: rgba(239, 246, 255, .95);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.3rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
            flex: 0 0 auto;
        }

        .usuarios-filtros {
            display: flex;
            gap: 16px;
            align-items: center;
            margin-bottom: 28px;
        }

        .usuarios-filtros .form-select {
            max-width: 150px;
            min-height: 44px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .usuarios-search {
            position: relative;
            flex: 1;
        }

        .usuarios-search i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 1.1rem;
            z-index: 2;
        }

        .usuarios-search .form-control {
            min-height: 44px;
            padding-left: 48px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .usuarios-table-wrap {
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            overflow: hidden;
            background: rgba(255, 255, 255, .82);
        }

        .usuarios-table-wrap .table {
            margin-bottom: 0;
        }

        .usuarios-table-wrap th {
            background: rgba(248, 250, 252, .88);
            color: #475569;
            font-weight: 700;
            border-bottom-color: rgba(15, 23, 42, .12);
        }

        .usuarios-table-wrap td {
            vertical-align: middle;
        }

        .usuarios-table-wrap .badge.bg-success {
            background-color: #d8f3df !important;
            color: #157347;
            border: 1px solid #a9dfba;
        }

        .usuarios-table-wrap .badge.bg-secondary {
            background-color: #e9ecef !important;
            color: #495057;
            border: 1px solid #ced4da;
        }

        .usuarios-actions {
            margin-top: 24px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="usuarios-panel">
        <div class="usuarios-header">
            <div class="usuarios-header-icon">
                <i class="bi bi-people"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Personal Administrativo</h1>
                <p class="text-muted fs-6 mb-0">Gestión del personal administrativo de la clínica.</p>
            </div>
        </div>

        <div class="usuarios-filtros">
            <asp:DropDownList ID="ddlEstadoUsuarios" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoUsuarios_SelectedIndexChanged">
                <asp:ListItem Text="Activos" Value="activos" />
                <asp:ListItem Text="Inactivos" Value="inactivos" />
                <asp:ListItem Text="Todos" Value="todos" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlRolUsuarios" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlRolUsuarios_SelectedIndexChanged">
                <asp:ListItem Text="Todos" Value="todos" />
                <asp:ListItem Text="Administradores" Value="admin" />
                <asp:ListItem Text="Recepcionistas" Value="recepcion" />
            </asp:DropDownList>

            <div class="usuarios-search">
                <i class="bi bi-search"></i>
                <asp:TextBox ID="txtBuscar" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnTextChanged="txtBuscar_TextChanged"
                    placeholder="Buscar por apellido, nombre o DNI" />
            </div>
        </div>

        <div class="usuarios-table-wrap">
            <asp:GridView ID="dgvUsuarios" runat="server"
                CssClass="table table-hover align-middle"
                AutoGenerateColumns="false"
                DataKeyNames="Id"
                OnRowCommand="dgvUsuarios_RowCommand"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No se encontró personal administrativo.">
                <Columns>
                    <asp:BoundField HeaderText="Rol" DataField="Rol" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="DNI" DataField="DNI" />
                    <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='<%# (bool)Eval("Activo") ? "badge rounded-pill bg-success" : "badge rounded-pill bg-secondary" %>'>
                                <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary">
                                <i class="bi bi-pencil me-1"></i>Editar
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="usuarios-actions">
            <a href="FormularioUsuario.aspx" class="btn btn-primary"><i class="bi bi-plus-lg me-2"></i>Agregar Personal</a>
        </div>
    </div>
</asp:Content>
