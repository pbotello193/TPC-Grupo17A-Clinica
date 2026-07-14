<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Usuarios.aspx.cs" Inherits="WebApplicationClinica.WebForm_Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="mb-3">
            <h2 class="mb-4">Usuarios</h2>

            <div class="d-flex gap-2 align-items-center">
                <asp:TextBox ID="txtBuscar" runat="server"
                    CssClass="form-control"
                    placeholder="Buscar por rol, apellido, nombre o DNI" />
            </div>
        </div>

        <div class="mb-3">
            <a href="#" class="btn btn-primary">Agregar Usuario</a>
        </div>
    </div>
</asp:Content>
