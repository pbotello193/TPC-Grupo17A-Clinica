<%@ Page Title="Inicio Médico" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioMedico.aspx.cs" Inherits="WebApplicationClinica.InicioMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pt-3 pb-5">
        <div class="mb-4">
            <h1 class="h3 fw-bold">
                <asp:Literal ID="litTitulo" runat="server" />
            </h1>
            <p class="text-muted mb-0">Consulta de turnos asignados.</p>
        </div>

        <div class="row g-4 justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info-subtle bg-opacity-10 text-info-emphasis d-inline-flex align-items-center justify-content-center mb-3" style="width: 56px; height: 56px;">
                            <i class="bi bi-clipboard2-pulse fs-3"></i>
                        </div>
                        <h5 class="card-title fw-bold">Mis turnos</h5>
                        <p class="card-text text-muted">Consultar turnos asignados y registrar observaciones del paciente.</p>
                        <a href="MisTurnosMedicos.aspx" class="btn btn-dark">Ingresar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
