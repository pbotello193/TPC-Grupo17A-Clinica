<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Medico.aspx.cs" Inherits="WebApplicationClinica.WebForm_Medico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="medicos-panel">
        <div class="medicos-header">
            <div class="medicos-header-icon">
                <i class="bi bi-person-badge"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Médicos</h1>
                <p class="text-muted fs-6 mb-0">Gestión y administración de los profesionales médicos.</p>
            </div>
        </div>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="medicos-filtros">
                    <asp:DropDownList ID="ddlEstadoMedicos" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoMedicos_SelectedIndexChanged">
                        <asp:ListItem Text="Activos" Value="activos" />
                        <asp:ListItem Text="Inactivos" Value="inactivos" />
                        <asp:ListItem Text="Todos" Value="todos" />
                    </asp:DropDownList>

                    <div class="medicos-search">
                        <i class="bi bi-search"></i>
                        <asp:TextBox ID="txtBuscar" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscar_TextChanged"
                            placeholder="Buscar por apellido, nombre o matrícula..." />
                    </div>
                </div>

                <div class="medicos-table-wrap">
                    <asp:GridView ID="dgvMedicos" runat="server" OnSelectedIndexChanged="dgvMedicos_SelectedIndexChanged"
                        CssClass="table table-hover align-middle" DataKeyNames="Id" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                            <asp:BoundField HeaderText="Matrícula" DataField="Matricula" />

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
                                    <span class='<%# (bool)Eval("Activo") ? "badge rounded-pill bg-success" : "badge rounded-pill bg-secondary" %>'>
                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-danger">
                                        Editar
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="medicos-actions">
            <a id="lnkAgregarMedico" runat="server" href="FormularioMedico.aspx" class="btn btn-primary"><i class="bi bi-plus-lg me-2"></i>Agregar médico</a>
        </div>
    </div>
</asp:Content>