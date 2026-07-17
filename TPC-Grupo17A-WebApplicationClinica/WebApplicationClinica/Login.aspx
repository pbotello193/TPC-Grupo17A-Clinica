<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplicationClinica.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-page">
        <div class="card login-card">
            <div class="card-body p-4 p-md-5">
                <div class="text-center mb-4">
                    <span class="login-icon mb-3">
                        <i class="bi bi-hospital fs-1"></i>
                    </span>
                    <h1 class="h3 fw-bold mb-1">Clínica Médica</h1>
                    <p class="text-muted mb-0">Ingreso al sistema</p>
                </div>

                <div class="mb-3">
                    <label for="txtUsuario" class="form-label">Usuario</label>
                    <div class="input-group">
                        <span class="input-group-text login-input-icon"><i class="bi bi-person-fill"></i></span>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control login-input" />
                    </div>
                    <asp:Label ID="lblErrorUsuario" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="txtPassword" class="form-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text login-input-icon"><i class="bi bi-lock-fill"></i></span>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control login-input" TextMode="Password" />
                    </div>
                    <asp:Label ID="lblErrorPassword" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

                <div class="d-grid mt-4">
                    <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-primary login-button" OnClick="btnLogin_Click" />
                </div>

                <div class="text-center mt-4">
                    <a href="RecuperarPassword.aspx" class="text-decoration-none fw-semibold">¿Olvidaste tu contraseña?</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>