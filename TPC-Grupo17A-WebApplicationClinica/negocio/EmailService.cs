using dominio;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;


namespace negocio
{
    public class EmailService
    {
        private MailMessage email;
        private SmtpClient server;

        public EmailService()
        {//Aca configurar mailtrap
            server = new SmtpClient();
            server.Credentials = new NetworkCredential("ab6052b0fd58a8", "af3e409883c3c0");
            server.EnableSsl = true;
            server.Port = 2525;
            server.Host = "sandbox.smtp.mailtrap.io";
        }

        /*
        La idea es que reciba un objeto turno y use los datos para cargarlos en el template.
        Con este bloque de codigo se invoca todo al finalizar la carga y confirmacion:

            EmailService email = new EmailService();
            string rutaPlantilla = Server.MapPath("~/MailTurnoConfirmado.html"); //Esto tiene que estar en el front para que levante
            email.armarMailConfirmacion(turno,rutaPlantilla);
            email.enviarEmail();
        */

        public void armarMailConfirmacion(Turno turno, string ruta)
        {
            email = new MailMessage();

            email.From = new MailAddress("clinica@mailtrap.io");
            email.To.Add(turno.Paciente.Email);

            email.Subject = "Confirmación de turno";
            string cuerpo = File.ReadAllText(ruta);

            cuerpo = cuerpo.Replace("{{PACIENTE}}", turno.Paciente.Nombre + " " + turno.Paciente.Apellido);

            cuerpo = cuerpo.Replace("{{NUMERO}}", ""); //aca como 2do parametro recibe el numero de turno generado al asignar turno

            cuerpo = cuerpo.Replace("{{ESPECIALIDAD}}", turno.Especialidad.Nombre);

            cuerpo = cuerpo.Replace("{{MEDICO}}", turno.Medico.Nombre + " " + turno.Medico.Apellido);

            cuerpo = cuerpo.Replace("{{FECHA}}", turno.Fecha.ToString("dd/MM/yyyy"));

            cuerpo = cuerpo.Replace("{{HORA}}", turno.Fecha.ToString("HH:mm"));

            cuerpo = cuerpo.Replace("{{OBSERVACIONES}}", turno.Observaciones);

            email.IsBodyHtml = true;
            email.Body = cuerpo;
        }
        public void enviarEmail()
        {
            try
            {
                server.Send(email);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
