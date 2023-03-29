drop database if exists Tramo;

create database Tramo;

use Tramo;

create table if not exists
    Tbl_Conductores(
        idConductor int unsigned not null  auto_increment,
		nombreCON varchar(50) not null,
        apellidoCON varchar(50) not null,
        usuarioCON varchar(20) not null,
        tipo_DocumentoCON varchar(5) not null,
        nroDocumentoCON char(10) not null,
        nacionalidadCON varchar(20) not null,
        DireccionResidenciaCON varchar(100) not null,
        ciudadCON varchar(50) not null,
        fechaNacimientoCON date not null,
        nroTelefonoCON varchar(12) not null,
        correoElectronicoCON varchar(40) not null,
        correoRecuperacionCON varchar(40) not null,
        nroLicenciaCON char(12) not null,
        contrasenaCON text not null,
        preguntaSeguridadCON text not null,
        respuestaSeguridadCON text not null,
        
        calificacionCON float not null default(5),
        numeroViajesCON int unsigned default(0),
        
        idfotoperfilCON text,
        fotoperfilCON text,
		
        IngresoCON TINYINT DEFAULT 0 not null,
        habilitadoCON TINYINT DEFAULT 0 not null,
        estadoCON TINYINT DEFAULT 0 not null,
        disponibilidadCON TINYINT DEFAULT 0 not null,
        
        fechaIngresoCON datetime DEFAULT null,
        motivoRechazoCON text DEFAULT null,
        motivoInhabilitadoCON text DEFAULT null,

        constraint PK_idConductor primary key (idConductor)
    );


create table if not exists
    Tbl_ContactoEmergia(
        idContactoEmergencia int unsigned not null  auto_increment,
        nombreCEM varchar(50) not null,
        apellidoCEM varchar(50) not null,
        NroDocumentoCEM char(10) not null,
        NroTelefonoCEM char(10) not null,
        CorreoElectricoCEM varchar(40) not null,
        
        idConductorCEM int unsigned not null ,

        constraint PK_idContactoEmergencia primary key (idContactoEmergencia),
        
        constraint FK_idConductorCEM foreign key (idConductorCEM) references Tbl_Conductores (idConductor)
    );

create table if not exists
    Tbl_Vehiculo(
        idVehiculo int unsigned not null  auto_increment,
        marca varchar(50) not null,
        modelo varchar(30) not null,
        numeroEjes int not null,
        tipoVehiculo varchar(30) not null ,
        traccionVeh varchar(30),
        placaVehiculo char(7) not null,
        placasTrailer char(7) DEFAULT null,
        pesoVacio int not null,
        CombustibleVeh varchar(30) not null,
        numeroLicenciaVeh char(12) not null,
        numeroSOAT char(12) not null,
        fechavencSOAT date not null,
        nroPoliza_ResponCivil char(12) not null,
        nroRev_TecMecanica char(12) not null,
        fechaVenc_Tecno date not null,
        
        idConductorVeh int unsigned not null,
		
        constraint PK_idVehiculo primary key (idVehiculo),
        
        constraint FK_idConductorVeh foreign key (idConductorVeh) references Tbl_Conductores (idConductor)
    );
    
create table if not exists
    Tbl_FotoVehiculo(
        idFotosVehiculo int unsigned not null  auto_increment,
        idFotoFrontal text,
        FotoFrontal text,
        idFotoVolco text,
        FotoVolco text,
        idFotolateral_Izq text,
        Fotolateral_Izq text,
        idFotolateral_Der text,
        Fotolateral_Der text,
        idFotolateral_IzqTrailer text DEFAULT null,
        Fotolateral_IzqTrailer text DEFAULT null,
        idFotolateral_DerTrailertext text DEFAULT null,
        Fotolateral_DerTrailertext text DEFAULT null,
        idFotoVolco_Trailer text DEFAULT null,
        FotoVolco_Trailer text DEFAULT null,
        
        idVehiculoFotos int unsigned not null,

        constraint PK_idFotosVehiculo primary key (idFotosVehiculo),
        
        constraint FK_idVehiculoFotos foreign key (idVehiculoFotos) references Tbl_Vehiculo (idVehiculo)
    );
    
create table if not exists
    Tbl_DatosTenedor(
        idTenedor int unsigned not null  auto_increment,
        nombreTE varchar(50) not null,
        apellidoTE varchar(50) not null,
        NroDocumentoTE char(10) not null,
        DireccionResidenciaTE varchar(100) not null,
        ciudadTE varchar(30) not null,
        NroTelefonoTE char(10) not null,
        
        idVehiculoTE int unsigned not null,

        constraint PK_idTenedor primary key (idTenedor),
        
        constraint FK_idVehiculoTE foreign key (idVehiculoTE) references Tbl_Vehiculo (idVehiculo) 
    );

create table if not exists
    Tbl_DatosPropietario(
        idPropietario int unsigned not null  auto_increment,
        nombrePRO varchar(50) not null,
        apellidoPRO varchar(50) not null,
        NroDocumentoPRO char(10) not null,
        DireccionResidenciaPRO varchar(100) not null,
        ciudadPRO varchar(30) not null,
        NroTelefonoPRO char(10) not null,
        
        idVehiculoPRO int unsigned not null,

        constraint PK_idPropietario primary key (idPropietario),
        
        constraint FK_idVehiculoPRO foreign key (idVehiculoPRO) references Tbl_Vehiculo (idVehiculo) 
    );


    
create table if not exists
    Tbl_PersonaNatural(
        idPerNatural int unsigned not null  auto_increment,
        nombrePNA varchar(50) not null,
        apellidoPNA varchar(50) not null,
        tipoDocumentoPNA varchar(5) not null,
        nroDocumentoPNA char(10) not null,
        DireccionPNA varchar(100) not null,
        nroTelefonoPNA varchar(15) not null,
        correoElectronicoPNA varchar(40) not null,
        contrasenaPNA text not null,
        
        habilitadoPNA TINYINT(1) not null DEFAULT (1),
        motivoInhabilitadoPNA text DEFAULT null,
        calificacionPNA float DEFAULT(5),
        numeroPedidosPNA int unsigned DEFAULT (0),
        
        idfotoPerfilPNA text DEFAULT null,
        fotoPerfilPNA text DEFAULT null,
		
        constraint PK_idPerNatural primary key (idPerNatural)
    );

create table if not exists
    Tbl_PersonaJuridica(
        idPerJuridica int unsigned not null  auto_increment,
        nombreEmpresa varchar(60) not null,
        razonSocialEmpresa varchar(50) not null,
        nomRepresentanteLegal varchar(60) not null,
        NITempresa varchar(15) not null,
        DireccionEmpresa varchar(100) not null,
        nroTelefonoPJU varchar(15) not null,
        correoElectronicoPJU varchar(40) not null,
        contrasenaPJU text not null,
        
        habilitadoPJU TINYINT(1) not null DEFAULT(1),
        motivoInhabilitadoPJU text DEFAULT null,
        calificacionPJU float DEFAULT(5),
        numeroPedidosPJU int unsigned DEFAULT (0),
        
        idfotoPerfilPJU text DEFAULT null,
        fotoPerfilPNA text DEFAULT null,

        constraint PK_idPerJuridica primary key (idPerJuridica)
    );

create table if not exists
    Tbl_chatAyuda(
        idChat int unsigned not null  auto_increment,
        mensajes text not null,
        HoraChat time not null,
        FechaChat date not null,

        idPerJuridicaChat int unsigned DEFAULT null,
        idPerNaturalChat int unsigned DEFAULT null,
        idConductorChat int unsigned DEFAULT null,

        constraint PK_idChat primary key (idChat),

        constraint FK_idPerJuridicaChat foreign key (idPerJuridicaChat) references Tbl_PersonaJuridica (idPerJuridica),
        constraint FK_idPerNaturalChat foreign key (idPerNaturalChat) references Tbl_PersonaNatural (idPerNatural),
        constraint FK_idConductorChat foreign key (idConductorChat) references Tbl_Conductores (idConductor)
    );


create table if not exists
    Tbl_Pedido(
        idPedido int unsigned  not null  auto_increment,
        ubicacionCarga varchar(100) not null,
        ubicacionEntrega varchar(100) not null,

        tipoCargaPED varchar(50) not null ,
        productoPED text not null ,
        riesgoCargaPED varchar(20) not null ,
        cantidadCarga int not null,
        fragilidadPED varchar(20) not null,

        idfotoCarga int unsigned DEFAULT null,
        fotoCarga text DEFAULT null, 

        precioCarga int unsigned not null,
        medioPagoPED varchar(20) not null ,
        horaPED time not null,
        fechaPED date not null,
        numManifiestoPED int unsigned not null,
        
        comentario_PQRS_PED text DEFAULT null,
        calificacionConductorPED float not null,
        calificacionServicioPED float not null,
        

        idPerNaturalPED int unsigned DEFAULT null,
        idPerJuridicaPED int unsigned DEFAULT null,
        idConductorPED int unsigned not null,

        constraint PK_idPedido primary key (idPedido),

        constraint FK_idPerNaturalPed foreign key (idPerNaturalPed) references Tbl_PersonaNatural (idPerNatural),
        constraint FK_idPerJuridicaPed foreign key (idPerJuridicaPed) references Tbl_PersonaJuridica (idPerJuridica),
        constraint FK_idConductorPED foreign key (idConductorPED) references Tbl_Conductores (idConductor)
    );


create table if not exists
    Tbl_Administradores(
        idAdministradores int unsigned not null  auto_increment,
        Usuario varchar(30) not null,
        correoAdmin varchar(40) not null,
        Contrasena text not null,

        constraint PK_idAdministradores primary key (idAdministradores)
    );