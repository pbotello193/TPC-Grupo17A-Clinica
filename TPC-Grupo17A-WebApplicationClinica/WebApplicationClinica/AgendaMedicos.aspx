<%@ Page Title="Agenda Médicos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AgendaMedicos.aspx.cs" Inherits="WebApplicationClinica.AgendaMedicos" %>

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

        .agenda-panel {
            margin: 48px auto 72px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .86);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .agenda-header {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 32px;
        }

        .agenda-header-icon {
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

        .agenda-filtros {
            display: grid;
            grid-template-columns: minmax(170px, 1.3fr) minmax(170px, 1.2fr) minmax(150px, .9fr) minmax(150px, .9fr) auto auto;
            gap: 16px;
            align-items: end;
            margin-bottom: 26px;
        }

        .form-label {
            color: #172033;
            font-weight: 500;
        }

        .form-select,
        .form-control {
            min-height: 44px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .agenda-btn {
            min-height: 44px;
            padding-left: 22px;
            padding-right: 22px;
            white-space: nowrap;
        }

        .agenda-table-wrap {
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            background: rgba(255, 255, 255, .82);
        }

        .agenda-table-wrap .table {
            margin-bottom: 0;
        }

        .agenda-table-wrap th {
            background: rgba(248, 250, 252, .88);
            color: #475569;
            font-weight: 700;
            border-bottom-color: rgba(15, 23, 42, .12);
        }

        .agenda-table-wrap td {
            vertical-align: middle;
        }

        .agenda-table-wrap .dropdown-menu {
            z-index: 2200;
        }

        @media (max-width: 992px) {
            .agenda-filtros {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 576px) {
            .agenda-filtros {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="agenda-panel">
        <div class="agenda-header">
            <div class="agenda-header-icon">
                <i class="bi bi-calendar3"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Agenda Médicos</h1>
                <p class="text-muted fs-6 mb-0">Visualice y gestione las consultas programadas.</p>
            </div>
        </div>

        <div class="agenda-filtros">
            <div>
                <label for="<%= ddlMedico.ClientID %>" class="form-label">Médico</label>
                <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select" />
            </div>
            <div>
                <label for="<%= ddlEspecialidad.ClientID %>" class="form-label">Especialidad</label>
                <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" />
            </div>
            <div>
                <label for="<%= txtFecha.ClientID %>" class="form-label">Fecha</label>
                <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date" />
            </div>
            <div>
                <label for="<%= ddlEstado.ClientID %>" class="form-label">Estado</label>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Todos" Value="" />
                    <asp:ListItem Text="Asignado" Value="Asignado" />
                    <asp:ListItem Text="Reprogramado" Value="Reprogramado" />
                    <asp:ListItem Text="Cancelado" Value="Cancelado" />
                    <asp:ListItem Text="No asistió" Value="No Asistió" />
                    <asp:ListItem Text="Asistió" Value="Asistió" />
                </asp:DropDownList>
            </div>
            <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn btn-primary agenda-btn" OnClick="btnFiltrar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-outline-secondary agenda-btn" OnClick="btnLimpiar_Click" />
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false" />

        <div class="agenda-table-wrap table-responsive">
            <asp:GridView ID="dgvAgendaMedicos" runat="server"
                CssClass="table table-hover align-middle"
                AutoGenerateColumns="false"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No hay turnos para mostrar con los filtros seleccionados."
                DataKeyNames="Id"
                OnRowCommand="dgvAgendaMedicos_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                    <asp:BoundField HeaderText="Hora" DataField="Hora" />
                    <asp:BoundField HeaderText="Paciente" DataField="Paciente" />
                    <asp:BoundField HeaderText="Médico" DataField="Medico" />
                    <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                    <asp:BoundField HeaderText="Estado" DataField="Estado" />
                    <asp:BoundField HeaderText="Motivo de consulta" DataField="Observaciones" />

                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:PlaceHolder runat="server" Visible='<%# Eval("Estado").ToString() == "Asignado" %>'>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Acción</button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <asp:LinkButton ID="btnReprogramar" runat="server" CssClass="dropdown-item"
                                                CommandName="ReprogramarTurno" CommandArgument='<%# Container.DataItemIndex %>'>
                                                Reprogramar
                                            </asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="btnDdlCancelar" runat="server" CssClass="dropdown-item"
                                                CommandName="CancelarTurno" CommandArgument='<%# Container.DataItemIndex %>'>
                                                Cancelar
                                            </asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>
                            </asp:PlaceHolder>

                            <asp:PlaceHolder runat="server" Visible='<%# Eval("Estado").ToString() == "Reprogramado" %>'>
                                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn btn-sm btn-outline-danger"
                                    CommandName="CancelarTurno" CommandArgument='<%# Container.DataItemIndex %>'>
                                    Cancelar
                                </asp:LinkButton>
                            </asp:PlaceHolder>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
