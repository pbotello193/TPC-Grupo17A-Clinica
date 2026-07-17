<%@ Page Title="Inicio Administrador" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioAdministrador.aspx.cs" Inherits="WebApplicationClinica.InicioAdministrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .42), rgba(255, 255, 255, .42)), url('Images/fondoInicio.png');
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

        .admin-home {
            padding: 48px 0 72px;
        }

        .admin-header {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 34px;
        }

        .admin-header-icon,
        .admin-card-icon {
            border-radius: 50%;
            background: rgba(215, 244, 255, .88);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .8);
        }

        .admin-header-icon {
            width: 72px;
            height: 72px;
            font-size: 2.4rem;
        }

        .admin-card {
            min-height: 260px;
            border: 0;
            border-radius: 12px;
            background: rgba(255, 255, 255, .86);
            box-shadow: 0 14px 32px rgba(15, 23, 42, .12);
            backdrop-filter: blur(8px);
        }

        .admin-card-icon {
            width: 58px;
            height: 58px;
            font-size: 1.8rem;
        }

        .admin-card .card-text {
            line-height: 1.55;
        }

        .admin-card .btn {
            min-width: 118px;
            background: #2463eb;
            border-color: #2463eb;
            font-weight: 600;
            box-shadow: 0 8px 18px rgba(36, 99, 235, .24);
        }

        .admin-card .btn:hover {
            background: #1f54c9;
            border-color: #1f54c9;
        }
    </style>
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