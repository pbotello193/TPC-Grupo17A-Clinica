<%@ Page Title="Inicio Recepcionista" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioRecepcionista.aspx.cs" Inherits="WebApplicationClinica.InicioRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pt-3 pb-5">
        <div class="mb-4">
            <h1 class="h3 fw-bold">Recepción</h1>
            <p class="text-muted mb-0">Gestión de turnos, pacientes y médicos.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-calendar-check fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Turnos</h5>
                        <p class="card-text text-muted">Alta y consulta de turnos.</p>
                        <a href="WebForm-Turnos.aspx" class="btn btn-dark">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-person fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Pacientes</h5>
                        <p class="card-text text-muted">Administración de pacientes.</p>
                        <a href="WebForm-Paciente.aspx" class="btn btn-dark">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-heart-pulse fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Médicos</h5>
                        <p class="card-text text-muted">Administración de médicos.</p>
                        <a href="WebForm-Medico.aspx" class="btn btn-dark">Ingresar</a>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-calendar-week fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Agenda Médicos</h5>
                        <p class="card-text text-muted">Vista de agenda por profesional.</p>
                        <a href="#" class="btn btn-dark" aria-disabled="true">Ingresar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
