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
                        <asp:Button ID="btnAceptar" class="btn btn-primary" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" />
                        <a href="ListaEspecialidades.aspx" class="btn btn-danger">Cancelar</a>
                    </div>
                    <div class="mb-3">
                        <asp:Button runat="server" ID="btnEliminarFisico" Text="Eliminar Fisico" class="btn btn-secondary" OnClick="btnEliminarFisico_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
