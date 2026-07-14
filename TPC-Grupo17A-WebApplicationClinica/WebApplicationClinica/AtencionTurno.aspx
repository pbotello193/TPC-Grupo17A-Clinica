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
                    <asp:Label ID="lblNombrePaciente" runat="server" CssClass="fw-bold text-primary me-3 fs-5" />
                </div>
            </div>
            <a href="MisTurnosMedicos.aspx" class="btn btn-outline-secondary shadow-sm">Volver a la Agenda</a>
        </div>

        <div class="row g-4">

            <!-- ficha con info del turno -->
            <div class="col-md-5">
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
                        <div class="bg-light border-4 border-primary mb-2 p-2 rounded-3">
                            <label class="d-block fw-bold small text-secondary mb-1">Observaciones:</label>
                            <asp:Label ID="lblObservaciones" runat="server" CssClass="text-dark d-block text-wrap" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- ficha para gestionar la atencion -->
            <div class="col-md-7">
                <div class="card shadow-sm border-0 bg-white rounded-3 h-100">
                    <div class="card-header bg-primary text-white py-2">
                        <span class="fw-bold fs-5">Registro de atencion</span>
                    </div>
                    <div class="card-body p-4 d-flex flex-column justify-content-between">
                        <div class="mb-4">
                            <label for="txtDiagnostico" class="form-label fw-bold text-dark mb-2">Diagnóstico, Tratamiento e Indicaciones</label>
                            <asp:TextBox ID="txtDiagnostico" runat="server" TextMode="MultiLine" Rows="7" CssClass="form-control shadow-sm" />

                        <div class="pt-3 border-top d-flex justify-content-center gap-3">
                            <asp:Button ID="btnGuardarAsistio" runat="server" Text="Registrar Atención"
                                CssClass="btn btn-primary fw-bold shadow-sm py-2 px-4" ValidationGroup="GrupoAsistencia"
                                OnClick="btnGuardarAsistio_Click" />

                            <asp:Button ID="btnRegistrarInasistencia" runat="server" Text="Registrar Inasistencia"
                                CssClass="btn btn-outline-danger fw-semibold py-2 px-4" OnClick="btnRegistrarInasistencia_Click" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
