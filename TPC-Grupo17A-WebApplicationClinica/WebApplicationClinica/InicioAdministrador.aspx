<%@ Page Title="Inicio Administrador" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioAdministrador.aspx.cs" Inherits="WebApplicationClinica.InicioAdministrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-home">
        <div class="admin-header">
            <div class="admin-header-icon">
                <i class="bi bi-hospital"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Vista Administrador</h1>
                <p class="text-muted fs-5 mb-0">Accesos a la gestión general de la clínica.</p>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-xl-3">
                <div class="card admin-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="admin-card-icon mb-4"><i class="bi bi-calendar-check"></i></div>
                        <h5 class="card-title fw-bold mb-3">Turnos</h5>
                        <p class="card-text text-muted">Gestionar y consultar turnos de pacientes.</p>
                        <a href="WebForm-Turnos.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card admin-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="admin-card-icon mb-4"><i class="bi bi-person"></i></div>
                        <h5 class="card-title fw-bold mb-3">Pacientes</h5>
                        <p class="card-text text-muted">Administrar datos de pacientes.</p>
                        <a href="WebForm-Paciente.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card admin-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="admin-card-icon mb-4"><i class="bi bi-heart-pulse"></i></div>
                        <h5 class="card-title fw-bold mb-3">Médicos</h5>
                        <p class="card-text text-muted">Administrar profesionales médicos.</p>
                        <a href="WebForm-Medico.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card admin-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="admin-card-icon mb-4"><i class="bi bi-clipboard2-pulse"></i></div>
                        <h5 class="card-title fw-bold mb-3">Especialidades</h5>
                        <p class="card-text text-muted">Administrar especialidades médicas.</p>
                        <a href="ListaEspecialidades.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card admin-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="admin-card-icon mb-4"><i class="bi bi-calendar-week"></i></div>
                        <h5 class="card-title fw-bold mb-3">Horarios Médicos</h5>
                        <p class="card-text text-muted">Gestionar días y horarios de atención.</p>
                        <a href="FormularioTurnoDeTrabajo.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card admin-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="admin-card-icon mb-4"><i class="bi bi-calendar3"></i></div>
                        <h5 class="card-title fw-bold mb-3">Agenda médica</h5>
                        <p class="card-text text-muted">Vista general de agenda por profesional.</p>
                        <a href="AgendaMedicos.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card admin-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="admin-card-icon mb-4"><i class="bi bi-person-gear"></i></div>
                        <h5 class="card-title fw-bold mb-3">Personal Administrativo</h5>
                        <p class="card-text text-muted">Administrar usuarios administradores y recepcionistas.</p>
                        <a href="WebForm-Usuarios.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>