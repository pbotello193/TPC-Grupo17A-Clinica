<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AtencionTurno.aspx.cs" Inherits="WebApplicationClinica.AtencionTurno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="atencion-page">
        <h1 class="consulta-page-title">Consulta Médica</h1>

        <div class="atencion-card atencion-header-card">
            <div class="atencion-header">
                <div class="atencion-title-wrap">
                    <div class="atencion-header-icon">
                        <i class="bi bi-clipboard2-pulse"></i>
                    </div>
                    <div>
                        <div class="paciente-label">Paciente</div>
                        <div>
                            <asp:Label ID="lblNombrePaciente" runat="server" CssClass="paciente-name" />
                            <span class="paciente-edad ms-2"><asp:Label ID="lblEdad" runat="server" /></span>
                        </div>
                        <div class="paciente-meta">
                            <span><i class="bi bi-card-text"></i><strong>DNI:</strong> <asp:Label ID="lblDniPaciente" runat="server" /></span>
                            <span><i class="bi bi-telephone"></i><strong>Tel:</strong> <asp:Label ID="lblTelefonoPaciente" runat="server" /></span>
                            <span><i class="bi bi-envelope"></i><strong>Email:</strong> <asp:Label ID="lblEmailPaciente" runat="server" /></span>
                        </div>
                    </div>
                </div>
                <a href="MisTurnosMedicos.aspx" class="btn btn-primary shadow-sm px-4 py-2">
                    <i class="bi bi-arrow-left me-2"></i>Volver a la Agenda
                </a>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-4 col-md-5">
                <div class="atencion-card h-100">
                    <div class="atencion-panel-header">
                        <span class="panel-title-icon"><i class="bi bi-calendar3"></i></span>
                        <h2 class="h5 fw-bold mb-0">Datos del turno</h2>
                    </div>
                    <div class="p-4">
                        <div class="turno-data-grid mb-4 pb-4 border-bottom">
                            <div>
                                <div class="turno-data-label"><i class="bi bi-calendar-event"></i> Fecha de consulta</div>
                                <asp:Label ID="lblFecha" runat="server" CssClass="turno-data-value" />
                            </div>
                            <div>
                                <div class="turno-data-label"><i class="bi bi-clock"></i> Horario asignado</div>
                                <asp:Label ID="lblHora" runat="server" CssClass="turno-data-value" />
                            </div>
                            <div class="col-12">
                                <div class="turno-data-label"><i class="bi bi-stethoscope"></i> Especialidad</div>
                                <asp:Label ID="lblEspecialidad" runat="server" CssClass="especialidad-badge" />
                            </div>
                        </div>

                        <div>
                            <div class="turno-data-label mb-3"><i class="bi bi-chat-left"></i> Motivo / Observaciones previas</div>
                            <div class="observaciones-box">
                                <asp:Label ID="lblObservaciones" runat="server" CssClass="d-block text-wrap" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8 col-md-7">
                <div class="atencion-card">
                    <div class="atencion-panel-header primary">
                        <span class="panel-title-icon"><i class="bi bi-file-earmark-medical"></i></span>
                        <h2 class="h5 fw-bold mb-0">Registro de Atención Médica</h2>
                    </div>
                    <div class="p-4">
                        <div class="row g-3">
                            <div class="col-12">
                                <label for="txtSignosVitales" class="form-label">Datos clínicos iniciales</label>
                                <asp:TextBox ID="txtSignosVitales" runat="server" CssClass="form-control" Placeholder="Ej: PA 120/80 mmHg, peso 70 kg, temperatura 36.6°C, observaciones iniciales..." />
                            </div>

                            <div class="col-md-6">
                                <label for="txtDiagnostico" class="form-label">Diagnóstico principal</label>
                                <asp:TextBox ID="txtDiagnostico" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" Placeholder="Describa el diagnóstico médico..." />
                            </div>

                            <div class="col-md-6">
                                <label for="txtIndicaciones" class="form-label">Indicaciones médicas</label>
                                <asp:TextBox ID="txtIndicaciones" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" Placeholder="Indicaciones y reposo para el paciente..." />
                            </div>

                            <div class="col-md-6">
                                <label for="txtReceta" class="form-label">Receta / Prescripción</label>
                                <asp:TextBox ID="txtReceta" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" Placeholder="Medicamentos, dosis y frecuencia..." />
                            </div>

                            <div class="col-md-6">
                                <label for="txtEstudios" class="form-label">Estudios solicitados</label>
                                <asp:TextBox ID="txtEstudios" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" Placeholder="Análisis, radiografías, ecografías a realizar..." />
                            </div>
                        </div>

                        <asp:Label ID="lblMensajeError" runat="server" ForeColor="Red" Font-Bold="true" Visible="false" CssClass="alert alert-danger d-block mt-3" />

                        <div class="pt-4 mt-3 border-top d-flex justify-content-center gap-3 flex-wrap">
                            <asp:Button ID="btnGuardarAsistio" runat="server" Text="Registrar Atención"
                                CssClass="btn btn-primary fw-semibold py-2 px-4" OnClick="btnGuardarAsistio_Click" />

                            <asp:Button ID="btnRegistrarInasistencia" runat="server" Text="Registrar Inasistencia"
                                CssClass="btn btn-outline-danger fw-semibold py-2 px-4" OnClick="btnRegistrarInasistencia_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-12">
                <div class="atencion-card historial-card">
                    <div class="atencion-panel-header info">
                        <span class="panel-title-icon"><i class="bi bi-journal-medical"></i></span>
                        <h2 class="h5 fw-bold mb-0">Historial Clínico del Paciente</h2>
                    </div>
                    <div class="p-4">
                        <asp:Repeater ID="rptHistorialClinico" runat="server">
                            <HeaderTemplate>
                                <div class="accordion" id="accordionHistorial">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="accordion-item mb-2 border rounded">
                                    <h2 class="accordion-header" id='heading<%# Eval("Id") %>'>
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target='#collapse<%# Eval("Id") %>' aria-expanded="false" aria-controls='collapse<%# Eval("Id") %>'>
                                            <div class="d-flex w-100 justify-content-between me-3 text-secondary flex-wrap gap-2">
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

                        <asp:Label ID="lblSinHistorial" runat="server" CssClass="historial-empty" Visible="false">
                            <i class="bi bi-info-circle"></i> El paciente no posee atenciones médicas previas registradas en el sistema.
                        </asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

