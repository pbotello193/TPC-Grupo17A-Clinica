<%@ Page Title="Inicio Recepcionista" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioRecepcionista.aspx.cs" Inherits="WebApplicationClinica.InicioRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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