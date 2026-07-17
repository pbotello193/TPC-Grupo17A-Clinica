<%@ Page Title="Agenda Médicos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AgendaMedicos.aspx.cs" Inherits="WebApplicationClinica.AgendaMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .50), rgba(255, 255, 255, .50)), url('Images/fondoInicio.png');
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

        .agenda-page {
            margin: 48px auto 72px;
        }

        .agenda-card {
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .agenda-header-card {
            margin-bottom: 28px;
        }

        .agenda-header {
            display: flex;
            align-items: center;
            gap: 24px;
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
            margin-bottom: 24px;
        }

        .form-label {
            color: #172033;
            font-weight: 600;
        }

        .form-select,
        .form-control {
            min-height: 46px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .agenda-btn {
            min-height: 46px;
            padding-left: 22px;
            padding-right: 22px;
            font-weight: 600;
            white-space: nowrap;
        }

        .agenda-table-wrap {
            overflow: visible;
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            background: rgba(255, 255, 255, .86);
        }

        .agenda-table-wrap .table {
            margin-bottom: 0;
        }

        .agenda-table-wrap th {
            padding: 16px;
            background: rgba(248, 250, 252, .92);
            color: #172033;
            font-weight: 700;
            border-bottom-color: rgba(15, 23, 42, .12);
        }

        .agenda-table-wrap td {
            padding: 18px 16px;
            vertical-align: middle;
            color: #172033;
        }

        .agenda-table-wrap .dropdown-menu {
            z-index: 2200;
        }

        .estado-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 104px;
            padding: 8px 14px;
            border-radius: 8px;
            font-weight: 700;
            font-size: .92rem;
            line-height: 1;
            border: 1px solid transparent;
        }

        .estado-asignado,
        .estado-programado {
            color: #b45309;
            background: rgba(254, 243, 199, .95);
            border-color: rgba(245, 158, 11, .18);
        }

        .estado-reprogramado {
            color: #c2410c;
            background: rgba(255, 237, 213, .95);
            border-color: rgba(249, 115, 22, .18);
        }

        .estado-cancelado {
            color: #dc2626;
            background: rgba(254, 226, 226, .95);
            border-color: rgba(239, 68, 68, .18);
        }

        .estado-no-asistio {
            color: #475569;
            background: rgba(241, 245, 249, .95);
            border-color: rgba(100, 116, 139, .18);
        }

        .estado-asistio,
        .estado-cerrado {
            color: #15803d;
            background: rgba(220, 252, 231, .95);
            border-color: rgba(34, 197, 94, .18);
        }

        .estado-default {
            color: #1d4ed8;
            background: rgba(219, 234, 254, .95);
            border-color: rgba(59, 130, 246, .18);
        }

        .btn-agenda-accion {
            min-height: 40px;
            font-weight: 600;
            box-shadow: 0 8px 18px rgba(15, 23, 42, .08);
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

            .agenda-header {
                align-items: flex-start;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="agenda-page">
        <div class="agenda-card agenda-header-card">
            <div class="agenda-header">
                <div class="agenda-header-icon">
                    <i class="bi bi-calendar-check"></i>
                </div>
                <div>
                    <h1 class="display-6 fw-bold mb-2">Agenda Médica</h1>
                    <p class="text-muted fs-5 mb-0">Listado de agendas médicas registradas en el sistema.</p>
                </div>
            </div>
        </div>

        <div class="agenda-card">
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
                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <span class='<%# GetEstadoCss(Eval("Estado")) %>'><%# Eval("Estado") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Motivo de consulta" DataField="Observaciones" />

                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:PlaceHolder runat="server" Visible='<%# Convert.ToString(Eval("Estado")) == "Asignado" %>'>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-success dropdown-toggle btn-agenda-accion" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            <i class="bi bi-calendar-event me-1"></i> Acción
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end">
                                            <li>
                                                <asp:LinkButton ID="btnReprogramar" runat="server" CssClass="dropdown-item"
                                                    CommandName="ReprogramarTurno" CommandArgument='<%# Container.DataItemIndex %>'>
                                                    Reprogramar
                                                </asp:LinkButton>
                                            </li>
                                            <li>
                                                <asp:LinkButton ID="btnDdlCancelar" runat="server" CssClass="dropdown-item text-danger"
                                                    CommandName="CancelarTurno" CommandArgument='<%# Container.DataItemIndex %>'>
                                                    Cancelar
                                                </asp:LinkButton>
                                            </li>
                                        </ul>
                                    </div>
                                </asp:PlaceHolder>

                                <asp:PlaceHolder runat="server" Visible='<%# Convert.ToString(Eval("Estado")) == "Reprogramado" %>'>
                                    <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn btn-sm btn-outline-danger btn-agenda-accion"
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
    </div>
</asp:Content>

