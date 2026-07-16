<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AtencionTurno.aspx.cs" Inherits="WebApplicationClinica.AtencionTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4 pb-5">
        <div class="mb-4 d-flex justify-content-between align-items-center bg-light p-3 rounded-3 shadow-sm">
            <div>
                <h2 class="fw-bold mb-1 text-dark">Consulta Médica</h2>
                <div class="align-items-center">
                    <label class="form-label d-inline-block fw-bold text-secondary mb-0">Paciente: </label>
                    <asp:Label ID="lblNombrePaciente" runat="server" CssClass="fw-bold text-dark me-3 fs-5" />
                </div>
            </div>
            <a href="MisTurnosMedicos.aspx" class="btn btn-outline-secondary shadow-sm">Volver a la Agenda</a>
        </div>

        <div class="row g-4">
            <!-- Ficha con info del turno -->
            <div class="col-lg-4 col-md-5">
                <div class="card shadow-sm border-0 bg-white rounded-3 h-100">
                    <div class="card-header bg-secondary text-white py-2">
                        <span class="fw-bold fs-5">Datos del turno</span>
                    </div>
                    <div class="card-body p-4">
                        <div class="row mb-3 border-bottom pb-3">
                            <div class="col-6 mb-3">
                                <label class="d-block fw-bold small text-muted">Fecha de Consulta</label>
                                <asp:Label ID="lblFecha" runat="server" CssClass="fw-semibold text-dark fs-5" />
                            </div>
                            <div class="col-6 mb-3">
                                <label class="d-block fw-bold small text-muted">Horario asignado</label>
                                <asp:Label ID="lblHora" runat="server" CssClass="fw-semibold text-dark fs-5" />
                            </div>
                            <div class="col-12">
                                <label class="d-block fw-bold small text-muted">Especialidad</label>
                                <asp:Label ID="lblEspecialidad" runat="server" CssClass="badge bg-secondary text-white fs-6 py-1.5" />
                            </div>
                        </div>
                        <div class="bg-light border-start border-4 border-primary p-3 rounded-3">
                            <label class="d-block fw-bold small text-secondary mb-1">Motivo / Observaciones previas:</label>
                            <asp:Label ID="lblObservaciones" runat="server" CssClass="text-dark d-block text-wrap" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Formulario de Registro de Atención -->
            <div class="col-lg-8 col-md-7">
                <div class="card shadow-sm border-0 bg-white rounded-3">
                    <div class="card-header bg-primary text-white py-2">
                        <span class="fw-bold fs-5"><i class="bi bi-file-earmark-medical me-2"></i>Registro de Atención Médica</span>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <!-- Signos Vitales -->
                            <div class="col-12">
                                <label for="txtSignosVitales" class="form-label fw-bold text-dark mb-1">Signos Vitales (Presión, Peso, Temp, etc.)</label>
                                <asp:TextBox ID="txtSignosVitales" runat="server" CssClass="form-control shadow-sm" Placeholder="Ej: PA: 120/80 mmHg - Peso: 70kg - Temp: 36.6°C" />
                            </div>

                            <!-- Diagnóstico -->
                            <div class="col-md-6">
                                <label for="txtDiagnostico" class="form-label fw-bold text-dark mb-1">Diagnóstico Principal</label>
                                <asp:TextBox ID="txtDiagnostico" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control shadow-sm" Placeholder="Describa el diagnóstico médico..." />
                            </div>

                            <!-- Indicaciones -->
                            <div class="col-md-6">
                                <label for="txtIndicaciones" class="form-label fw-bold text-dark mb-1">Indicaciones Médicas</label>
                                <asp:TextBox ID="txtIndicaciones" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control shadow-sm" Placeholder="Indicaciones y reposo para el paciente..." />
                            </div>

                            <!-- Receta Médica -->
                            <div class="col-md-6">
                                <label for="txtReceta" class="form-label fw-bold text-dark mb-1">Receta / Prescripción</label>
                                <asp:TextBox ID="txtReceta" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control shadow-sm" Placeholder="Medicamentos, dosis y frecuencia..." />
                            </div>

                            <!-- Estudios Solicitados -->
                            <div class="col-md-6">
                                <label for="txtEstudios" class="form-label fw-bold text-dark mb-1">Estudios Solicitados</label>
                                <asp:TextBox ID="txtEstudios" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control shadow-sm" Placeholder="Análisis, radiografías, ecografías a realizar..." />
                            </div>
                        </div>

                        <asp:Label ID="lblMensajeError" runat="server" ForeColor="Red" Font-Bold="true" Visible="false" CssClass="d-block mt-3" />

                        <div class="pt-4 mt-3 border-top d-flex justify-content-center gap-3">
                            <asp:Button ID="btnGuardarAsistio" runat="server" Text="Registrar Atención"
                                CssClass="btn btn-primary fw-semibold shadow-sm py-2 px-4" OnClick="btnGuardarAsistio_Click" />

                            <asp:Button ID="btnRegistrarInasistencia" runat="server" Text="Registrar Inasistencia"
                                CssClass="btn btn-outline-danger fw-semibold py-2 px-4" OnClick="btnRegistrarInasistencia_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Historial Clínico del Paciente -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card shadow-sm border-0 bg-white rounded-3">
                    <div class="card-header bg-info text-white py-2 d-flex justify-content-between align-items-center">
                        <span class="fw-bold fs-5"><i class="bi bi-journal-medical me-2"></i>Historial Clínico del Paciente</span>
                    </div>
                    <div class="card-body p-4">
                        <asp:Repeater ID="rptHistorialClinico" runat="server">
                            <HeaderTemplate>
                                <div class="accordion" id="accordionHistorial">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="accordion-item mb-2 border rounded">
                                    <h2 class="accordion-header" id='heading<%# Eval("Id") %>'>
                                        <button class="accordion-button collapsed bg-light" type="button" data-bs-toggle="collapse" data-bs-target='#collapse<%# Eval("Id") %>' aria-expanded="false" aria-controls='collapse<%# Eval("Id") %>'>
                                            <div class="d-flex w-100 justify-content-between me-3 text-secondary">
                                                <span><i class="bi bi-calendar-event me-1"></i><strong><%# Convert.ToDateTime(Eval("Fecha")).ToString("dd/MM/yyyy") %></strong></span>
                                                <span><strong>Esp:</strong> <%# Eval("Especialidad.Nombre") %></span>
                                                <span class="text-truncate" style="max-width: 300px;"><strong>Motivo:</strong> <%# Eval("Observaciones") %></span>
                                            </div>
                                        </button>
                                    </h2>
                                    <div id='collapse<%# Eval("Id") %>' class="accordion-collapse collapse" aria-labelledby='heading<%# Eval("Id") %>' data-bs-parent="#accordionHistorial">
                                        <div class="accordion-body bg-white">
                                            <div class="row g-3">
                                                <%# !string.IsNullOrEmpty(Eval("SignosVitales") as string) ? "<div class='col-12'><span class='badge bg-light text-dark border'><strong>Signos Vitales:</strong> " + Eval("SignosVitales") + "</span></div>" : "" %>
                                                
                                                <div class="col-md-6">
                                                    <h6 class="fw-bold text-primary mb-1">Diagnóstico:</h6>
                                                    <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("Diagnostico") as string) ? "<em>Sin registro</em>" : Eval("Diagnostico") %></p>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="fw-bold text-secondary mb-1">Indicaciones:</h6>
                                                    <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("Indicaciones") as string) ? "<em>Sin registro</em>" : Eval("Indicaciones") %></p>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="fw-bold text-success mb-1">Receta / Prescripción:</h6>
                                                    <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("Receta") as string) ? "<em>Sin registro</em>" : Eval("Receta") %></p>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="fw-bold text-warning mb-1">Estudios Solicitados:</h6>
                                                    <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("EstudiosSolicitados") as string) ? "<em>Sin registro</em>" : Eval("EstudiosSolicitados") %></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        
                        <asp:Label ID="lblSinHistorial" runat="server" CssClass="text-muted fw-semibold" Visible="false">
                            <i class="bi bi-info-circle me-1"></i> El paciente no posee atenciones médicas previas registradas en el sistema.
                        </asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
