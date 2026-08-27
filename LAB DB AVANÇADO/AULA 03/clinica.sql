create table medico
(
    id_med   int primary key,
    nome_med    text not null, 
    tel_med     numeric(11),
    espec_med   varchar (50) check (espec_med = "pediatra" or espec_med = "geriatra")
); 

create table paciente
(
    id_pac      int primary key
    nome_pac    varchar(50) not null
    tel_pac     numeric(11)
    cpf_pac     numeric(11) not null unique
);
 create table consulta
 (
    id_con      int primary key,
    dt_con      date not null,
    hor_con     time not null,
    id_pac      int references pacientes (id_pac) on delete cascade on update cascade,    
    id_med      int references medicos (id_med) on delete cascade on update cascade, 
    valor_con   numeric (7,2),
    pagamento_con varchar (20)
 );

insert into medicos values(1,'francisco',119999999,'pediatra'), (2,'juliano',119999999,'geriatra');

insert into paciente values(100, 'pep1', 119993929,42423653243), (200,'rob', 190934929,41284219);

insert into consultas value(1000, '10-09-2026','00:03:00', (select id_pac from paciente where nome_pac = 'pep'),(select id_med from medicos where nome_med = 'francisco'));

insert into consultas values(2000, '12-09-2026','00:09:20', (select id_pac from paciente where nome_pac = 'rob'),(select id_med from medicos where nome_med = 'juliano'));


create view v_agenda AS
select c.*, m_nome_med
from medicos m, consultas c 
where m.id_med = c.id.med and m.nome_med = 'francisco';

select * from v_agenda;