using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class TurnoDeTrabajo
    {
        public int Id { get; set; }
        public int IdMedico { get; set; }
        public DayOfWeek DiaDeLaSemana { get; set; }
        public TimeSpan HoraInicio { get; set; }
        public TimeSpan HoraFin { get; set; }
        public bool Activo { get; set; } = true;

        public void Validar()
        {
            if (HoraInicio >= HoraFin)
            {
                throw new Exception("La hora de inicio debe ser menor que la hora de fin.");
            }
            if (IdMedico <= 0)
            {
                throw new Exception("El turno debe estar asignado a un médico válido.");
            }
        }
    }
}
