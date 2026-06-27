<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplicationClinica.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pt-3 pb-5">
        <div class="text-center mb-5">
            <h1 class="display-5 fw-bold">Sistema de Gestión Clínica</h1>
            <%--<p class="lead text-muted mx-auto" style="max-width: 720px;">
                Administrá pacientes, médicos, especialidades, horarios de atención y turnos médicos desde un solo lugar.
            </p>--%>
        </div>
        <div class="row g-4">
        <div class="col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm border-0 bg-light">
                <div class="card-body p-4">
                    <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 64px; height: 64px;">
                        <i class="bi bi-calendar-check fs-2"></i>
                    </div>
                    <%--turnos --%>
                    <h5 class="card-title fw-bold">Turnos</h5>
                    <p class="card-text text-muted">Gestión y asignación de turnos a pacientes.</p>
                    <a href="WebForm-Turnos.aspx" class="btn btn-dark">Ingresar</a>
                </div>
            </div>
        </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 64px; height: 64px;">
                            <i class="bi bi-person fs-2"></i>
                        </div>
                        <%--pacientes --%>
                        <h5 class="card-title fw-bold">Pacientes</h5>
                        <p class="card-text text-muted">Gestión y consulta de pacientes.</p>
                        <a href="WebForm-Paciente.aspx" class="btn btn-dark">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 64px; height: 64px;">
                            <i class="bi bi-heart-pulse fs-2"></i>
                        </div>
                        <%--medicos --%>
                        <h5 class="card-title fw-bold">Médicos</h5>
                        <p class="card-text text-muted">Gestión y consulta de profesionales.</p>
                        <a href="WebForm-Medico.aspx" class="btn btn-dark">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 64px; height: 64px;">
                            <i class="bi bi-clipboard2-pulse fs-2"></i>
                        </div>
                        <%--especialidades --%>
                        <h5 class="card-title fw-bold">Especialidades</h5>
                        <p class="card-text text-muted">Gestión y consulta de especialidades médicas.</p>
                        <a href="ListaEspecialidades.aspx" class="btn btn-dark">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 64px; height: 64px;">
                            <i class="bi bi-calendar-week fs-2"></i>
                        </div>
                        <%--horarios medicos --%>
                        <h5 class="card-title fw-bold">Horarios Médicos</h5>
                        <p class="card-text text-muted">Gestión y consulta de dias y horarios médicos.</p>
                        <a href="FormularioTurnoDeTrabajo.aspx" class="btn btn-dark">Ingresar</a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

