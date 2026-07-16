using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Turno
    {
        public int Id { get; set; }
        public DateTime Fecha { get; set; }
        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }
        public string Observaciones { get; set; }
        public string Diagnostico { get; set; }
        public Paciente Paciente { get; set; }
        public Medico Medico { get; set; }
        public Especialidad Especialidad { get; set; }
        public string Estado { get; set; }
        public Usuario UsuarioAsignacion { get; set; }
        public DateTime FechaAsignacion { get; set; }
        public string Indicaciones { get; set; }
        public string Receta { get; set; }
        public string EstudiosSolicitados { get; set; }
        public string SignosVitales { get; set; }

    }
}
