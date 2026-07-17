<%@ Page Title="Cambiar contraseña" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CambiarPassword.aspx.cs" Inherits="WebApplicationClinica.CambiarPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
                </div>
                <asp:Label ID="lblErrorPasswordActual" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>

            <div class="mb-4">
                <label for="txtPasswordNueva" class="form-label">Nueva contraseña</label>
                <div class="password-input">
                    <i class="bi bi-lock"></i>
                    <asp:TextBox ID="txtPasswordNueva" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su nueva contraseña" />
                </div>
                <asp:Label ID="lblErrorPasswordNueva" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>

            <div class="mb-4">
                <label for="txtPasswordConfirmacion" class="form-label">Confirmar nueva contraseña</label>
                <div class="password-input">
                    <i class="bi bi-lock"></i>
                    <asp:TextBox ID="txtPasswordConfirmacion" runat="server" CssClass="form-control" TextMode="Password" placeholder="Repita su nueva contraseña" />
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

