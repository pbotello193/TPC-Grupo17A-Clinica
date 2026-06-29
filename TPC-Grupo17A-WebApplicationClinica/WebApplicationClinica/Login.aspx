<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplicationClinica.Login" %>

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
                        <p class="text-muted mb-0">Ingreso al sistema</p>
                    </div>

                    <div class="mb-3">
                        <label for="txtUsuario" class="form-label">Usuario</label>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
                    </div>

                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Contraseña</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>

                    <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

                    <div class="d-grid mt-4">
                        <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-dark" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
