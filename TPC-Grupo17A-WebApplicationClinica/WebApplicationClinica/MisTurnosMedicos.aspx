<%@ Page Title="Mis Turnos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MisTurnosMedicos.aspx.cs" Inherits="WebApplicationClinica.MisTurnosMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container mt-4 pb-5">
        
        <div class="mb-4 d-flex justify-content-between align-items-center bg-light p-3 rounded-3 shadow-sm">
            <div>
                <h2 class="fw-bold mb-1 text-dark">Mi Agenda Médica</h2>
                <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger d-block" Visible="false"></asp:Label>
            </div>
        </div>

        <div class="card shadow-sm border-0 p-3 bg-white rounded-3">
            <div class="table-responsive">
                <asp:GridView ID="dgvMisTurnos" runat="server"
                    CssClass="table table-striped table-hover align-middle m-0"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="No tiene turnos asignados para hoy."
                    DataKeyNames="Id"
                    OnRowCommand="dgvMisTurnos_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                        <asp:BoundField HeaderText="Hora" DataField="Hora" />
                        <asp:BoundField HeaderText="Paciente" DataField="Paciente" />
                        <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                        <asp:BoundField HeaderText="Motivo de Consulta" DataField="Observaciones" />

                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnAbrirTurno" runat="server" 
                                    Text="Abrir turno" 
                                    CssClass="btn btn-sm btn-success px-3 text-white fw-semibold shadow-sm" 
                                    CommandName="AbrirTurno" 
                                    CommandArgument='<%# Eval("Id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
