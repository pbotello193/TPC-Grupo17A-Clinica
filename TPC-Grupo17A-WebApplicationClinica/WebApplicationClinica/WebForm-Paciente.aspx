<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm-Paciente.aspx.cs" Inherits="WebApplicationClinica.WebForm_Paciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="mb-3">
            <h2 class="mb-4">Pacientes</h2>

            <div class="d-flex gap-2 align-items-center">
                <asp:DropDownList ID="ddlEstadoPacientes" runat="server" CssClass="form-select w-auto" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoPacientes_SelectedIndexChanged">
                    <asp:ListItem Text="Activos" Value="activos" />
                    <asp:ListItem Text="Inactivos" Value="inactivos" />
                    <asp:ListItem Text="Todos" Value="todos" />
                </asp:DropDownList>

                <%--busca pacientes dentro de la lista seleccionada (activos-inactivos-todos) --%>
                <asp:TextBox ID="txtBuscar" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnTextChanged="txtBuscar_TextChanged"
                    placeholder="Buscar por apellido, nombre o DNI" />
            </div>
        </div>

        <div class="mb-3">
            <asp:GridView ID="dgvPacientes" runat="server"
                CssClass="table table-striped table-hover align-middle"
                DataKeyNames="Id"
                AutoGenerateColumns="false"
                OnRowCommand="dgvPacientes_RowCommand"
                ShowHeaderWhenEmpty="true"
                EmptyDataText="No se encontraron pacientes.">
                <Columns>
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="DNI" DataField="Dni" />
                    <asp:BoundField HeaderText="Fecha de nacimiento" DataField="FechaNacimiento" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField HeaderText="Teléfono" DataField="Telefono" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Dirección" DataField="Direccion" />

                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <%--muestra si el paciente esta activo o inactivo --%>
                            <span class='<%# (bool)Eval("Activo") ? "badge bg-success" : "badge bg-secondary" %>'>
                                <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnHistorial" runat="server" CommandName="VerHistorial" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary">
                                Historial de turnos
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnHistorialClinico" runat="server" CommandName="VerHistorialClinico" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-info text-dark fw-semibold">
                                Ficha Médica
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm btn-outline-primary">
                                Editar
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <div class="mb-3">
            <a href="FormularioPaciente.aspx" class="btn btn-primary">Agregar</a>
        </div>
                <!-- Panel de Historial Clínico Oculto -->
        <asp:Panel ID="pnlHistorialClinico" runat="server" Visible="false" CssClass="mt-5 mb-5">
            <div class="card shadow-sm border-0 bg-white rounded-3">
                <div class="card-header bg-info text-white py-2 d-flex justify-content-between align-items-center">
                    <span class="fw-bold fs-5"><i class="bi bi-journal-medical me-2"></i>Historial Clínico: <asp:Label ID="lblNombrePacienteHistorial" runat="server"></asp:Label></span>
                    <asp:Button ID="btnCerrarHistorial" runat="server" Text="Cerrar" CssClass="btn btn-sm btn-light fw-bold text-secondary" OnClick="btnCerrarHistorial_Click" />
                </div>
                <div class="card-body p-4">
                    <asp:Repeater ID="rptHistorialClinico" runat="server">
                        <HeaderTemplate>
                            <div class="accordion" id="accordionHistorial">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="accordion-item mb-2 border rounded">
                                <h2 class="accordion-header" id='heading<%# Eval("Id") %>'>
                                    <button class="accordion-button collapsed bg-light" type="button" data-bs-toggle="collapse" data-bs-target='#collapse<%# Eval("Id") %>' aria-expanded="false" aria-controls='collapse<%# Eval("Id") %>'>
                                        <div class="d-flex w-100 justify-content-between me-3 text-secondary">
                                            <span><i class="bi bi-calendar-event me-1"></i><strong><%# Convert.ToDateTime(Eval("Fecha")).ToString("dd/MM/yyyy") %></strong></span>
                                            <span><strong>Esp:</strong> <%# Eval("Especialidad.Nombre") %></span>
                                            <span><strong>Médico:</strong> <%# Eval("Medico.Apellido") %>, <%# Eval("Medico.Nombre") %></span>
                                        </div>
                                    </button>
                                </h2>
                                <div id='collapse<%# Eval("Id") %>' class="accordion-collapse collapse" aria-labelledby='heading<%# Eval("Id") %>' data-bs-parent="#accordionHistorial">
                                    <div class="accordion-body bg-white">
                                        <div class="row g-3">
                                            <%# !string.IsNullOrEmpty(Eval("SignosVitales") as string) ? "<div class='col-12'><span class='badge bg-light text-dark border'><strong>Signos Vitales:</strong> " + Eval("SignosVitales") + "</span></div>" : "" %>
                                            
                                            <div class="col-md-6">
                                                <h6 class="fw-bold text-primary mb-1">Diagnóstico:</h6>
                                                <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("Diagnostico") as string) ? "<em>Sin registro</em>" : Eval("Diagnostico") %></p>
                                            </div>
                                            <div class="col-md-6">
                                                <h6 class="fw-bold text-secondary mb-1">Indicaciones:</h6>
                                                <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("Indicaciones") as string) ? "<em>Sin registro</em>" : Eval("Indicaciones") %></p>
                                            </div>
                                            <div class="col-md-6">
                                                <h6 class="fw-bold text-success mb-1">Receta / Prescripción:</h6>
                                                <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("Receta") as string) ? "<em>Sin registro</em>" : Eval("Receta") %></p>
                                            </div>
                                            <div class="col-md-6">
                                                <h6 class="fw-bold text-warning mb-1">Estudios Solicitados:</h6>
                                                <p class="mb-0 text-dark small"><%# string.IsNullOrEmpty(Eval("EstudiosSolicitados") as string) ? "<em>Sin registro</em>" : Eval("EstudiosSolicitados") %></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            </div>
                        </FooterTemplate>
                    </asp:Repeater>
                    
                    <asp:Label ID="lblSinHistorial" runat="server" CssClass="text-muted fw-semibold" Visible="false">
                        <i class="bi bi-info-circle me-1"></i> El paciente no posee atenciones médicas previas.
                    </asp:Label>
                </div>
            </div>
        </asp:Panel>

    </div>
</asp:Content>
