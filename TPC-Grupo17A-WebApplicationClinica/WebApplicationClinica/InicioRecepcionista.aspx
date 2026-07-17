<%@ Page Title="Inicio Recepcionista" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioRecepcionista.aspx.cs" Inherits="WebApplicationClinica.InicioRecepcionista" %>

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

        .recepcion-home {
            padding: 56px 0 84px;
        }

        .recepcion-header {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 64px;
        }

        .recepcion-header-icon,
        .recepcion-card-icon {
            border-radius: 50%;
            background: rgba(215, 244, 255, .9);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
        }

        .recepcion-header-icon {
            width: 72px;
            height: 72px;
            font-size: 2.4rem;
            flex: 0 0 auto;
        }

        .recepcion-card {
            min-height: 270px;
            border: 0;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .16);
            backdrop-filter: blur(8px);
        }

        .recepcion-card-icon {
            width: 72px;
            height: 72px;
            font-size: 2.1rem;
        }

        .recepcion-card .card-text {
            line-height: 1.55;
        }

        .recepcion-card .btn {
            min-width: 132px;
            background: #2463eb;
            border-color: #2463eb;
            font-weight: 600;
            box-shadow: 0 8px 18px rgba(36, 99, 235, .24);
        }

        .recepcion-card .btn:hover {
            background: #1f54c9;
            border-color: #1f54c9;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="recepcion-home">
        <div class="recepcion-header">
            <div class="recepcion-header-icon">
                <i class="bi bi-headset"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-3">Recepción</h1>
                <p class="text-muted fs-5 mb-0">Gestión de turnos, pacientes y médicos.</p>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-xl-3">
                <div class="card recepcion-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="recepcion-card-icon mb-4"><i class="bi bi-calendar-check"></i></div>
                        <h5 class="card-title fw-bold mb-3">Turnos</h5>
                        <p class="card-text text-muted">Alta y consulta de turnos.</p>
                        <a href="WebForm-Turnos.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card recepcion-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="recepcion-card-icon mb-4"><i class="bi bi-person"></i></div>
                        <h5 class="card-title fw-bold mb-3">Pacientes</h5>
                        <p class="card-text text-muted">Administración de pacientes.</p>
                        <a href="WebForm-Paciente.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card recepcion-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="recepcion-card-icon mb-4"><i class="bi bi-heart-pulse"></i></div>
                        <h5 class="card-title fw-bold mb-3">Médicos</h5>
                        <p class="card-text text-muted">Administración de médicos.</p>
                        <a href="WebForm-Medico.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xl-3">
                <div class="card recepcion-card h-100">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="recepcion-card-icon mb-4"><i class="bi bi-calendar-week"></i></div>
                        <h5 class="card-title fw-bold mb-3">Agenda Médicos</h5>
                        <p class="card-text text-muted">Vista de agenda por profesional.</p>
                        <a href="AgendaMedicos.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>