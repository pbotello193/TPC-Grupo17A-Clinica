<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioMedico.aspx.cs" Inherits="WebApplicationClinica.FormularioMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*Estilo para los mjs de validacion*/
        .validacion {
            color: red;
            font-size: 13px;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="row">
            <div class="col-6">
                <div class="mb-3">
                    <asp:Label ID="lblErrorGeneral" runat="server" CssClass="alert alert-danger d-block" Visible="false" />
                </div>
                <div class="mb-3">
                    <label for="txtId" class="form-label">Id</label>
                    <asp:TextBox runat="server" ID="txtId" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre</label>
                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                    <asp:Label ID="lblErrorNombre" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>
                <div class="mb-3">
                    <label for="txtApellido" class="form-label">Apellido</label>
                    <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" />
                    <asp:Label ID="lblErrorApellido" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>
                <div class="mb-3">
                    <label for="txtMatricula" class="form-label">Matrícula</label>
                    <asp:TextBox runat="server" ID="txtMatricula" CssClass="form-control" />
                    <asp:Label ID="lblErrorMatricula" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
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
            </div>
            <asp:Panel ID="pnlUsuarioMedico" runat="server">
                <h5>Usuario de acceso</h5>
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
            </asp:Panel>
            <div>
                <div class="mb-3">
                    <!-- lbl para mostrar mjs de error -->
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Font-Bold="true" Visible="false"></asp:Label>
                </div>
                <div class="mb-3">
                    <asp:Label ID="lblEspecialidades" runat="server" Text="Especialidades:" Font-Bold="true"></asp:Label>
                    <asp:CheckBoxList ID="cblEspecialidades" runat="server" DataTextField="Nombre" DataValueField="Id"></asp:CheckBoxList>
                    <asp:Label ID="lblErrorEspecialidades" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>
                <div class="mb-3">
                    <asp:Label ID="lblEstado" Text="Estado:" runat="server" Font-Bold="true" />
                    <div class="mb-3">
                        <asp:RadioButton ID="rdbActivo" Text="Activo" runat="server" GroupName="Estado" />
                        <asp:RadioButton ID="rdbInactivo" Text="Inactivo" runat="server" GroupName="Estado" />
                    </div>
                    <asp:Label ID="lblErrorEstado" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>

            </div>
            <div class="mb-3">
                <asp:Button Text="Aceptar" runat="server" ID="btnAceptar" class="btn btn-primary" OnClick="btnAceptar_Click" />
                <a href="WebForm-Medico.aspx" class="btn btn-danger">Cancelar</a>
            </div>
        </div>
    </div>
</asp:Content>
