<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ListaEspecialidades.aspx.cs" Inherits="WebApplicationClinica.ListaEspecialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Especialidades</h1>
        <div>
            <asp:GridView ID="dgvEspecialidades" runat="server" OnSelectedIndexChanged="dgvEspecialidades_SelectedIndexChanged"
                CssClass="table table-striped table-hover align-middle" DataKeyNames="Id" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField HeaderText="Especialidad" DataField="Nombre" />
                    <asp:BoundField HeaderText="Descripcion" DataField="Descripcion" />

                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnVer" runat="server" CommandName="Select" CssClass="btn btn-sm btn-outline-primary"> Ver
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div>
            <a href="FormularioEspecialidad.aspx" class="btn btn-primary">Agregar</a>
        </div>
    </div>
</asp:Content>
