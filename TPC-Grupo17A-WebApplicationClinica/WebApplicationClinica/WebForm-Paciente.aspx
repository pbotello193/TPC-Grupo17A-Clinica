<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Paciente.aspx.cs" Inherits="WebApplicationClinica.WebForm_Paciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="mb-3">
            <h2 class="mb-4">Pacientes</h2>

            <div class="d-flex gap-2 align-items-center">
                <asp:DropDownList ID="ddlEstadoPacientes" runat="server" CssClass="form-select w-auto" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoPacientes_SelectedIndexChanged">
                    <asp:ListItem Text="Activos" Value="activos" />
                    <asp:ListItem Text="Inactivos" Value="inactivos" />
                    <asp:ListItem Text="Todos" Value="todos" />
                </asp:DropDownList>

                <%--busca pacientes dentro de la lista seleccionada (activos-inactivos-todos) --%>
                <asp:TextBox ID="txtBuscar" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnTextChanged="txtBuscar_TextChanged"
                    placeholder="Buscar por apellido, nombre o DNI" />
            </div>
        </div>

        <div class="mb-3">
            <asp:GridView ID="dgvPacientes" runat="server"
                CssClass="table table-striped table-hover align-middle"
                DataKeyNames="Id"
                AutoGenerateColumns="false"
                OnRowCommand="dgvPacientes_RowCommand"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No se encontraron pacientes.">
                <Columns>
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="DNI" DataField="Dni" />
                    <asp:BoundField HeaderText="Fecha de nacimiento" DataField="FechaNacimiento" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Dirección" DataField="Direccion" />

                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <%--muestra si el paciente esta activo o inactivo --%>
                            <span class='<%# (bool)Eval("Activo") ? "badge bg-success" : "badge bg-secondary" %>'>
                                <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnHistorial" runat="server" CommandName="VerHistorial" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary">
                                Historial de turnos
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary">
                                Editar
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="mb-3">
            <a href="FormularioPaciente.aspx" class="btn btn-primary">Agregar</a>
        </div>
    </div>
</asp:Content>
