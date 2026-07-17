<%@ Page Title="Cambiar contraseña" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CambiarPassword.aspx.cs" Inherits="WebApplicationClinica.CambiarPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .50), rgba(255, 255, 255, .50)), url('Images/fondoInicio.png');
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

        .password-page {
            min-height: calc(100vh - 110px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 0 72px;
        }

        .password-card {
            width: min(100%, 540px);
            padding: 38px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(10px);
        }

        .password-icon {
            width: 84px;
            height: 84px;
            border-radius: 50%;
            margin: 0 auto 18px;
            background: rgba(215, 244, 255, .9);
            color: #0dcaf0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.6rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
        }

        .password-divider {
            border: 0;
            border-top: 1px solid rgba(15, 23, 42, .12);
            margin: 26px 0 28px;
        }

        .form-label {
            color: #172033;
            font-weight: 500;
        }

        .password-input {
            position: relative;
        }

        .password-input .bi-lock {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            z-index: 2;
        }

        .password-input .bi-eye {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            z-index: 2;
        }

        .password-input .form-control {
            min-height: 48px;
            padding-left: 52px;
            padding-right: 52px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .password-card .btn-dark {
            min-height: 48px;
            font-weight: 600;
            box-shadow: 0 10px 22px rgba(15, 23, 42, .18);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="password-page">
        <div class="password-card">
            <div class="text-center">
                <div class="password-icon">
                    <i class="bi bi-hospital"></i>
                </div>
                <h1 class="display-6 fw-bold mb-2">Clínica Médica</h1>
                <p class="text-muted fs-5 mb-0">Cambio de contraseña</p>
            </div>

            <hr class="password-divider" />

            <div class="mb-4">
                <label for="txtPasswordActual" class="form-label">Contraseña actual</label>
                <div class="password-input">
                    <i class="bi bi-lock"></i>
                    <asp:TextBox ID="txtPasswordActual" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su contraseña actual" />
                    <i class="bi bi-eye"></i>
                </div>
                <asp:Label ID="lblErrorPasswordActual" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>

            <div class="mb-4">
                <label for="txtPasswordNueva" class="form-label">Nueva contraseña</label>
                <div class="password-input">
                    <i class="bi bi-lock"></i>
                    <asp:TextBox ID="txtPasswordNueva" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su nueva contraseña" />
                    <i class="bi bi-eye"></i>
                </div>
                <asp:Label ID="lblErrorPasswordNueva" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>

            <div class="mb-4">
                <label for="txtPasswordConfirmacion" class="form-label">Confirmar nueva contraseña</label>
                <div class="password-input">
                    <i class="bi bi-lock"></i>
                    <asp:TextBox ID="txtPasswordConfirmacion" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repita su nueva contraseña" />
                    <i class="bi bi-eye"></i>
                </div>
                <asp:Label ID="lblErrorPasswordConfirmacion" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>

            <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger d-block" Visible="false" />
            <asp:HyperLink ID="lnkVolverInicio" runat="server" CssClass="btn btn-outline-dark w-100 mb-3" Visible="false">Volver al inicio</asp:HyperLink>

            <div class="d-grid mt-4">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-dark" OnClick="btnGuardar_Click" />
            </div>
        </div>
    </div>
</asp:Content>
