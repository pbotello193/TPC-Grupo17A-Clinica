<%@ Page Title="Inicio Médico" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InicioMedico.aspx.cs" Inherits="WebApplicationClinica.InicioMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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