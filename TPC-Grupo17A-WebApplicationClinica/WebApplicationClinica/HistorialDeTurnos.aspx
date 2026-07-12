<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HistorialDeTurnos.aspx.cs" Inherits="WebApplicationClinica.HistorialDeTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <div class="mb-4 d-flex justify-content-between align-items-center bg-light p-3 rounded-3 shadow-sm">
            <div>
                <h2 class="fw-bold mb-2 text-dark">Historial de turnos</h2>
                <div class="align-items-center">
                    <label class="form-label d-inline-block fw-bold text-secondary mb-0">Paciente: </label>
                    <asp:Label ID="lblNombrePaciente" runat="server" CssClass="fw-bold text-dark me-2" />
                    <label class="form-label d-inline-block fw-bold text-secondary mb-0">DNI: </label>
                    <asp:Label ID="lblDniPaciente" runat="server" CssClass="fw-bold text-dark" />
                </div>
            </div>
            <a href="WebForm-Paciente.aspx" class="btn btn-outline-secondary shadow-sm">Volver</a>
        </div>

        <div class="row g-4">
            <div class="col-12" id="divDgvTurnos" runat="server">
                <div class="card shadow-sm border-0 p-3 bg-white rounded-3">
                    <asp:GridView ID="dgvTurnos" runat="server"
                        CssClass="table table-striped table-hover align-middle m-0"
                        DataKeyNames="Id"
                        AutoGenerateColumns="false"
                        OnRowCommand="dgvTurnos_RowCommand"
                        ShowHeaderWhenEmpty="true"
                        EmptyDataText="Sin turnos registrados.">
                        <Columns>
                            <asp:TemplateField HeaderText="Fecha">
                                <ItemTemplate>
                                    <%# Eval("Fecha", "{0:dd/MM/yyyy}") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Horario">
                                <ItemTemplate>
                                    <%# ((TimeSpan)Eval("HoraInicio")).ToString(@"hh\:mm") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Médico">
                                <ItemTemplate>
                                    <%# Eval("Medico.Apellido") %>, <%# Eval("Medico.Nombre") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Especialidad" DataField="Especialidad.Nombre" />
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='<%# badgeEstado(Eval("Estado").ToString()) %>'>
                                        <%# Eval("Estado") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVerDetalle" runat="server"
                                        CommandName="VerDetalle"
                                        CommandArgument='<%# Eval("Id") %>'
                                        CssClass="btn btn-sm btn-primary shadow-sm">
                                        Ver Detalle
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="col-5">
                <%-- el panel arranca en visible=false, en el back se pone true y le cambia la class a la dgv --%>
                <asp:Panel ID="pnlDetalleTurno" runat="server" CssClass="card shadow-sm border-0 bg-white rounded-3 overflow-hidden h-100" Visible="false">
                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center py-3">
                        <span class="fw-bold fs-5">Detalle del Turno</span>
                        <asp:Button ID="btnCerrarDetalle" runat="server" Text="Salir" CssClass="btn btn-secondary btn-sm" OnClick="btnCerrarDetalle_Click" />
                    </div>

                    <div class="card-body p-4">
                        <div class="row mb-3 border-bottom pb-3">
                            <div class="col-6 mb-2">
                                <label class="d-block fw-bold small text-muted">Fecha: </label>
                                <asp:Label ID="lblDetalleFecha" runat="server" CssClass="fw-bold text-dark" />
                            </div>
                            <div class="col-6 mb-2">
                                <label class="d-block fw-bold small text-muted">Horario: </label>
                                <asp:Label ID="lblDetalleHorario" runat="server" CssClass="fw-bold text-dark" />
                            </div>
                            <div class="col-6">
                                <label class="d-block fw-bold small text-muted">Estado: </label>
                                <asp:Label ID="lblDetalleEstado" runat="server" CssClass="badge bg-info text-dark" />
                            </div>
                            <div class="col-6">
                                <label class="d-block fw-bold small text-muted">Especialidad: </label>
                                <asp:Label ID="lblDetalleEspecialidad" runat="server" CssClass="fw-bold text-dark" />
                            </div>
                        </div>

                        <div class="row mb-3 border-bottom pb-3">
                            <div class="col-12">
                                <label class="d-block fw-bold small text-muted">Médico: </label>
                                <asp:Label ID="lblDetalleMedico" runat="server" CssClass="fw-bold text-dark" />
                            </div>
                        </div>

                        <div class="row mb-3 gap-3">
                            <div class="col-12 bg-light p-3 rounded-3">
                                <label class="d-block fw-bold small text-muted">Observaciones: </label>
                                <asp:Label ID="lblDetalleObservaciones" runat="server" CssClass="text-dark d-block text-wrap" />
                            </div>
                            <div class="col-12 bg-light p-3 rounded-3">
                                <label class="d-block fw-bold small text-muted">Diagnóstico: </label>
                                <asp:Label ID="lblDetalleDiagnostico" runat="server" CssClass="text-dark d-block text-wrap" />
                            </div>
                        </div>

                        <div class="row pt-2 mt-2 border-top">
                            <div class="col-12 text-muted mb-1">
                                <label class="d-block fw-bold small text-muted">Asignado por: </label>
                                <asp:Label ID="lblDetalleAsignado" runat="server" CssClass="fw-semibold text-dark" />
                            </div>
                            <div class="col-12 text-muted">
                                <label class="d-block fw-bold small text-muted">Fecha: </label>
                                <asp:Label ID="lblDetalleFechaAsignacion" runat="server" CssClass="fw-semibold text-dark" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>

        </div>
    </div>

</asp:Content>

