<%@ Page Title="Mis Turnos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MisTurnosMedicos.aspx.cs" Inherits="WebApplicationClinica.MisTurnosMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container mt-4 pb-5">
        <h2 class="mb-0 fw-normal">Mis Turnos</h2>

        <div class="card shadow-sm border-0 bg-light mt-3">
            <div class="card-body p-4">
                <asp:GridView ID="dgvMisTurnos" runat="server"
                    CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="Todavía no hay turnos para mostrar."
                    DataKeyNames="Id"
                    OnRowCommand="dgvMisTurnos_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                        <asp:BoundField HeaderText="Hora" DataField="Hora" />
                        <asp:BoundField HeaderText="Paciente" DataField="Paciente" />
                        <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado" />
                        <asp:BoundField HeaderText="Motivo de consulta" DataField="Observaciones" />
                        
                        <asp:TemplateField HeaderText="Diagnóstico">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDiagnostico" runat="server" Text='<%# Eval("Diagnostico") %>' CssClass="form-control form-control-sm" Enabled='<%# Eval("Estado").ToString() == "Asignado" %>' Placeholder="Escriba el diagnóstico..." />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:Button ID="btnDiagnostico" runat="server" Text="Cargar diagnóstico" CssClass="btn btn-sm btn-outline-success me-1" CommandName="CargarDiag" CommandArgument='<%# Container.DataItemIndex %>' Visible='<%# Eval("Estado").ToString() == "Asignado" %>' />
                                <asp:Button ID="btnNoAsistio" runat="server" Text="No Asistió" CssClass="btn btn-sm btn-outline-danger" CommandName="NoAsistio" CommandArgument='<%# Container.DataItemIndex %>' Visible='<%# Eval("Estado").ToString() == "Asignado" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

            </div>
        </div>
    </div>
</asp:Content>
