<%@ Page Title="Inicio Administrador" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioAdministrador.aspx.cs" Inherits="WebApplicationClinica.InicioAdministrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pt-3 pb-5">
        <div class="mb-4">
            <h1 class="h3 fw-bold">Vista Administrador</h1>
            <p class="text-muted mb-0">Accesos a la gestión general de la clínica.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-calendar-check fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Turnos</h5>
                        <p class="card-text text-muted">Gestionar y consultar turnos de pacientes.</p>
                        <a href="WebForm-Turnos.aspx" class="btn btn-dark mt-auto align-self-start">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-person fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Pacientes</h5>
                        <p class="card-text text-muted">Administrar datos de pacientes.</p>
                        <a href="WebForm-Paciente.aspx" class="btn btn-dark mt-auto align-self-start">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-heart-pulse fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Médicos</h5>
                        <p class="card-text text-muted">Administrar profesionales médicos.</p>
                        <a href="WebForm-Medico.aspx" class="btn btn-dark mt-auto align-self-start">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-clipboard2-pulse fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Especialidades</h5>
                        <p class="card-text text-muted">Administrar especialidades médicas.</p>
                        <a href="ListaEspecialidades.aspx" class="btn btn-dark mt-auto align-self-start">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-calendar-week fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Horarios Médicos</h5>
                        <p class="card-text text-muted">Gestionar días y horarios de atención.</p>
                        <a href="FormularioTurnoDeTrabajo.aspx" class="btn btn-dark mt-auto align-self-start">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-calendar3 fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Agenda médica</h5>
                        <p class="card-text text-muted">Vista general de agenda por profesional.</p>
                        <a href="#" class="btn btn-dark mt-auto align-self-start" aria-disabled="true">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-person-gear fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Personal Administrativo</h5>
                        <p class="card-text text-muted">Administrar usuarios administradores y recepcionistas.</p>
                        <a href="WebForm-Usuarios.aspx" class="btn btn-dark mt-auto align-self-start" aria-disabled="true">Ingresar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
