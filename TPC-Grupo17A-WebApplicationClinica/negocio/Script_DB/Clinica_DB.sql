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
    Direccion VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL
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
    IdEspecialidad INT NOT NULL,
    DiaDeLaSemana INT NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_TurnoDeTrabajo_MedicoEspecialidad 
        FOREIGN KEY (IdMedico, IdEspecialidad) 
        REFERENCES MedicoEspecialidad(IdMedico, IdEspecialidad)
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

CREATE PROCEDURE SP_EliminarLogicoTurnoDeTrabajo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TurnosDeTrabajo
    SET Activo = 0
    WHERE Id = @Id;
END
GO

CREATE PROCEDURE SP_ActivarTurnoDeTrabajo
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TurnosDeTrabajo
    SET Activo = 1
    WHERE Id = @Id;
END
GO


--Inserts para la tabla medicos

INSERT INTO Medicos (Nombre, Apellido, Matricula, Telefono, Email, Activo)
VALUES 
    ('Carlos', 'G�mez', 'M-45892', '1134567890', 'carlos.gomez@clinica.com', 1),
    ('Mar�a Laura', 'Rodr�guez', 'M-32145', '1165432109', 'maria.rodriguez@clinica.com', 1),
    ('Juan Pablo', 'Mart�nez', 'M-78563', '1198765432', 'juan.martinez@clinica.com', 1),
    ('Ana In�s', 'Fern�ndez', 'M-12457', '1122334455', 'ana.fernandez@clinica.com', 1),
    ('Jorge Luis', 'L�pez', 'M-96325', '1155667788', 'jorge.lopez@clinica.com', 1);
GO

--Inserts para especialidades

INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Pediatr�a', 'Atenci�n m�dica integral para beb�s, ni�os y adolescentes.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Cardiolog�a', 'Diagn�stico y tratamiento de enfermedades del coraz�n y vasos sangu�neos.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Traumatolog�a', 'Prevenci�n, diagn�stico y tratamiento de lesiones del sistema m�sculo-esquel�tico.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Dermatolog�a', 'Cuidado de la piel, pelo y u�as, y tratamiento de sus enfermedades.');
INSERT INTO Especialidades (Nombre, Descripcion)
VALUES ('Ginecolog�a', 'Atenci�n a la salud del sistema reproductor femenino.');
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



