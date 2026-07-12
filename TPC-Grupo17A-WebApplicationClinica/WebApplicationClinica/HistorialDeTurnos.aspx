<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HistorialDeTurnos.aspx.cs" Inherits="WebApplicationClinica.HistorialDeTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
    <div class="mb-4 d-flex justify-content-between align-items-center bg-light p-3 rounded-3 shadow-sm">
        <div>
            <h2 class="mb-2 text-dark">Historial de turnos</h2>            
            <div class="align-items-center">
                <label class="form-label d-inline-block fw-semibold text-secondary mb-0">Paciente: </label>
                <asp:Label ID="lblNombrePaciente" runat="server" CssClass="fw-bold text-dark me-2" />                
                <label class="form-label d-inline-block text-muted mb-0"> - DNI: </label>
                <asp:Label ID="lblDniPaciente" runat="server" CssClass="fw-bold text-dark" />
            </div>
        </div>
        <a href="WebForm-Paciente.aspx" class="btn btn-outline-secondary shadow-sm">Volver</a>
    </div>

    <div class="row g-4">        
        <div class="col-12">
            <div class="card shadow-sm border-0 p-3 bg-white rounded-3">
                <asp:GridView ID="dgvTurnos" runat="server"
                    CssClass="table table-striped table-hover align-middle m-0"
                    DataKeyNames="Id"
                    AutoGenerateColumns="false"
                    OnRowCommand="dgvTurnos_RowCommand"
                    ShowHeaderWhenEmpty="true"
                    EmptyDataText="Sin turnos registrados.">
                    <Columns>
                        <asp:TemplateField HeaderText="Fecha">
                            <ItemTemplate>
                                <%# Eval("Fecha", "{0:dd/MM/yyyy}") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Horario">
                            <ItemTemplate>
                                <%# ((TimeSpan)Eval("HoraInicio")).ToString(@"hh\:mm") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Médico">
                            <ItemTemplate>
                                <%# Eval("Medico.Apellido") %>, <%# Eval("Medico.Nombre") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Especialidad" DataField="Especialidad.Nombre" />

                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnVerDetalle" runat="server" 
                                    CommandName="VerDetalle" 
                                    CommandArgument='<%# Eval("Id") %>' 
                                    CssClass="btn btn-sm btn-primary shadow-sm">
                                    Ver Detalle
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>


    </div>
</div>

</asp:Content>

