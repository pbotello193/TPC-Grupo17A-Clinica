<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioUsuario.aspx.cs" Inherits="WebApplicationClinica.FormularioUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-6">

                <div class="mb-3">
                    <asp:Label ID="lblErrorGeneral" runat="server" CssClass="alert alert-danger d-block" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="ddlRol" class="form-label">Rol</label>
                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Seleccione un rol" Value="" />
                        <asp:ListItem Text="Administrador" Value="1" />
                        <asp:ListItem Text="Recepcionista" Value="2" />
                    </asp:DropDownList>
                    <asp:Label ID="lblErrorRol" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="txtApellido" class="form-label">Apellido</label>
                    <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" />
                    <asp:Label ID="lblErrorApellido" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre</label>
                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                    <asp:Label ID="lblErrorNombre" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="txtDni" class="form-label">DNI</label>
                    <asp:TextBox runat="server" ID="txtDni" CssClass="form-control" />
                    <asp:Label ID="lblErrorDni" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="txtTelefono" class="form-label">Teléfono</label>
                    <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" />
                    <asp:Label ID="lblErrorTelefono" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email</label>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
                    <asp:Label ID="lblErrorEmail" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <h5 class="mb-3">Usuario de acceso</h5>

                <div class="mb-3">
                    <label for="txtUsuario" class="form-label">Usuario</label>
                    <asp:TextBox runat="server" ID="txtUsuario" CssClass="form-control" />
                    <asp:Label ID="lblErrorUsuario" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

                <div class="mb-3">
                    <label for="txtPassword" class="form-label">Contraseña</label>
                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password" />
                    <asp:Label ID="lblErrorPassword" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>


                <div class="mb-3">
                    <asp:Button Text="Aceptar" runat="server" ID="btnAceptar" class="btn btn-primary" OnClick="btnAceptar_Click" />
                    <a href="WebForm-Usuarios.aspx" class="btn btn-danger">Cancelar</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>




