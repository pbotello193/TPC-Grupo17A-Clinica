<%@ Page Title="Agenda Médicos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AgendaMedicos.aspx.cs" Inherits="WebApplicationClinica.AgendaMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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

