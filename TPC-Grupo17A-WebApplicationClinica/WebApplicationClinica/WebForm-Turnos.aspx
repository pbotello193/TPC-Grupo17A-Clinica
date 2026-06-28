<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Turnos.aspx.cs" Inherits="WebApplicationClinica.WebForm_Turno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4">Turnos Médicos</h2>

        <div class="card shadow-sm border-0 bg-light mb-4">
            <div class="card-body p-4">
                <h5 class="card-title mb-3">
                    <i class="bi bi-search me-2"></i>Buscar turno
                </h5>

                <div class="row g-3 align-items-end">
                    <div class="col-md-6">
                        <label for="txtBuscarPaciente" class="form-label">Buscar paciente</label>
                        <asp:TextBox ID="txtBuscarPaciente" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscarPaciente_TextChanged"
                            placeholder="nombre, apellido o DNI del paciente" />
                    </div>

                    <div class="col-md-6">
                        <label for="ddlEspecialidad" class="form-label">Especialidad</label>
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" />
                    </div>
                </div>

                <asp:HiddenField ID="hfIdPaciente" runat="server" />

                <asp:Label ID="lblPacienteSeleccionado" runat="server"
                    CssClass="alert alert-info d-block mt-3 mb-0"
                    Visible="false" />

                <asp:GridView ID="dgvPacientesEncontrados" runat="server"
                    CssClass="table table-sm table-hover align-middle mt-3 mb-0"
                    AutoGenerateColumns="false"
                    DataKeyNames="Id"
                    Visible="false"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="No se encontraron pacientes activos."
                    OnSelectedIndexChanged="dgvPacientesEncontrados_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                        <asp:BoundField HeaderText="DNI" DataField="Dni" />
                        <asp:CommandField ShowSelectButton="true" SelectText="Seleccionar" ControlStyle-CssClass="btn btn-sm btn-outline-dark" />
                    </Columns>
                </asp:GridView>

                <div class="text-end mt-3">
                    <asp:Button ID="btnBuscarHorarios" runat="server"
                        Text="Buscar horarios disponibles"
                        CssClass="btn btn-dark"
                        OnClick="btnBuscarHorarios_Click" />
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 bg-light">
            <div class="card-body p-4">
                <h5 class="card-title mb-3">Horarios y médicos disponibles</h5>

                <asp:GridView ID="dgvHorariosDisponibles" runat="server"
                    CssClass="table table-hover align-middle mb-0"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="Seleccione un paciente y una especialidad para buscar horarios disponibles."
                    OnSelectedIndexChanged="dgvHorariosDisponibles_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField HeaderText="Médico" DataField="Medico" />
                        <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                        <asp:BoundField HeaderText="Horario" DataField="Horario" />
                        <asp:CommandField ShowSelectButton="true" SelectText="Asignar turno" ControlStyle-CssClass="btn btn-sm btn-success" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
