<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Paciente.aspx.cs" Inherits="WebApplicationClinica.WebForm_Paciente" %>

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

        .pacientes-panel {
            margin: 48px auto 72px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .86);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .pacientes-header {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 32px;
        }

        .pacientes-header-icon {
            width: 72px;
            height: 72px;
            border-radius: 16px;
            background: rgba(215, 244, 255, .9);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.3rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
            flex: 0 0 auto;
        }

        .pacientes-filtros {
            display: flex;
            gap: 16px;
            align-items: center;
            margin-bottom: 28px;
        }

        .pacientes-filtros .form-select {
            max-width: 140px;
            min-height: 44px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .pacientes-search {
            position: relative;
            flex: 1;
        }

        .pacientes-search i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 1.1rem;
            z-index: 2;
        }

        .pacientes-search .form-control {
            min-height: 44px;
            padding-left: 48px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .pacientes-table-wrap {
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            overflow: hidden;
            background: rgba(255, 255, 255, .82);
        }

        .pacientes-table-wrap .table {
            margin-bottom: 0;
        }

        .pacientes-table-wrap th {
            background: rgba(248, 250, 252, .88);
            color: #475569;
            font-weight: 700;
            border-bottom-color: rgba(15, 23, 42, .12);
        }

        .pacientes-table-wrap td {
            vertical-align: middle;
        }

        .pacientes-table-wrap .badge.bg-success {
            background-color: #d8f3df !important;
            color: #157347;
            border: 1px solid #a9dfba;
        }

        .pacientes-table-wrap .badge.bg-secondary {
            background-color: #e9ecef !important;
            color: #495057;
            border: 1px solid #ced4da;
        }

        .pacientes-actions {
            margin-top: 24px;
        }

        .pacientes-actions .btn,
        .pacientes-table-wrap .btn-outline-primary {
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pacientes-panel">
        <div class="pacientes-header">
            <div class="pacientes-header-icon">
                <i class="bi bi-person"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Pacientes</h1>
                <p class="text-muted fs-6 mb-0">Gestión y administración de pacientes registrados.</p>
            </div>
        </div>

        <div class="pacientes-filtros">
            <asp:DropDownList ID="ddlEstadoPacientes" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoPacientes_SelectedIndexChanged">
                <asp:ListItem Text="Activos" Value="activos" />
                <asp:ListItem Text="Inactivos" Value="inactivos" />
                <asp:ListItem Text="Todos" Value="todos" />
            </asp:DropDownList>

            <div class="pacientes-search">
                <i class="bi bi-search"></i>
                <asp:TextBox ID="txtBuscar" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnTextChanged="txtBuscar_TextChanged"
                    placeholder="Buscar por apellido, nombre o DNI" />
            </div>
        </div>

        <div class="pacientes-table-wrap">
            <asp:GridView ID="dgvPacientes" runat="server"
                CssClass="table table-hover align-middle"
                DataKeyNames="Id"
                AutoGenerateColumns="false"
                OnRowCommand="dgvPacientes_RowCommand"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No se encontraron pacientes.">
                <Columns>
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="DNI" DataField="Dni" />
                    <asp:BoundField HeaderText="Fecha de nacimiento" DataField="FechaNacimiento" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Dirección" DataField="Direccion" />

                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='<%# (bool)Eval("Activo") ? "badge rounded-pill bg-success" : "badge rounded-pill bg-secondary" %>'>
                                <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnHistorial" runat="server" CommandName="VerHistorial" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary me-2">
                                Historial de turnos
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-danger">
                                Editar
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="pacientes-actions">
            <a href="FormularioPaciente.aspx" class="btn btn-primary"><i class="bi bi-plus-lg me-2"></i>Agregar paciente</a>
        </div>
    </div>
</asp:Content>