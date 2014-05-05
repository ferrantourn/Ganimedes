use master
GO

--CHEQUEAMOS SI LA BASE DE DATOS EXISTE
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'SocialNetwork')
ALTER DATABASE SocialNetwork SET SINGLE_USER WITH ROLLBACK IMMEDIATE
-- LA LINEA ANTERIOR ELIMINA TODAS LAS CONEXIONES EXISTENTES A LA BASE DE DATOS PARA PODER DROPEARLA
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'SocialNetwork')
DROP DATABASE [SocialNetwork] /* ELIMINAMOS LA BASE DE DATOS */
GO


create database SocialNetwork
GO

use SocialNetwork
GO

--USUARIO
-----------------------------
CREATE TABLE [dbo].[Usuario](
	[NombreUsuario] [nvarchar](25) primary key NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Documento] [nvarchar](8) NULL,
	[Administrador] [bit] NOT NULL,
	[FechaNacimiento] [date] NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Apellido] [nvarchar](50) NULL,
	[NombrePublico] [nvarchar](50) NOT NULL
	)
	
GO

--MENSAJE
-----------------------------
CREATE TABLE [dbo].[Mensaje](
	[IdMensaje] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[FechaHoraCreado] [datetime] NOT NULL,
	[Texto] [nvarchar](256) NOT NULL,
	[NombreUsuario] [nvarchar](25) NOT NULL,
	FOREIGN KEY([NombreUsuario]) REFERENCES [dbo].[Usuario] ([NombreUsuario])
 )
 
 GO
 
 --AMISTAD
 -----------------------------
 CREATE TABLE [dbo].[Amistad](
	[NombreUsuario1] [nvarchar](25) NOT NULL,
	[NombreUsuario2] [nvarchar](25) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	primary key ([NombreUsuario1], [NombreUsuario2]),
	FOREIGN KEY([NombreUsuario1]) REFERENCES [dbo].[Usuario] ([NombreUsuario]),
	FOREIGN KEY([NombreUsuario2]) REFERENCES [dbo].[Usuario] ([NombreUsuario])
	)
 
GO

--EVENTO
-----------------------------
CREATE TABLE [dbo].[Evento](
	[IdEvento] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [nvarchar](25) NOT NULL,
	[Nombre] [nvarchar](50) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
	[FechaHoraEvento] [datetime] NOT NULL,
	[Aprobado] [bit] NOT NULL,
	FOREIGN KEY([NombreUsuario]) REFERENCES [dbo].[Usuario] ([NombreUsuario])
 )
 
 GO
 
 --COMENTARIO
 -----------------------------
 CREATE TABLE [dbo].[Comentario](
	[IdMensaje] [int] NOT NULL,
	[IdComentario] [int] NOT NULL,
	[NombreUsuario] [nvarchar](25) NOT NULL,
	[FechaHoraCreado] [datetime] NOT NULL,
	[Texto] [nvarchar](100) NOT NULL,
	primary key ([IdMensaje], [IdComentario]),
	FOREIGN KEY([IdMensaje]) REFERENCES [dbo].[Mensaje] ([IdMensaje]),
	FOREIGN KEY([NombreUsuario]) REFERENCES [dbo].[Usuario] ([NombreUsuario])
 )
 
GO

--INSCRIPCION EVENTO
-----------------------------
CREATE TABLE [dbo].[InscripcionEvento](
	[IdEvento] [int] NOT NULL,
	[NombreUsuario] [nvarchar](25) NOT NULL,
	primary key ([IdEvento], [NombreUsuario]),
	FOREIGN KEY([IdEvento]) REFERENCES [dbo].[Evento] ([IdEvento]),
	FOREIGN KEY([NombreUsuario]) REFERENCES [dbo].[Usuario] ([NombreUsuario])
 )
GO