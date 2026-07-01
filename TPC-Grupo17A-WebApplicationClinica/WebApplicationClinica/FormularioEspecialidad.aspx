<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioEspecialidad.aspx.cs" Inherits="WebApplicationClinica.FormularioEspecialidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div>
            <div class="row">
                <div class="col-6">
                    <div class="mb-3">
                        <label for="txtId" class="form-label">Id</label>
                        <asp:TextBox runat="server" ID="txtId" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtNombre" class="form-label">Nombre</label>
                        <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtDescripcion" class="form-label">Descripcion</label>
                        <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblEstado" Text="Estado:" runat="server" Font-Bold="true" />
                        <div class="mb-3">
                            <asp:RadioButton ID="rdbActivo" Text="Activo" runat="server" GroupName="Estado" />
                            <asp:RadioButton ID="rdbInactivo" Text="Inactivo" runat="server" GroupName="Estado" />
                        </div>
                    </div>
                    <div class="mb-3">
                        <!-- lbl para mostrar mjs de error -->
                        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Font-Bold="true" Visible="false"></asp:Label>
                    </div>
                    <div class="mb-3">
                        <asp:Button ID="btnAceptar" class="btn btn-primary" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" />
                        <a href="ListaEspecialidades.aspx" class="btn btn-danger">Cancelar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
