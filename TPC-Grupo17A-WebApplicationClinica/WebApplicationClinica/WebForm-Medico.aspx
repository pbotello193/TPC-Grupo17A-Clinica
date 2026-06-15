<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Medico.aspx.cs" Inherits="WebApplicationClinica.WebForm_Medico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:ScriptManager runat="server" />
        <div>
            <h1>Medicos</h1>
        </div>
        <div class="row">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div>
                        <asp:CheckBox ID="cbxMostrarTodos" Text="Mostrar todos" runat="server" AutoPostBack="true" OnCheckedChanged="cbxMostrarTodos_CheckedChanged" />
                    </div>
                        <asp:GridView ID="dgvMedicos" runat="server" class="mb-3" OnSelectedIndexChanged="dgvMedicos_SelectedIndexChanged"
                            CssClass="table table-striped table-hover align-middle" DataKeyNames="Id" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                                <asp:BoundField HeaderText="Matricula" DataField="Matricula" />
                                <asp:BoundField HeaderText="Telefono" DataField="Telefono" />
                                <asp:BoundField HeaderText="Email" DataField="Email" />
                                <asp:TemplateField HeaderText="Acción">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-primary">Ver</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <a href="FormularioMedico.aspx" class="btn btn-primary">Agregar</a>

    </div>
</asp:Content>
