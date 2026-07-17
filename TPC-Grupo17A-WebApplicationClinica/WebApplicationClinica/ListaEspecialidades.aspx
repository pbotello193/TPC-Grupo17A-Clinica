<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ListaEspecialidades.aspx.cs" Inherits="WebApplicationClinica.ListaEspecialidades" %>

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

        .especialidades-panel {
            margin: 48px auto 72px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .86);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .especialidades-header {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 32px;
        }

        .especialidades-header-icon {
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

        .especialidades-filtros {
            display: flex;
            gap: 16px;
            align-items: center;
            margin-bottom: 28px;
        }

        .especialidades-filtros .form-select {
            max-width: 140px;
            min-height: 44px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .especialidades-search {
            position: relative;
            flex: 1;
        }

        .especialidades-search i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 1.1rem;
            z-index: 2;
        }

        .especialidades-search .form-control {
            min-height: 44px;
            padding-left: 48px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .especialidades-table-wrap {
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            overflow: hidden;
            background: rgba(255, 255, 255, .82);
        }

        .especialidades-table-wrap .table {
            margin-bottom: 0;
        }

        .especialidades-table-wrap th {
            background: rgba(248, 250, 252, .88);
            color: #475569;
            font-weight: 700;
            border-bottom-color: rgba(15, 23, 42, .12);
        }

        .especialidades-table-wrap td {
            vertical-align: middle;
        }

        .especialidades-table-wrap .badge.bg-success {
            background-color: #d8f3df !important;
            color: #157347;
            border: 1px solid #a9dfba;
        }

        .especialidades-table-wrap .badge.bg-secondary {
            background-color: #e9ecef !important;
            color: #495057;
            border: 1px solid #ced4da;
        }

        .especialidades-actions {
            margin-top: 24px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="especialidades-panel">
        <div class="especialidades-header">
            <div class="especialidades-header-icon">
                <i class="bi bi-bookmark-plus"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Especialidades</h1>
                <p class="text-muted fs-6 mb-0">Gestión de especialidades médicas.</p>
            </div>
        </div>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="especialidades-filtros">
                    <asp:DropDownList ID="ddlEstadoEspecialidades" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoEspecialidades_SelectedIndexChanged">
                        <asp:ListItem Text="Activos" Value="activos" />
                        <asp:ListItem Text="Inactivos" Value="inactivos" />
                        <asp:ListItem Text="Todos" Value="todos" />
                    </asp:DropDownList>

                    <div class="especialidades-search">
                        <i class="bi bi-search"></i>
                        <asp:TextBox ID="txtBuscar" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscar_TextChanged"
                            placeholder="Buscar por nombre o descripción de especialidad..." />
                    </div>
                </div>

                <div class="especialidades-table-wrap">
                    <asp:GridView ID="dgvEspecialidades" runat="server" OnSelectedIndexChanged="dgvEspecialidades_SelectedIndexChanged"
                        CssClass="table table-hover align-middle" DataKeyNames="Id" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField HeaderText="Especialidad" DataField="Nombre" />
                            <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='<%# (bool)Eval("Activo") ? "badge rounded-pill bg-success" : "badge rounded-pill bg-secondary" %>'>
                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-pencil me-1"></i>Editar
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="especialidades-actions">
            <a href="FormularioEspecialidad.aspx" class="btn btn-primary"><i class="bi bi-plus-lg me-2"></i>Agregar</a>
        </div>
    </div>
</asp:Content>
