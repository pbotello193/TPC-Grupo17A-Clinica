<%@ Page Title="Cambiar contraseña" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CambiarPassword.aspx.cs" Inherits="WebApplicationClinica.CambiarPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="col-12 col-md-6 col-lg-4">
            <div class="card shadow-sm border-0 bg-light">
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <i class="bi bi-hospital fs-1 text-info"></i>
                        <h1 class="h4 mt-2 mb-1">Clínica Médica</h1>
                        <p class="text-muted mb-0">Cambio de contraseña</p>
                    </div>

                    <div class="mb-3">
                        <label for="txtPasswordActual" class="form-label">Contraseña actual</label>
                        <asp:TextBox ID="txtPasswordActual" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:Label ID="lblErrorPasswordActual" runat="server" CssClass="text-danger mt-1 d-block" Visible="false" />
                    </div>

                    <div class="mb-3">
                        <label for="txtPasswordNueva" class="form-label">Nueva contraseña</label>
                        <asp:TextBox ID="txtPasswordNueva" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:Label ID="lblErrorPasswordNueva" runat="server" CssClass="text-danger mt-1 d-block" Visible="false" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

                    <div class="d-grid mt-4">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-dark" OnClick="btnGuardar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
