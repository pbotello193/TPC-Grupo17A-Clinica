<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioTurnoDeTrabajo.aspx.cs" Inherits="WebApplicationClinica.FormularioTurnoDeTrabajo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .42), rgba(255, 255, 255, .42)), url('Images/fondoInicio.png');
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

        .horarios-panel {
            margin: 48px auto 72px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .86);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .horarios-title {
            margin-bottom: 28px;
        }

        .horarios-title h1,
        .horarios-list-header h2 {
            color: #172033;
        }

        .form-label {
            color: #172033;
            font-weight: 500;
        }

        .form-select,
        .form-control {
            min-height: 44px;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .input-icon-group {
            display: flex;
            align-items: stretch;
        }

        .input-icon {
            width: 52px;
            min-height: 44px;
            border: 1px solid rgba(15, 23, 42, .12);
            border-right: 0;
            border-radius: .375rem 0 0 .375rem;
            background: rgba(239, 246, 255, .95);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .input-icon-group .form-select,
        .input-icon-group .form-control {
            border-radius: 0 .375rem .375rem 0;
        }

        .horarios-list-header {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 24px;
        }

        .horarios-list-icon {
            width: 58px;
            height: 58px;
            border-radius: 14px;
            background: rgba(239, 246, 255, .95);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.9rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
            flex: 0 0 auto;
        }

        .horarios-filter-box {
            padding: 18px;
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            background: rgba(255, 255, 255, .64);
            margin-bottom: 22px;
        }

        .horarios-table-wrap {
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 12px;
            overflow: hidden;
            background: rgba(255, 255, 255, .82);
        }

        .horarios-table-wrap .table {
            margin-bottom: 0;
        }

        .horarios-table-wrap th {
            background: rgba(248, 250, 252, .88);
            color: #475569;
            font-weight: 700;
            border-bottom-color: rgba(15, 23, 42, .12);
        }

        .horarios-table-wrap td {
            vertical-align: middle;
        }

        .horarios-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 22px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="horarios-panel">
        <div class="horarios-title">
            <h1 class="h2 fw-bold mb-2">Horarios de Trabajo del Médico</h1>
            <p class="text-muted fs-6 mb-0">Registre y administre los horarios de atención de los médicos.</p>
        </div>

        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block" Visible="false"></asp:Label>

        <div class="row g-5">
            <div class="col-md-6">
                <div class="mb-3">
                    <label class="form-label">Médico</label>
                    <div class="input-icon-group">
                        <span class="input-icon"><i class="bi bi-person"></i></span>
                        <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlMedico_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Especialidad</label>
                    <div class="input-icon-group">
                        <span class="input-icon"><i class="bi bi-stethoscope"></i></span>
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select"
                            EnableViewState="false">
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Id Horario</label>
                    <div class="input-icon-group">
                        <span class="input-icon"><i class="bi bi-calendar-check"></i></span>
                        <asp:TextBox runat="server" ID="txtId" CssClass="form-control" Enabled="false" />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Día de la semana</label>
                    <div class="input-icon-group">
                        <span class="input-icon"><i class="bi bi-calendar3"></i></span>
                        <asp:DropDownList ID="ddlDia" runat="server" CssClass="form-select">
                            <asp:ListItem Value="1" Text="Lunes" />
                            <asp:ListItem Value="2" Text="Martes" />
                            <asp:ListItem Value="3" Text="Miércoles" />
                            <asp:ListItem Value="4" Text="Jueves" />
                            <asp:ListItem Value="5" Text="Viernes" />
                            <asp:ListItem Value="6" Text="Sábado" />
                            <asp:ListItem Value="0" Text="Domingo" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Hora Inicio</label>
                    <div class="input-icon-group">
                        <span class="input-icon"><i class="bi bi-clock"></i></span>
                        <asp:DropDownList ID="ddlHoraInicio" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Hora Fin</label>
                    <div class="input-icon-group">
                        <span class="input-icon"><i class="bi bi-clock"></i></span>
                        <asp:DropDownList ID="ddlHoraFin" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                </div>

                <div class="horarios-actions">
                    <asp:Button ID="btnAceptar" class="btn btn-primary" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" />
                    <asp:Button runat="server" ID="btnEliminarFisico" Text="Eliminar Horario" class="btn btn-secondary" OnClick="btnEliminarFisico_Click" />
                    <asp:Button runat="server" ID="btnActivar" Text="Activar Horario" class="btn btn-success" OnClick="btnActivar_Click" Visible="false" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="horarios-list-header">
                    <div class="horarios-list-icon">
                        <i class="bi bi-calendar2-check"></i>
                    </div>
                    <div>
                        <h2 class="h4 fw-bold mb-1">Horarios Registrados</h2>
                        <p class="text-muted small mb-0">Listado de horarios cargados en el sistema.</p>
                    </div>
                </div>

                <div class="horarios-filter-box">
                    <label class="form-label">Filtrar por Estado</label>
                    <asp:DropDownList ID="ddlEstadoTurnos" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoTurnos_SelectedIndexChanged">
                        <asp:ListItem Value="activos" Text="Activos" Selected="True"/>
                        <asp:ListItem Value="inactivos" Text="Inactivos"/>
                        <asp:ListItem Value="todos" Text="Todos"/>
                    </asp:DropDownList>
                </div>

                <div class="horarios-table-wrap">
                    <asp:GridView ID="dgvTurnos" runat="server" CssClass="table table-hover align-middle"
                        AutoGenerateColumns="false" OnSelectedIndexChanged="dgvTurnos_SelectedIndexChanged" DataKeyNames="Id">
                        <Columns>
                            <asp:BoundField HeaderText="Especialidad" DataField="EspecialidadNombre" />
                            <asp:BoundField HeaderText="Día" DataField="DiaNombre" />
                            <asp:BoundField HeaderText="Inicio" DataField="HoraInicio" />
                            <asp:BoundField HeaderText="Fin" DataField="HoraFin" />
                            <asp:BoundField HeaderText="Estado" DataField="Estado" />
                            <asp:CommandField ShowSelectButton="true" SelectText="Editar" ControlStyle-CssClass="btn btn-sm btn-outline-primary" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
