<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Usuarios.aspx.cs" Inherits="WebApplicationClinica.WebForm_Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="mb-3">
            <h2 class="mb-4">Personal Administrativo</h2>

            <div class="d-flex gap-2 align-items-center">
                <asp:DropDownList ID="ddlEstadoUsuarios" runat="server" CssClass="form-select w-auto" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoUsuarios_SelectedIndexChanged">
                    <asp:ListItem Text="Activos" Value="activos" />
                    <asp:ListItem Text="Inactivos" Value="inactivos" />
                    <asp:ListItem Text="Todos" Value="todos" />
                </asp:DropDownList>

                <asp:DropDownList ID="ddlRolUsuarios" runat="server" CssClass="form-select w-auto" AutoPostBack="true" OnSelectedIndexChanged="ddlRolUsuarios_SelectedIndexChanged">
                    <asp:ListItem Text="Todos" Value="todos" />
                    <asp:ListItem Text="Administradores" Value="admin" />
                    <asp:ListItem Text="Recepcionistas" Value="recepcion" />
                </asp:DropDownList>

                <asp:TextBox ID="txtBuscar" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnTextChanged="txtBuscar_TextChanged"
                    placeholder="Buscar por apellido, nombre o DNI" />
            </div>

        </div>

        <div class="mb-3">
            <asp:GridView ID="dgvUsuarios" runat="server"
                CssClass="table table-striped table-hover align-middle"
                AutoGenerateColumns="false"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No se encontró personal administrativo.">
                <Columns>
                    <asp:BoundField HeaderText="Rol" DataField="Rol" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="DNI" DataField="DNI" />
                    <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='<%# (bool)Eval("Activo") ? "badge bg-success" : "badge bg-secondary" %>'>
                                <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="mb-3">
            <a href="#" class="btn btn-primary">Agregar Usuario</a>
        </div>
    </div>
</asp:Content>


