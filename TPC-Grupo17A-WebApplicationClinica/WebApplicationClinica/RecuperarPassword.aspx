<%@ Page Title="Recuperar contraseña" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RecuperarPassword.aspx.cs" Inherits="WebApplicationClinica.RecuperarPassword" %>

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
                        <p class="text-muted mb-0">Recuperar contraseña</p>
                    </div>

                    <div class="mb-3">
                        <label for="txtUsuario" class="form-label">Ingrese su usuario</label>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
                        <asp:Label ID="lblErrorUsuario" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                    </div>

                    <div class="mb-3">
                        <label for="txtEmail" class="form-label">Ingrese su mail</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        <asp:Label ID="lblErrorEmail" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

                    <div class="d-grid mt-4">
                        <asp:Button ID="btnEnviar" runat="server" Text="Enviar" CssClass="btn btn-dark" OnClick="btnEnviar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>