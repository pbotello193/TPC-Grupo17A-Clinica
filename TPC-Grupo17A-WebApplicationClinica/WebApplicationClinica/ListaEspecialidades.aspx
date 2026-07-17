<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ListaEspecialidades.aspx.cs" Inherits="WebApplicationClinica.ListaEspecialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="especialidades-panel">
        <div class="especialidades-header">
            <div class="especialidades-header-icon">
                <i class="bi bi-bookmark-plus"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Especialidades</h1>
                <p class="text-muted fs-6 mb-0">Gestión de especialidades médicas.</p>
            </div>
        </div>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="especialidades-filtros">
                    <asp:DropDownList ID="ddlEstadoEspecialidades" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoEspecialidades_SelectedIndexChanged">
                        <asp:ListItem Text="Activos" Value="activos" />
                        <asp:ListItem Text="Inactivos" Value="inactivos" />
                        <asp:ListItem Text="Todos" Value="todos" />
                    </asp:DropDownList>

                    <div class="especialidades-search">
                        <i class="bi bi-search"></i>
                        <asp:TextBox ID="txtBuscar" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscar_TextChanged"
                            placeholder="Buscar por nombre o descripción de especialidad..." />
                    </div>
                </div>

                <div class="especialidades-table-wrap">
                    <asp:GridView ID="dgvEspecialidades" runat="server" OnSelectedIndexChanged="dgvEspecialidades_SelectedIndexChanged"
                        CssClass="table table-hover align-middle" DataKeyNames="Id" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField HeaderText="Especialidad" DataField="Nombre" />
                            <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='<%# (bool)Eval("Activo") ? "badge rounded-pill bg-success" : "badge rounded-pill bg-secondary" %>'>
                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-pencil me-1"></i>Editar
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="especialidades-actions">
            <a href="FormularioEspecialidad.aspx" class="btn btn-primary"><i class="bi bi-plus-lg me-2"></i>Agregar</a>
        </div>
    </div>
</asp:Content>
