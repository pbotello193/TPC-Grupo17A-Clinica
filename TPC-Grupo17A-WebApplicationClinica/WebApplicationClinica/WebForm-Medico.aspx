<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Medico.aspx.cs" Inherits="WebApplicationClinica.WebForm_Medico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">   
        <div class="mb-3">
            <h1>Médicos</h1>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="d-flex gap-2 align-items-center mb-3">
                        <asp:DropDownList ID="ddlEstadoMedicos" runat="server" CssClass="form-select w-auto" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoMedicos_SelectedIndexChanged">
                            <asp:ListItem Text="Activos" Value="activos" />
                            <asp:ListItem Text="Inactivos" Value="inactivos" />
                            <asp:ListItem Text="Todos" Value="todos" />
                        </asp:DropDownList>

                        <asp:TextBox ID="txtBuscar" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscar_TextChanged"
                            placeholder="Buscar por apellido, nombre o matrícula..." />
                    </div>

                    <asp:GridView ID="dgvMedicos" runat="server" OnSelectedIndexChanged="dgvMedicos_SelectedIndexChanged"
                        CssClass="table table-striped table-hover align-middle" DataKeyNames="Id" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                            <asp:BoundField HeaderText="Matrícula" DataField="Matricula" />
                            
                            <%-- Columna para mostrar las especialidades como etquitas --%>
                            <asp:TemplateField HeaderText="Especialidades">
                                <ItemTemplate>
                                    <asp:Repeater ID="repEspecialidades" runat="server" DataSource='<%# Eval("Especialidades") %>'>
                                        <ItemTemplate>
                                            <span class="badge text-bg-light border me-1"><%# Eval("Nombre") %></span>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                            <asp:BoundField HeaderText="Email" DataField="Email" />
                            
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <span class='<%# (bool)Eval("Activo") ? "badge bg-success" : "badge bg-secondary" %>'>
                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-primary">
                                        Ver
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="mb-3">
            <a href="FormularioMedico.aspx" class="btn btn-primary">Agregar</a>
        </div>
    </div>
</asp:Content>