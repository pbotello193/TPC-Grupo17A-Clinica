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
    Descripcion VARCHAR(250) NOT NULL,
	Activo BIT NOT NULL
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
    Id INT IDENTITY(1000,1) PRIMARY KEY, 
    Fecha DATE NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    Observaciones VARCHAR(300) NOT NULL,
    Diagnostico VARCHAR(500) NULL,
    IdPaciente INT NOT NULL,
    IdMedico INT NOT NULL,
    IdEspecialidad INT NOT NULL,
    Estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente', 
    CONSTRAINT FK_Turno_Paciente FOREIGN KEY (IdPaciente) REFERENCES Pacientes(Id),
    CONSTRAINT FK_Turno_Medico FOREIGN KEY (IdMedico) REFERENCES Medicos(Id),
    CONSTRAINT FK_Turno_Especialidad FOREIGN KEY (IdEspecialidad) REFERENCES Especialidades(Id)
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

--Tablas login
CREATE TABLE Roles (
    Id INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    PaginaInicio VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Usuarios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Usuario VARCHAR(50) NOT NULL,
    Pass VARCHAR(50) NOT NULL,
    TipoUser INT NOT NULL,
    IdMedico INT NULL, --null porque solo se completa para medicos
    Activo BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_Usuarios_Usuario UNIQUE (Usuario),
    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (TipoUser) REFERENCES Roles(Id),
    CONSTRAINT FK_Usuarios_Medicos FOREIGN KEY (IdMedico) REFERENCES Medicos(Id)
);
GO


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

CREATE PROCEDURE spAsignarEspecialidad
    @IdMedico INT,
    @IdEspecialidad INT
AS
BEGIN
    IF NOT EXISTS ( --evita que agregue si ya esta asociado
        SELECT 1 
        FROM MedicoEspecialidad 
        WHERE IdMedico = @IdMedico AND IdEspecialidad = @IdEspecialidad
    )
    BEGIN
        INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) 
        VALUES (@IdMedico, @IdEspecialidad)
    END
END
GO


--Inserts para la tabla medicos

INSERT INTO Medicos (Nombre, Apellido, Matricula, Telefono, Email, Activo)
VALUES
    ('Carlos', 'Gomez', 'M-45892', '1134567890', 'carlos.gomez@clinica.com', 1),
    ('Maria Laura', 'Rodriguez', 'M-32145', '1165432109', 'maria.rodriguez@clinica.com', 1),
    ('Juan Pablo', 'Martinez', 'M-78563', '1198765432', 'juan.martinez@clinica.com', 1),
    ('Ana Ines', 'Fernandez', 'M-12457', '1122334455', 'ana.fernandez@clinica.com', 1),
    ('Jorge Luis', 'Lopez', 'M-96325', '1155667788', 'jorge.lopez@clinica.com', 1);
GO

--Inserts para especialidades

INSERT INTO Especialidades (Nombre, Descripcion, Activo)
VALUES ('Pediatria', 'Atencion medica integral para bebes, ninos y adolescentes.', 1);
INSERT INTO Especialidades (Nombre, Descripcion, Activo)
VALUES ('Cardiologia', 'Diagnostico y tratamiento de enfermedades del corazon y vasos sanguineos.', 1);
INSERT INTO Especialidades (Nombre, Descripcion, Activo)
VALUES ('Traumatologia', 'Prevencion, diagnostico y tratamiento de lesiones del sistema musculo-esqueletico.', 1);
INSERT INTO Especialidades (Nombre, Descripcion, Activo)
VALUES ('Dermatologia', 'Cuidado de la piel, pelo y unas, y tratamiento de sus enfermedades.', 0);
INSERT INTO Especialidades (Nombre, Descripcion, Activo)
VALUES ('Ginecologia', 'Atencion a la salud del sistema reproductor femenino.', 0);
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

-- Inserts para la tabla pacientes

INSERT INTO Pacientes (Nombre, Apellido, DNI, FechaNacimiento, Telefono, Email, Direccion, Activo)
VALUES
    ('Sofia', 'Pereyra', '30111222', '1983-04-12', '1150011001', 'sofia.pereyra@mail.com', 'Av. Rivadavia 1234', 1),
    ('Martin', 'Gomez', '32555777', '1986-09-25', '1150011002', 'martin.gomez@mail.com', 'San Martin 245', 1),
    ('Valentina', 'Suarez', '38444111', '1994-02-03', '1150011003', 'valentina.suarez@mail.com', 'Belgrano 890', 1),
    ('Diego', 'Ramirez', '27888999', '1979-11-18', '1150011004', 'diego.ramirez@mail.com', 'Mitre 456', 1),
    ('Camila', 'Gomez', '41777666', '1998-07-30', '1150011005', 'camila.gomez@mail.com', 'Lavalle 321', 0),
    ('Luciano', 'Molina', '29123456', '1981-01-09', '1150011006', 'luciano.molina@mail.com', 'Corrientes 1550', 0);
GO




--Inserts roles y usuarios
INSERT INTO Roles (Id, Nombre, PaginaInicio, Activo)
VALUES
    (1, 'Administrador', 'InicioAdministrador.aspx', 1),
    (2, 'Recepcionista', 'InicioRecepcionista.aspx', 1),
    (3, 'Medico', 'InicioMedico.aspx', 1);
GO

INSERT INTO Usuarios (Usuario, Pass, TipoUser, IdMedico, Activo)
VALUES
    ('admin', 'admin', 1, NULL, 1),
    ('recepcion', 'recepcion', 2, NULL, 1),
    ('medico', 'medico', 3, 1, 1);
GO