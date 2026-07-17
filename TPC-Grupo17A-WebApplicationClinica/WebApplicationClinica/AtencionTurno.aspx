<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AtencionTurno.aspx.cs" Inherits="WebApplicationClinica.AtencionTurno" %>

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

        .atencion-page {
            margin: 36px auto 72px;
        }

        .consulta-page-title {
            color: #172033;
            font-size: 1.6rem;
            font-weight: 800;
            margin: 0 0 14px 2px;
        }

        .atencion-card {
            border: 0;
            border-radius: 18px;
            background: rgba(255, 255, 255, .90);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
            overflow: hidden;
        }

        .atencion-header-card {
            padding: 28px 32px;
            margin-bottom: 28px;
        }

        .atencion-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
        }

        .atencion-title-wrap {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .atencion-header-icon,
        .panel-title-icon {
            border-radius: 14px;
            background: rgba(239, 246, 255, .95);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
            flex: 0 0 auto;
        }

        .atencion-header-icon {
            width: 72px;
            height: 72px;
            font-size: 2.3rem;
        }

        .panel-title-icon {
            width: 34px;
            height: 34px;
            font-size: 1.1rem;
        }

        .paciente-label {
            color: #64748b;
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 2px;
        }

        .paciente-name {
            color: #172033;
            font-size: 1.95rem;
            font-weight: 800;
            line-height: 1.15;
        }

        .paciente-edad {
            display: inline-flex;
            align-items: center;
            padding: 5px 10px;
            border-radius: 7px;
            background: #0d6efd;
            color: #fff;
            font-weight: 700;
            font-size: .9rem;
        }

        .paciente-meta {
            display: flex;
            align-items: center;
            gap: 22px;
            flex-wrap: wrap;
            margin-top: 14px;
            color: #475569;
            font-size: .92rem;
        }

        .paciente-meta span {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .atencion-panel-header {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 18px 22px;
            color: #172033;
            background: rgba(248, 250, 252, .92);
            border-bottom: 1px solid rgba(15, 23, 42, .10);
        }

        .atencion-panel-header.primary {
            color: #fff;
            background: linear-gradient(135deg, #0d6efd, #0b5ed7);
        }

        .atencion-panel-header.info {
            color: #fff;
            background: linear-gradient(135deg, #0dcaf0, #0aa2c0);
        }

        .atencion-panel-header.primary .panel-title-icon,
        .atencion-panel-header.info .panel-title-icon {
            background: rgba(255, 255, 255, .18);
            color: #fff;
        }

        .turno-data-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 26px 28px;
        }

        .turno-data-label {
            color: #475569;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
            font-size: .9rem;
            margin-bottom: 8px;
        }

        .turno-data-value {
            color: #172033;
            font-size: 1.15rem;
            font-weight: 700;
        }

        .especialidad-badge {
            display: inline-flex;
            align-items: center;
            padding: 8px 14px;
            border-radius: 8px;
            color: #1d4ed8;
            background: rgba(219, 234, 254, .95);
            font-weight: 700;
        }

        .observaciones-box {
            min-height: 110px;
            padding: 16px;
            border-radius: 12px;
            background: rgba(248, 250, 252, .92);
            border: 1px solid rgba(15, 23, 42, .08);
            color: #334155;
        }

        .form-label {
            color: #172033;
            font-weight: 800;
            font-size: .95rem;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 8px;
            border-color: rgba(148, 163, 184, .45);
            box-shadow: 0 10px 22px rgba(15, 23, 42, .05);
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 .2rem rgba(13, 110, 253, .13);
        }

        .btn-primary {
            background: linear-gradient(135deg, #0d6efd, #0b5ed7);
            border-color: #0d6efd;
            box-shadow: 0 12px 24px rgba(13, 110, 253, .22);
        }

        .btn-outline-danger {
            background: rgba(255, 255, 255, .72);
        }

        .historial-card .accordion-button {
            background: rgba(248, 250, 252, .92);
            box-shadow: none;
        }

        .historial-card .accordion-button:not(.collapsed) {
            color: #0d6efd;
            background: rgba(239, 246, 255, .95);
        }

        .historial-empty {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-height: 84px;
            color: #64748b;
            font-weight: 600;
        }

        @media (max-width: 992px) {
            .atencion-header {
                align-items: flex-start;
                flex-direction: column;
            }
        }

        @media (max-width: 576px) {
            .turno-data-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
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

