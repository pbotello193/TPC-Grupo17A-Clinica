<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioTurnoDeTrabajo.aspx.cs" Inherits="WebApplicationClinica.FormularioTurnoDeTrabajo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
    <h2 class="mb-4">Horarios de Trabajo del Médico</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block" Visible="false"></asp:Label>

        <div class="row">
            <!-- Columna del Formulario (Carga y Edición) -->
            <div class="col-md-6">
                <div class="mb-3">
                    <label class="form-label">Médico</label>
                    <asp:DropDownList ID="ddlMedico" runat="server" CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlMedico_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="mb-3">
                    <label class="form-label">Especialidad</label>
                    <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select"
                        EnableViewState="false">
                    </asp:DropDownList>
                </div>


                <div class="mb-3">
                    <label class="form-label">Id Horario</label>
                    <asp:TextBox runat="server" ID="txtId" CssClass="form-control" Enabled="false" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Día de la semana</label>
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

                <div class="mb-3">
                    <label class="form-label">Hora Inicio</label>
                    <asp:TextBox runat="server" ID="txtHoraInicio" CssClass="form-control" TextMode="Time" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Hora Fin</label>
                    <asp:TextBox runat="server" ID="txtHoraFin" CssClass="form-control" TextMode="Time" />
                </div>

                <div class="mb-3">
                    <asp:Button ID="btnAceptar" class="btn btn-primary" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" />
                    <asp:Button runat="server" ID="btnEliminarFisico" Text="Eliminar Horario" class="btn btn-secondary" OnClick="btnEliminarFisico_Click" />
                    <asp:Button runat="server" ID="btnActivar" Text="Activar Horario" class="btn btn-success" OnClick="btnActivar_Click" Visible="false" />
                </div>
            </div>

            <!-- Columna del Listado (GridView) -->
            <div class="col-md-6">
                <h4>Horarios Registrados</h4>
                <div class="mb-3">
                    <label class="form-label">Filtrar por Estado</label>
                    <asp:DropDownList ID="ddlEstadoTurnos" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoTurnos_SelectedIndexChanged">
                        <asp:ListItem Value="activos" Text="Activos" Selected="True"/>
                        <asp:ListItem Value="inactivos" Text="Inactivos"/>
                        <asp:ListItem Value="todos" Text="Todos"/>
                    </asp:DropDownList>
                </div>
                <asp:GridView ID="dgvTurnos" runat="server" CssClass="table table-striped table-hover"
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
</asp:Content>
