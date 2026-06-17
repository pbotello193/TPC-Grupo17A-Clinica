CREATE DATABASE Clinica_DB;
GO

USE Clinica_DB;
GO

CREATE TABLE Pacientes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI VARCHAR(20) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100) NOT NULL
);
GO



CREATE TABLE Medicos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Matricula VARCHAR(50) NOT NULL,
    Telefono VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL,
	Activo BIT NOT NULL
);
GO

CREATE TABLE Especialidades (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(250) NOT NULL
);

GO
CREATE TABLE MedicoEspecialidad (
    IdMedico INT NOT NULL,
    IdEspecialidad INT NOT NULL,

    CONSTRAINT PK_MedicoEspecialidad
        PRIMARY KEY (IdMedico, IdEspecialidad),

    CONSTRAINT FK_MedicoEspecialidad_Medicos
        FOREIGN KEY (IdMedico)
        REFERENCES Medicos(Id),

    CONSTRAINT FK_MedicoEspecialidad_Especialidades
        FOREIGN KEY (IdEspecialidad)
        REFERENCES Especialidades(Id)
);

CREATE TABLE Turnos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FechaHora DATETIME NOT NULL,
    Observaciones VARCHAR(200) NOT NULL,
    IdPaciente INT NOT NULL,
    IdMedico INT NOT NULL,
    CONSTRAINT FK_Turno_Paciente FOREIGN KEY (IdPaciente) REFERENCES Pacientes(Id),
    CONSTRAINT FK_Turno_Medico FOREIGN KEY (IdMedico) REFERENCES Medicos(Id)
);
GO

CREATE TABLE TurnosDeTrabajo (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdMedico INT NOT NULL,
    DiaDeLaSemana INT NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    CONSTRAINT FK_TurnoDeTrabajo_Medico FOREIGN KEY (IdMedico) REFERENCES Medicos(Id)
);
GO


CREATE PROCEDURE SP_EliminarMedicoFisico
    @IdMedico INT
AS
BEGIN
    BEGIN TRANSACTION    
    BEGIN TRY
	--ELIMINAR PRIMERO LA REALACION EN LA TABLA INTERMEDIA SINO SE ROMPE!!
        DELETE FROM MedicoEspecialidad 
        WHERE IdMedico = @IdMedico
        DELETE FROM Medicos --
        WHERE Id = @IdMedico

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW;
    END CATCH
END

--Inserts para la tabla medicos

INSERT INTO Medicos (Nombre, Apellido, Matricula, Telefono, Email, Activo)
VALUES 
    ('Carlos', 'Gómez', 'M-45892', '1134567890', 'carlos.gomez@clinica.com', 1),
    ('María Laura', 'Rodríguez', 'M-32145', '1165432109', 'maria.rodriguez@clinica.com', 1),
    ('Juan Pablo', 'Martínez', 'M-78563', '1198765432', 'juan.martinez@clinica.com', 1),
    ('Ana Inés', 'Fernández', 'M-12457', '1122334455', 'ana.fernandez@clinica.com', 1),
    ('Jorge Luis', 'López', 'M-96325', '1155667788', 'jorge.lopez@clinica.com', 1);
GO

--Inserts para especialidades

INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Pediatría', 'Atención médica integral para bebés, niños y adolescentes.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Cardiología', 'Diagnóstico y tratamiento de enfermedades del corazón y vasos sanguíneos.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Traumatología', 'Prevención, diagnóstico y tratamiento de lesiones del sistema músculo-esquelético.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Dermatología', 'Cuidado de la piel, pelo y uñas, y tratamiento de sus enfermedades.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Ginecología', 'Atención a la salud del sistema reproductor femenino.');
GO

--Inserts para MedicoEspecialidad

INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (1, 1);
INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (2, 2);
INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (2, 5);
INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (3, 3);
INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (4, 4);
INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (5, 1);
INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (5, 3);
GO



