<%@ Page Title="Inicio Médico" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioMedico.aspx.cs" Inherits="WebApplicationClinica.InicioMedico" %>

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

        .doctor-home {
            padding: 56px 0 84px;
        }

        .doctor-title {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 64px;
        }

        .doctor-header-icon {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: rgba(215, 244, 255, .9);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.4rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
            flex: 0 0 auto;
        }

        .doctor-card {
            width: 100%;
            max-width: 430px;
            min-height: 340px;
            border: 0;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .16);
            backdrop-filter: blur(8px);
        }

        .doctor-card-icon {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: rgba(215, 244, 255, .9);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
        }

        .doctor-card .btn {
            min-width: 132px;
            background: #2463eb;
            border-color: #2463eb;
            font-weight: 600;
            box-shadow: 0 8px 18px rgba(36, 99, 235, .24);
        }

        .doctor-card .btn:hover {
            background: #1f54c9;
            border-color: #1f54c9;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="doctor-home">
        <div class="doctor-title">
            <div class="doctor-header-icon">
                <i class="bi bi-person-badge"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-3">
                    <asp:Literal ID="litTitulo" runat="server" />
                </h1>
                <p class="text-muted fs-5 mb-0">Bienvenido/a a su panel.</p>
            </div>
        </div>

        <div class="d-flex justify-content-center">
            <div class="card doctor-card">
                <div class="card-body p-5 d-flex flex-column">
                    <div class="doctor-card-icon mb-4">
                        <i class="bi bi-clipboard2-pulse"></i>
                    </div>
                    <h2 class="h3 fw-bold mb-3">Mis turnos</h2>
                    <p class="text-muted fs-5 mb-4">Consulte y administre sus turnos asignados en la agenda.</p>
                    <a href="MisTurnosMedicos.aspx" class="btn btn-primary mt-auto align-self-start">Ingresar <i class="bi bi-arrow-right ms-3"></i></a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>