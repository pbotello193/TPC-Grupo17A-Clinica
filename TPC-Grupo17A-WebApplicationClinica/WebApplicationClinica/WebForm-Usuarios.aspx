<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Usuarios.aspx.cs" Inherits="WebApplicationClinica.WebForm_Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="usuarios-panel">
        <div class="usuarios-header">
            <div class="usuarios-header-icon">
                <i class="bi bi-people"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Personal Administrativo</h1>
                <p class="text-muted fs-6 mb-0">Gestión del personal administrativo de la clínica.</p>
            </div>
        </div>

        <div class="usuarios-filtros">
            <asp:DropDownList ID="ddlEstadoUsuarios" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoUsuarios_SelectedIndexChanged">
                <asp:ListItem Text="Activos" Value="activos" />
                <asp:ListItem Text="Inactivos" Value="inactivos" />
                <asp:ListItem Text="Todos" Value="todos" />
            </asp:DropDownList>

            <asp:DropDownList ID="ddlRolUsuarios" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlRolUsuarios_SelectedIndexChanged">
                <asp:ListItem Text="Todos" Value="todos" />
                <asp:ListItem Text="Administradores" Value="admin" />
                <asp:ListItem Text="Recepcionistas" Value="recepcion" />
            </asp:DropDownList>

            <div class="usuarios-search">
                <i class="bi bi-search"></i>
                <asp:TextBox ID="txtBuscar" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnTextChanged="txtBuscar_TextChanged"
                    placeholder="Buscar por apellido, nombre o DNI" />
            </div>
        </div>

        <div class="usuarios-table-wrap">
            <asp:GridView ID="dgvUsuarios" runat="server"
                CssClass="table table-hover align-middle"
                AutoGenerateColumns="false"
                DataKeyNames="Id"
                OnRowCommand="dgvUsuarios_RowCommand"
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
                            <span class='<%# (bool)Eval("Activo") ? "badge rounded-pill bg-success" : "badge rounded-pill bg-secondary" %>'>
                                <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary">
                                <i class="bi bi-pencil me-1"></i>Editar
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="usuarios-actions">
            <a href="FormularioUsuario.aspx" class="btn btn-primary"><i class="bi bi-plus-lg me-2"></i>Agregar Personal</a>
        </div>
    </div>
</asp:Content>
