<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Paciente.aspx.cs" Inherits="WebApplicationClinica.WebForm_Paciente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Pacientes</h1>

        <div class="mb-3">
            <asp:GridView ID="dgvPacientes" runat="server"
                CssClass="table table-striped table-hover align-middle"
                DataKeyNames="Id"
                AutoGenerateColumns="false"
                OnSelectedIndexChanged="dgvPacientes_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="DNI" DataField="Dni" />
                    <asp:BoundField HeaderText="Fecha de nacimiento" DataField="FechaNacimiento" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField HeaderText="Telefono" DataField="Telefono" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Direccion" DataField="Direccion" />

                    <asp:TemplateField HeaderText="Accion">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-primary">
                                Ver
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
