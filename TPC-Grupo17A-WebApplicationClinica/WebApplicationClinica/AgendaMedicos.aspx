<%@ Page Title="Agenda Médicos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AgendaMedicos.aspx.cs" Inherits="WebApplicationClinica.AgendaMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4 pb-5">
        <h2 class="mb-0 fw-normal">Agenda Médicos</h2>

        <div class="card shadow-sm border-0 bg-light mt-3">
            <div class="card-body p-4">
                <div class="row g-3 align-items-end mb-4">
                    <div class="col-12 col-md-3">
                        <label for="<%= ddlMedico.ClientID %>" class="form-label">Médico</label>
                        <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select" />
                    </div>
                    <div class="col-12 col-md-3">
                        <label for="<%= ddlEspecialidad.ClientID %>" class="form-label">Especialidad</label>
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" />
                    </div>
                    <div class="col-12 col-md-2">
                        <label for="<%= txtFecha.ClientID %>" class="form-label">Fecha</label>
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="col-12 col-md-2">
                        <label for="<%= ddlEstado.ClientID %>" class="form-label">Estado</label>
                        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Todos" Value="" />
                            <asp:ListItem Text="Asignado" Value="Asignado" />
                            <asp:ListItem Text="Nuevo" Value="Nuevo" />
                            <asp:ListItem Text="Reprogramado" Value="Reprogramado" />
                            <asp:ListItem Text="Cancelado" Value="Cancelado" />
                            <asp:ListItem Text="No asistió" Value="No Asistió" />
                            <asp:ListItem Text="Asistió" Value="Asistió" />
                            <asp:ListItem Text="Cerrado" Value="Cerrado" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-12 col-md-2 d-flex gap-2">
                        <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn btn-primary w-100" OnClick="btnFiltrar_Click" />
                        <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-outline-secondary w-100" OnClick="btnLimpiar_Click" />
                    </div>
                </div>

                <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger d-block mb-3" Visible="false" />

                <asp:GridView ID="dgvAgendaMedicos" runat="server"
                    CssClass="table table-hover align-middle mb-0"
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
                                        <button class="btn btn-sm btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Acción
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <asp:LinkButton ID="btnReprogramar" runat="server" CssClass="dropdown-item" 
                                                    CommandName="ReprogramarTurno" CommandArgument='<%# Container.DataItemIndex %>'>
                                                    Reprogramar
                                                </asp:LinkButton>
                                            </li>
                                            <li>
                                                <asp:LinkButton ID="btnCancelar" runat="server" CssClass="dropdown-item" 
                                                    CommandName="CancelarTurno" CommandArgument='<%# Container.DataItemIndex %>'>
                                                    Cancelar
                                                </asp:LinkButton>
                                            </li>
                                        </ul>
                                    </div>
                                </asp:PlaceHolder>
                            </ItemTemplate>
                        </asp:TemplateField>


                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
