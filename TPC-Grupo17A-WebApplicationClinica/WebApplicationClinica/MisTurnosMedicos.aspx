<%@ Page Title="Mis Turnos" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MisTurnosMedicos.aspx.cs" Inherits="WebApplicationClinica.MisTurnosMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .50), rgba(255, 255, 255, .50)), url('Images/fondoInicio.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .navbar {
            margin: 16px;
            border-radius: 14px;
            background: rgba(255, 255, 255, .72) !important;
            box-shadow: 0 12px 32px rgba(15, 23, 42, .12);
            backdrop-filter: blur(10px);
        }

        .navbar .nav-link,
        .navbar .navbar-brand {
            color: #172033;
            font-weight: 500;
        }

        .navbar .navbar-brand {
            color: #0d6efd;
            font-weight: 700;
        }

        .navbar .btn-outline-dark {
            background: rgba(255, 255, 255, .65);
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 8px 20px rgba(15, 23, 42, .08);
        }

        .mis-turnos-page {
            margin: 48px auto 72px;
        }

        .mis-turnos-card {
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .mis-turnos-header-card {
            margin-bottom: 28px;
        }

        .mis-turnos-header {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .mis-turnos-header-icon {
            width: 72px;
            height: 72px;
            border-radius: 16px;
            background: rgba(239, 246, 255, .95);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.3rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
            flex: 0 0 auto;
        }

        .mis-turnos-table-wrap {
            overflow: visible;
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            background: rgba(255, 255, 255, .86);
        }

        .mis-turnos-table-wrap .table {
            margin-bottom: 0;
        }

        .mis-turnos-table-wrap th {
            padding: 16px;
            background: rgba(248, 250, 252, .92);
            color: #172033;
            font-weight: 700;
            border-bottom-color: rgba(15, 23, 42, .12);
        }

        .mis-turnos-table-wrap td {
            padding: 18px 16px;
            vertical-align: middle;
            color: #172033;
        }

        .estado-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 104px;
            padding: 8px 14px;
            border-radius: 8px;
            font-weight: 700;
            font-size: .92rem;
            line-height: 1;
            border: 1px solid transparent;
        }

        .estado-asignado,
        .estado-programado {
            color: #b45309;
            background: rgba(254, 243, 199, .95);
            border-color: rgba(245, 158, 11, .18);
        }

        .estado-reprogramado {
            color: #c2410c;
            background: rgba(255, 237, 213, .95);
            border-color: rgba(249, 115, 22, .18);
        }

        .estado-cancelado {
            color: #dc2626;
            background: rgba(254, 226, 226, .95);
            border-color: rgba(239, 68, 68, .18);
        }

        .estado-no-asistio {
            color: #475569;
            background: rgba(241, 245, 249, .95);
            border-color: rgba(100, 116, 139, .18);
        }

        .estado-asistio,
        .estado-cerrado {
            color: #15803d;
            background: rgba(220, 252, 231, .95);
            border-color: rgba(34, 197, 94, .18);
        }

        .estado-default {
            color: #1d4ed8;
            background: rgba(219, 234, 254, .95);
            border-color: rgba(59, 130, 246, .18);
        }

        .btn-abrir-turno {
            min-height: 40px;
            padding-left: 16px;
            padding-right: 16px;
            font-weight: 600;
            box-shadow: 0 8px 18px rgba(15, 23, 42, .08);
        }

        @media (max-width: 576px) {
            .mis-turnos-header {
                align-items: flex-start;
            }
        }
    </style>
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
