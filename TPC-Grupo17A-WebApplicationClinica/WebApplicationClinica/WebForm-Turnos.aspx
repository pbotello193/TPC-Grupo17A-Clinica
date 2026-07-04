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


                <div class="mb-3">
                    <label for="txtObservaciones" class="form-label">Motivo de consulta / Observaciones)</label>
                    <asp:TextBox ID="txtObservaciones" runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="2"
                        placeholder="Ej: El paciente trae estudios previos, control post-quirúrgico, etc..." />
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
            </div>
        </div>

        <asp:UpdatePanel ID="upTurnos" runat="server">
            <ContentTemplate>
                <div class="card shadow-sm border-0 bg-light">
                    <div class="card-body p-4">
                        <%--boton para buscar y que dibuje el calendario--%>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title mb-0">Horarios y médicos disponibles</h5>
                            <asp:Button ID="btnBuscarTurnos" runat="server"
                                Text="🔍 Buscar Días Disponibles"
                                CssClass="btn btn-primary btn-sm fw-bold px-3 shadow-sm"
                                OnClick="btnBuscarTurnos_Click" />
                        </div>

                        <asp:Label ID="lblMensajeError" runat="server" ForeColor="Red" Font-Bold="true" Visible="false" />

                        <div class="row g-4 mt-2">
                            <div class="col-lg-4 col-md-5">
                                <div class="card shadow-sm border-0 bg-white">
                                    <div class="card-body p-3">
                                        <asp:Calendar ID="calTurnos" runat="server"
                                            OnSelectionChanged="calTurnos_SelectionChanged"
                                            Width="100%"
                                            BorderWidth="0px"
                                            NextPrevFormat="CustomText"
                                            PrevMonthText="<i class='bi bi-chevron-left'></i>"
                                            NextMonthText="<i class='bi bi-chevron-right'></i>"
                                            Font-Names="Segoe UI, Helvetica, Arial, sans-serif"
                                            Height="280px"
                                            CssClass="table table-sm table-borderless text-center align-middle mb-0">
                                            <TitleStyle CssClass="bg-primary text-white fw-bold p-2 rounded-top text-decoration-none" ForeColor="White" BackColor="#0d6efd" />
                                            <NextPrevStyle CssClass="text-white text-decoration-none fw-bold px-2" ForeColor="White" />
                                            <DayHeaderStyle CssClass="text-muted small fw-bold border-bottom py-2" BackColor="White" />
                                            <DayStyle CssClass="p-2 border border-light text-dark rounded-3 cursor-pointer" />
                                            <SelectedDayStyle CssClass="bg-success text-white fw-bold rounded-3" BackColor="#198754" ForeColor="White" />
                                            <TodayDayStyle CssClass="bg-warning-subtle text-warning-emphasis fw-bold rounded-3" />
                                            <OtherMonthDayStyle CssClass="text-black-51 text-opacity-25 bg-light rounded-3" ForeColor="#cccccc" />
                                            <WeekendDayStyle CssClass="bg-light-subtle text-muted rounded-3" />
                                        </asp:Calendar>
                                    </div>
                                </div>
                            </div>

                            <%-- dgv a la derecha del calendario --%>
                            <div class="col-lg-8 col-md-7">
                                <div class="card shadow-sm border-0 bg-white h-100">
                                    <div class="card-body p-4">
                                        <h5 class="card-title mb-3 text-secondary fs-6 fw-bold"><i class="bi bi-clock me-2"></i>Horarios disponibles</h5>
                                        <div class="table-responsive">
                                            <asp:GridView ID="dgvHorariosDisponibles" runat="server"
                                                CssClass="table table-hover align-middle mb-0"
                                                AutoGenerateColumns="false"
                                                ShowHeaderWhenEmpty="true"
                                                EmptyDataText="No hay horarios disponibles"
                                                OnSelectedIndexChanged="dgvHorariosDisponibles_SelectedIndexChanged">
                                                <Columns>
                                                    <asp:BoundField HeaderText="Médico" DataField="Medico" />
                                                    <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                                                    <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                                                    <asp:BoundField HeaderText="Horario" DataField="Horario" />
                                                    <asp:CommandField ShowSelectButton="true" SelectText="Asignar turno" ControlStyle-CssClass="btn btn-sm btn-success fw-bold px-3" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>


