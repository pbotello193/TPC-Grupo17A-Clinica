<%@ Page Title="Recuperar contraseña" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RecuperarPassword.aspx.cs" Inherits="WebApplicationClinica.RecuperarPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="recover-page">
        <div class="card recover-card">
            <div class="card-body p-4 p-md-5">
                <div class="text-center mb-4">
                    <span class="recover-icon mb-3">
                        <i class="bi bi-hospital fs-1"></i>
                    </span>
                    <h1 class="h3 fw-bold mb-1">Clínica Médica</h1>
                    <p class="fw-bold mb-3">Recuperar contraseña</p>
                    <div class="alert alert-info py-2 px-3 mb-0 small text-start">
                        <i class="bi bi-info-circle-fill me-2"></i>
                        Ingrese su usuario o mail y le enviaremos un enlace para recuperar su contraseña.
                    </div>
                </div>

                <div class="mb-3">
                    <label for="txtUsuarioOMail" class="form-label">Usuario o mail</label>
                    <div class="input-group">
                        <span class="input-group-text recover-input-icon"><i class="bi bi-person-fill"></i></span>
                        <asp:TextBox ID="txtUsuarioOMail" runat="server" CssClass="form-control recover-input" />
                    </div>
                    <asp:Label ID="lblErrorUsuarioOMail" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

                <div class="d-grid mt-4">
                    <asp:Button ID="btnEnviar" runat="server" Text="Enviar" CssClass="btn btn-primary recover-button" OnClick="btnEnviar_Click" />
                </div>

                <div class="text-center mt-4">
                    <a href="Login.aspx" class="text-decoration-none fw-semibold">Volver al inicio de sesión</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>