<%@ Page Title="Mis Turnos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MisTurnosMedicos.aspx.cs" Inherits="WebApplicationClinica.MisTurnosMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pt-3 pb-5">
        <div class="mb-4">
            <h1 class="h3 fw-bold">Mis turnos</h1>
        </div>

        <div class="card shadow-sm border-0 bg-light">
            <div class="card-body p-4">
                                <asp:GridView ID="dgvMisTurnos" runat="server"
                    CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="Todavia no hay turnos para mostrar.">
                    <Columns>
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                        <asp:BoundField HeaderText="Hora" DataField="Hora" />
                        <asp:BoundField HeaderText="Paciente" DataField="Paciente" />
                        <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado" />
                        <asp:BoundField HeaderText="Motivo de consulta" DataField="Observaciones" />
                        <asp:BoundField HeaderText="Diagnostico" DataField="Diagnostico" />
                        <asp:TemplateField HeaderText="Accion">
                            <ItemTemplate>
                                <asp:Button ID="btnDiagnostico" runat="server" Text="Cargar diagnostico" CssClass="btn btn-sm btn-outline-dark" Enabled="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
