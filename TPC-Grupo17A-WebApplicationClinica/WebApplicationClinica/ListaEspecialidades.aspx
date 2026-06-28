<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ListaEspecialidades.aspx.cs" Inherits="WebApplicationClinica.ListaEspecialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Especialidades</h1>
        <div>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="d-flex gap-2 align-items-center mb-3">
                        <asp:DropDownList ID="ddlEstadoEspecialidades" runat="server" CssClass="form-select w-auto" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoEspecialidades_SelectedIndexChanged">
                            <asp:ListItem Text="Activos" Value="activos" />
                            <asp:ListItem Text="Inactivos" Value="inactivos" />
                            <asp:ListItem Text="Todos" Value="todos" />
                        </asp:DropDownList>

                        <asp:TextBox ID="txtBuscar" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscar_TextChanged"
                            placeholder="Buscar por nombre o descripción de especialidad..." />
                    </div>

                    <asp:GridView ID="dgvEspecialidades" runat="server" OnSelectedIndexChanged="dgvEspecialidades_SelectedIndexChanged"
                        CssClass="table table-striped table-hover align-middle" DataKeyNames="Id" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField HeaderText="Especialidad" DataField="Nombre" />
                            <asp:BoundField HeaderText="Descripcion" DataField="Descripcion" />
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='<%# (bool)Eval("Activo") ? "badge bg-success" : "badge bg-secondary" %>'>
                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-primary"> Ver
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div>
            <a href="FormularioEspecialidad.aspx" class="btn btn-primary">Agregar</a>
        </div>
    </div>
</asp:Content>
