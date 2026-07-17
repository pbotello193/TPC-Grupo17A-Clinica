<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Turnos.aspx.cs" Inherits="WebApplicationClinica.WebForm_Turno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="turnos-page">
        <div class="turnos-header">
            <div class="turnos-header-icon">
                <i class="bi bi-calendar-plus"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Turnos Médicos</h1>
                <p class="text-muted fs-6 mb-0">Busque disponibilidad y reserve un turno médico.</p>
            </div>
        </div>

        <div class="turnos-card">
            <h2 class="h4 turnos-card-title">
                <i class="bi bi-search"></i>Buscar turno
            </h2>

            <div class="row g-4 align-items-end">
                <div class="col-md-6">
                    <label for="txtBuscarPaciente" class="form-label">Buscar paciente</label>
                    <div class="input-icon-wrap">
                        <i class="bi bi-person"></i>
                        <asp:TextBox ID="txtBuscarPaciente" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscarPaciente_TextChanged"
                            placeholder="Nombre, apellido o DNI del paciente" />
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="ddlEspecialidad" class="form-label">Especialidad</label>
                    <div class="input-icon-wrap">
                        <i class="bi bi-stethoscope"></i>
                        <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" />
                    </div>
                </div>
            </div>

            <div class="mt-4">
                <label for="txtObservaciones" class="form-label">Motivo de consulta / Observaciones</label>
                <div class="input-icon-wrap textarea-icon">
                    <i class="bi bi-chat-left"></i>
                    <asp:TextBox ID="txtObservaciones" runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="3"
                        placeholder="Ej: El paciente trae estudios previos, control post-quirúrgico, etc..." />
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
        </div>

        <asp:UpdatePanel ID="upTurnos" runat="server">
            <ContentTemplate>
                <div class="turnos-card">
                    <div class="d-flex justify-content-between align-items-center gap-3 mb-4 flex-wrap">
                        <h2 class="h4 fw-bold mb-0">Horarios y médicos disponibles</h2>
                        <asp:Button ID="btnBuscarTurnos" runat="server"
                            Text="Buscar horarios disponibles"
                            CssClass="btn btn-primary btn-buscar-turnos"
                            OnClick="btnBuscarTurnos_Click" />
                    </div>

                    <asp:Label ID="lblMensajeError" runat="server" CssClass="alert alert-danger d-block turnos-error" Visible="false" />

                    <div class="row g-4">
                        <div class="col-lg-4 col-md-5">
                            <div class="calendar-card">
                                <asp:Calendar ID="calTurnos" runat="server"
                                    OnSelectionChanged="calTurnos_SelectionChanged"
                                    Width="100%"
                                    BorderWidth="0px"
                                    NextPrevFormat="CustomText"
                                    PrevMonthText="<i class='bi bi-chevron-left'></i>"
                                    NextMonthText="<i class='bi bi-chevron-right'></i>"
                                    Font-Names="Segoe UI, Helvetica, Arial, sans-serif"
                                    Height="280px"
                                    CssClass="turnos-calendar table table-sm table-borderless text-center align-middle mb-0"
                                    OnDayRender="calTurnos_DayRender">
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

                        <div class="col-lg-8 col-md-7">
                            <div class="horarios-card h-100">
                                <div class="horarios-card-header">
                                    <i class="bi bi-clock"></i>Horarios disponibles
                                </div>
                                <div class="table-responsive p-3 pt-2">
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
