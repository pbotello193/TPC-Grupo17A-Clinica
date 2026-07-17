<%@ Page Title="Mis Turnos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MisTurnosMedicos.aspx.cs" Inherits="WebApplicationClinica.MisTurnosMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mis-turnos-page">
        <div class="mis-turnos-card mis-turnos-header-card">
            <div class="mis-turnos-header">
                <div class="mis-turnos-header-icon">
                    <i class="bi bi-calendar-heart"></i>
                </div>
                <div>
                    <h1 class="display-6 fw-bold mb-2">Mis Turnos</h1>
                    <p class="text-muted fs-5 mb-0">Turnos asignados para la atención médica.</p>
                </div>
            </div>
        </div>

        <div class="mis-turnos-card">
            <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false"></asp:Label>

            <div class="mis-turnos-table-wrap table-responsive">
                <asp:GridView ID="dgvMisTurnos" runat="server"
                    CssClass="table table-hover align-middle"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="No tiene más turnos asignados para hoy."
                    DataKeyNames="Id"
                    OnRowCommand="dgvMisTurnos_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                        <asp:BoundField HeaderText="Hora" DataField="Hora" />
                        <asp:BoundField HeaderText="Paciente" DataField="Paciente" />
                        <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                        <asp:BoundField HeaderText="Motivo de consulta" DataField="Observaciones" />

                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <span class='<%# badgeEstado(Convert.ToString(Eval("Estado"))) %>'>
                                    <%# Eval("Estado") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnAbrirTurno" runat="server"
                                    CssClass="btn btn-sm btn-success btn-abrir-turno text-white"
                                    CommandName="AbrirTurno"
                                    CommandArgument='<%# Eval("Id") %>'>
                                    <i class="bi bi-clipboard-pulse me-1"></i> Abrir turno
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
