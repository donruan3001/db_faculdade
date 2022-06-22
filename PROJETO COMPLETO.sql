CREATE DATABASE IF NOT EXISTS db_faculdade
DEFAULT CHARACTER SET utf8mb3
DEFAULT COLLATE utf8_general_ci;
USE db_faculdade;
CREATE TABLE IF NOT EXISTS departamento(
	cod_departamento INT (4) PRIMARY KEY AUTO_INCREMENT  NOT NULL,
    nome_departamento CHAR (20) );
    
CREATE TABLE IF NOT EXISTS professor(
	cod_professor INT (4) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_professor CHAR (20) ,
    sobrenome_professor CHAR(50),
    status BOOLEAN,
	fk_cod_departamento INT(4),
    FOREIGN KEY (fk_cod_departamento )REFERENCES departamento (cod_departamento))
    ;
    CREATE TABLE IF NOT EXISTS  curso(
	cod_curso INT (4)  AUTO_INCREMENT NOT NULL,
    nome_curso CHAR (20),
    fk_cod_departamento INT(4),
    PRIMARY KEY (cod_curso),
    FOREIGN KEY (fk_cod_departamento )REFERENCES departamento (cod_departamento));

CREATE TABLE IF NOT EXISTS turma(
	cod_turma INT(4) PRIMARY KEY AUTO_INCREMENT NOT NULL,
	periodo CHAR(8),
	num_aluno INT(4),
	dt_inicio DATE,
	dt_final DATE,
    fk_cod_curso INTEGER(4),
FOREIGN KEY (fk_cod_curso) REFERENCES curso (cod_curso)
);    

CREATE TABLE IF NOT EXISTS tipo_logradouro(
	cod_tipo_logradouro INT(4) PRIMARY KEY AUTO_INCREMENT,
    tipo_logradouro CHAR(20)
);

CREATE TABLE IF NOT EXISTS tipo_telefone(
	cod_tipo INT (4)PRIMARY KEY AUTO_INCREMENT,
    tipo_telefone CHAR(8) 
);

CREATE TABLE IF NOT EXISTS telefone(
	cod_telefone INT(4) AUTO_INCREMENT,
    num_telefone CHAR (20),
    fk_cod_tipo INT (4),
    PRIMARY KEY ( cod_telefone),
    FOREIGN KEY ( fk_cod_tipo) REFERENCES tipo_telefone (cod_tipo));
    
CREATE TABLE IF NOT EXISTS endereço(
	cod_endereço INT (4) AUTO_INCREMENT NOT NULL,
    nome_rua CHAR (50),
    numero_rua INT (4),
    complemento CHAR (20),
    CEP CHAR(8),
    fk_cod_tipo_logradouro INT (4),
    PRIMARY KEY (cod_endereço),
    FOREIGN KEY (fk_cod_tipo_logradouro)REFERENCES tipo_logradouro(cod_tipo_logradouro));

CREATE TABLE IF NOT EXISTS  curso(
	cod_curso INT (4)  AUTO_INCREMENT NOT NULL,
    nome_curso CHAR (20),
    fk_cod_departamento INT(4),
    PRIMARY KEY (cod_curso),
    FOREIGN KEY (fk_cod_departamento )REFERENCES departamento (cod_departamento));
        
CREATE TABLE IF NOT EXISTS  disciplina(
	cod_disciplina INT(4) AUTO_INCREMENT NOT NULL,
    nome_disciplina CHAR (20),
    carga_horario INT (4),
    descrição CHAR (50),
	num_alunos INT(4),
    fk_cod_departamento INT(4),
    PRIMARY KEY (cod_disciplina),
	FOREIGN KEY (fk_cod_departamento) REFERENCES departamento(cod_departamento));
        
CREATE TABLE IF NOT EXISTS curso_disciplina(
		fk_cod_curso INT (4)  NOT NULL,
        fk_cod_disciplina INT(4)  NOT NULL,
        PRIMARY KEY(fk_cod_curso,fk_cod_disciplina),
        FOREIGN KEY(fk_cod_curso) REFERENCES curso (cod_curso),
        FOREIGN KEY(fk_cod_disciplina)REFERENCES disciplina (cod_disciplina));

CREATE TABLE IF NOT EXISTS  aluno(
	RA INT (4)  AUTO_INCREMENT PRIMARY KEY NOT NULL,
	nome_aluno CHAR (20),
    sobrenome_aluno CHAR (20),
    CPF CHAR (11),
    status BOOLEAN,
    sexo CHAR (11),
    nome_pai CHAR (50),
    nome_mae CHAR (50),
    email  CHAR(50),
    whatsapp CHAR (20),
    fk_cod_endereço INT(4),
    fk_cod_turma INT (4),
    fk_cod_curso INT (4),
     FOREIGN KEY(fk_cod_endereço)REFERENCES endereço(cod_endereço),
      FOREIGN KEY( fk_cod_turma)REFERENCES turma (cod_turma),
       FOREIGN KEY( fk_cod_curso)REFERENCES curso(cod_curso));
       
CREATE TABLE IF NOT EXISTS  historico(
	cod_historico INT(4)AUTO_INCREMENT PRIMARY KEY NOT NULL,
    dt_inicio DATE ,
    dt_final DATE,
	fk_RA INT (4),
    FOREIGN KEY (fk_RA)REFERENCES aluno(RA));
    
 CREATE TABLE IF NOT EXISTS disciplina_historico(
	fk_cod_historico INT (4) NOT NULL,
    fk_cod_disciplina INT (4) NOT NULL,
    nota FLOAT (4,2),
    frequencia INT(4),
    PRIMARY KEY(fk_cod_historico,fk_cod_disciplina),
	FOREIGN KEY (fk_cod_disciplina) REFERENCES disciplina (cod_disciplina),
    FOREIGN KEY (fk_cod_historico ) REFERENCES historico (cod_historico));
    		
 CREATE TABLE IF NOT EXISTS telefone_aluno (
	 cod_tel_aluno INT (4) PRIMARY KEY AUTO_INCREMENT,
	 fk_RA INT (4),fk_cod_tipo INT (4),
     fk_cod_telefone INT (4),
     FOREIGN KEY (fk_cod_telefone) REFERENCES telefone(cod_telefone),
     FOREIGN KEY ( fk_cod_tipo) REFERENCES tipo_telefone (cod_tipo),
	 FOREIGN KEY(fk_RA) REFERENCES aluno (RA));
		
CREATE TABLE IF NOT EXISTS professor_disciplina (
fk_cod_professor INT (4) NOT NULL,
fk_cod_disciplina INT(4)  NOT NULL,
PRIMARY KEY (fk_cod_professor,fk_cod_disciplina),
FOREIGN KEY (fk_cod_professor) REFERENCES professor(cod_professor),
FOREIGN KEY (fk_cod_disciplina) REFERENCES disciplina (cod_disciplina));
		
CREATE TABLE IF NOT EXISTS aluno_disciplina(
	fk_RA INT(4) NOT NULL,
    fk_cod_disciplina INT(4)NOT NULL,
    PRIMARY KEY (fk_RA,fk_cod_disciplina),
	FOREIGN KEY(fk_RA) REFERENCES aluno (RA),
    FOREIGN KEY (fk_cod_disciplina) REFERENCES disciplina (cod_disciplina));
    
    
    
    
    
    ALTER TABLE aluno CHANGE
    CPF CPF CHAR (15);
    
    ALTER TABLE departamento
	CHANGE nome_departamento nome_departamento CHAR(20) NOT NULL;	

ALTER TABLE professor
    CHANGE nome_professor nome_professor CHAR (20)NOT NULL,
    CHANGE sobrenome_professor sobrenome_professor CHAR (50) NOT NULL;


ALTER TABLE disciplina 
    CHANGE carga_horario carga_horario INT (4) NOT NULL,
    CHANGE num_alunos num_alunos INT(4) NOT NULL;

ALTER TABLE endereço 
	CHANGE nome_rua nome_rua CHAR (50)NOT NULL,
	CHANGE numero_rua numero_rua INT (4)NOT NULL,
	CHANGE complemento complemento CHAR (20)NOT NULL,
	CHANGE CEP CEP CHAR(8)NOT NULL,
	CHANGE fk_cod_tipo_logradouro fk_cod_tipo_logradouro INT (4)NOT NULL;
    
ALTER TABLE telefone_aluno						
	CHANGE fk_RA fk_RA INT (4)NOT NULL;
		
ALTER TABLE historico
	CHANGE fk_RA fk_RA INT (4)  NOT NULL ;
    
 ALTER TABLE curso 
 	CHANGE nome_curso nome_curso CHAR(30);
  
   ALTER TABLE disciplina
   CHANGE nome_disciplina nome_disciplina CHAR (30);

   ALTER TABLE tipo_telefone
CHANGE tipo_telefone tipo_telefone CHAR (15);


INSERT INTO tipo_logradouro
(tipo_logradouro)
VALUES
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua'),
	('rua');

INSERT INTO departamento
(nome_departamento)
VALUES
	('Ciencias Humanas'),
	('Matemática'),
	('Biológicas'),
	('Estágio'),
	('TI');

INSERT INTO tipo_telefone
(tipo_telefone)
VALUES
	('celular'),
	('residencial'),
	('comercial');
INSERT INTO curso
(nome_curso,fk_cod_departamento)
VALUES
	('Engenharia de Software	','5'),
	('Analise de Sistemas','4'),
	('Biologia','3'),
	('História','1'),
	('Matematica','2'),
	('Engenharia Elétrica','2'),
	('Psicologia','1'),
	('Educação Física','4'),
	('Ciência da Computação','5'),
	('Letras','1');

INSERT INTO turma
(periodo,num_aluno,dt_inicio,dt_final,fk_cod_curso)
	VALUES
	('manha'	,'17'	,'2021-06-05',	'2025-06-02' ,	'4'),
	('manha'	,'29'	,'2022-06-03',	'2026-04-04',	'9'),
	('manha'	,'37'	,'2022-06-03',	'2026-04-04',	'7'),
	('noite'	,'52'	,'2019-06-03',	'2024-06-27',	'3'),
	('noite'	,'43'	,'2022-06-03',	'2026-06-03',	'10'),
	('tarde'	,'32'	,'2022-06-03',	'2026-06-03',	'1'),
	('tarde'	,'52'	,'2018-06-02' ,	'2022-11-27',	'8'),
	('tarde'	,'27'	,'2021-03-14'	,'2023-06-24',	'2');

INSERT INTO professor

(nome_professor,sobrenome_professor,status,fk_cod_departamento)
VALUES
	('Raul', 'Valverde' ,'0','1'),
	('Marina', 'Lima','1','1'),
	('Tobias','Machado','1','5'),
	('Sara','Ribeiro','0','2'),
	('Marlon', 'Da Silva','1','3'),
	('Kilma','Macedo', '0','3'),
	('Olivia','Ribeiro','1','5'),
	('Fabrício' ,'Rocha','1','2'),
	('Fabiana','Evangelista','1','3'),
	('Luciano','Afonso','1','5'),
	('Maria ','Luiza ','1 ','2');

INSERT INTO endereço
(nome_rua,numero_rua,complemento,CEP,fk_cod_tipo_logradouro)
VALUES
	('rua a',	'1',	'conjunto a	'   ,'73252200',	'1'),
	('rua b',	'2',	'conjunto b'	,'73962992',	'2'),
	('rua c',	'3',	'conjunto c'    ,'73987400',    '3'),
	('rua d',	'4',	'conjunto d'	,'73525110',	'4'),
	('rua e',   '5',	'conjunto e'	,'73452212',	'5'),
	('rua f',	'6',	'conjunto f'	,'73352300',	'6'),
	('rua g',	'7',	'conjunto g'	,'73676700',	'7'),
	('rua h',	'8',	'conjunto h'	,'73433100',	'8'),
	('rua i',	'9',    'conjunto i'	,'76982123',	'9'),
	('rua j',	'10',	'conjunto j'	,'74543210',	'10'),
	('rua k',	'11',	'conjunto k'	,'73125020',	'11'),
	('rua l',	'12',	'conjunto l'	,'72252200',	'12'),
	('rua m',	'13',	'conjunto m'	,'71252200',	'13'),
	('rua n',	'14',	'conjunto n'	,'70952200',	'14'),
	('rua o',	'15',	'conjunto o'	,'69252200',	'15'),
	('rua p',	'16',	'conjunto p'	,'74252200',	'16'),
	('rua q',	'17',	'conjunto q'	,'75252200',	'17'),
	('rua r',	'18',	'conjunto r'	,'76252200',	'18'),
	('rua s',	'19',	'conjunto s'	,'77252200',	'19'),
	('rua t',	'20',	'conjunto t'	,'78252200',	'20');
INSERT INTO turma
(periodo,num_aluno,dt_inicio,dt_final,fk_cod_curso)
VALUES
	('manha'	,'17'	,'2021-06-05',	'2025-06-02' ,	'4'),
	('manha'	,'29'	,'2022-06-03',	'2026-04-04',	'9'),
	('manha'	,'37'	,'2022-06-03',	'2026-04-04',	'7'),
	('tarde'	,'52'	,'2019-06-03',	'2024-06-27',	'3'),
	('tarde'	,'43'	,'2022-06-03',	'2026-06-03',	'10'),
	('noite'	,'32'	,'2022-06-03',	'2026-06-03',	'1'),
	('noite'	, '52'	,'2018-06-02' ,	'2022-11-27',	'8'),
	('noite'	,'27'	,'2021-03-14'	,'2023-06-24',	'2');

INSERT INTO aluno 
(nome_aluno,sobrenome_aluno,CPF,status,sexo,nome_pai,nome_mae,email,whatsapp,fk_cod_curso,fk_cod_turma,fk_cod_endereço)
VALUES
	('Ruan'	,'Ribeiro',	'76343284',	'1',	'masculino',	'Raul'	,'Elita'	,'ruancardoch@gmail.com',	'84523708'	,'1'	,'8'	,'1'),
	('Adriano'	,'Venâncio',	'098231546' ,'	1'	,'masculino'	,'Trindade',	'Isabel'	,'adrianovenancio@gmail.com'	,'97843251' ,null,		null,	'2'),
	('Livio'	,'filho'	,'789078893'	,'1',	'masculino'	,'Livio'	,'Anabel',	'livioevangelista@gmail.com'	,'99278862'	,'1',	'8'	,'3'),
	('Matheus'	,'Laurenço'	,'94626153245'	,'1'	,'masculino'	,'José'	,'Deolane',	'matheuslaurenço@gmail.com'	,'99871123'	,'8'	,'7',	'4'),
	('Matheus',	'Assis',	'86390046',	'1',	'masculino',	'João',	'Maria',	'matheusassis@gmail.com',	'91997801' , null	,	null,	'5'),
	('Ellen',	'Callean',	'09879836321',	'1',	'Feminino',	'Lucas'	,'Joelane'	,'ellencallean@gmail.com',	'85390256',	'7',	'3',	'6'),
	('Carlos'	,'Alberto'	,'60586941320'	,'1',	'Masculino',	'Pedro',	'Clara',	'carlosalberto@gmail.com',	'83304860',	'8'	,'7',	'6'),
	('Mariana'	,'Costa'	,'07694626186'	,'1','Feminino',	'Matheus',	'Lívia',	'marianacosta@gmail.com',	'92047870'	,'4',	'1',	'7'),
	('João','Victor',	'04669118153'	,'1',	'Masculino',	'João Santana',	'Marilene',	'joaovictor@gmail.com',	'93733295',	'2','8',	'8'),
	('Gabriel'	,'silva',	'35878223104',	'1',	'Masculino'	,'Matheus Guedes',	'Joana'	,'gabrielsilva@gmail.com',	'96384095',	'4'	,'1',	'9'),
	('Elita'	,'Ribeiro'	,'04190304093'	,'1'	,'Feminino',	'Osvaldo',	'Olívia',	'elitaribeiro@gmail.com',	'81163065',	'9'	,'2',	'10'),
	('Raul',	'Alfonso'	,'67444510148',	'1'	,'Masculino',	'Paulo',	'Inês',	'raulalfonso@gmail.com'	,'86646783',	'7'	,'3',	'11'),
	('Daniel'	,'Stanchi',	'67468832641',	'1'	,'Masculino',	'Mario',	'Maria'	,'danielstanchi@gmail.com'	,'91064343',	'3'	,'4'	,'12'),
	('Mano'	,'Brown'	,'89990895414',	'1',	'Masculino',	'José',	'Joana'	,'manobrown@gmail.com','91637732',	'10'	,'5',	'13'),
	('Edi'	,'Rock',	'04512575456'	,'1',	'Masculino',	'Lucas',	'mariana',	'edirock@gmail.com',	'91923383',	'1','6','14'),
	('Rafael',	'Moreira',	'59104991656',	'1',	'Masculino'	,'Judas',	'isabely',	'rafamoreira@gmail.com'	,'84419721'	,null,	null	,'15'),
	('Chris',	'Brown',	'44164628758'	,'1',	'Masculino',	'Luan',	'Bia',	'chrisbrown@gmail.com',	'92848459' ,'8','7','16'),
	('José',	'Santiago',	'85363476436',	'1',	'Masculino'	,'Rissel',	'Carla',	'jesantiago@gmail.com',	'83343590',	'4',	'1'	,'17'),
	('Renam',	'Da Silva','25212487200',	'1',	'Masculino',	'Robson',	 'Cecília'	,'renamdasilva@gmail.com',	'84888576',	'9','2'	,'18'),
	('Borges'	,'Ribeiro',	'03512246532',	'1'	,'Masculino',	'Ribson',	'Marta',	'borgesribeiro@gmail.com',	'86591350',	'7','2','19');

INSERT INTO historico 
(dt_inicio,dt_final,fk_RA)
VALUES
	('2020-03-01','2022-06-01','1'),
	('2020-03-02','2022-06-02','2'),
	('2020-03-03','2022-06-03','3'),
	('2020-03-04','2022-06-04','4'),
	('2020-03-05','2022-06-05','5'),
	('2020-03-06','2022-06-06','6'),
	('2020-03-07','2022-06-07','7'),
	('2020-03-08','2022-06-08','8'),
	('2020-03-09','2022-06-09','9'),
	('2020-03-10','2022-06-10','10'),
	('2020-03-11','2022-06-11','11'),
	('2020-03-12','2022-06-12','12'),
	('2020-03-13','2022-06-13','13'),
	('2020-03-14','2022-06-14','14'),
	('2020-03-15','2022-06-15','15'),
	('2020-03-16','2022-06-16','16'),
	('2020-03-17','2022-06-17','17'),
	('2020-03-18','2022-06-18','18'),
	('2020-03-19','2022-06-19','19'),
	('2020-03-20','2022-06-20','20');

 
 INSERT INTO telefone
(num_telefone,fk_cod_tipo)
VALUES
	(' 23810794','1'),
	(' 97843251','1'),
	(' 32467250','1'),
	(' 24343765','1'),
	(' 27271210','1'),
	(' 36415751','1'),
	(' 23941329','1'),
	(' 26287273','1'),
	(' 28599432','1'),
	(' 22085216','1'),
	(' 31975653','1'),
	(' 29545052','1'),
	(' 86646783','1'),
	(' 91064343','1'),
	(' 91637732','1'),
	(' 25754229','1'),
	(' 28370511','1'),
	(' 25768753','1'),
	(' 83343590','1'),
	(' 36272154','1'),
	(' 35525348','1'),
	(' 32644703','2'),
	(' 33533156','2'),
	(' 22799077','2'),
	(' 25418658','3'),
	(' 30585461','3'),
	(' 21984647','3');


INSERT INTO  telefone_aluno
(fk_RA,fk_cod_telefone)
VALUES
	('1','1'),
	('1','22'),
	('1','25'),
	('2','2'),
	('3',null),
	('4','3'),
	('5','4'),
	('5','24'),
	('5','27'),
	('6','5'),
	('7','6'),
	('8',null),
	('9','7'),
	('9','23'),
	('9','26'),
	('10','8'),
	('11',null),
	('12','13'),
	('13','14'),
	('14','15'),
	('15',null),
	('16','9'),
	('17','10'),
	('18','19 '),
	('19','11'),
	('20','12');

INSERT INTO disciplina 
(nome_disciplina,carga_horario,descrição,num_alunos,fk_cod_departamento)
VALUES
	('Raciocinio Lógico',	'100',	'disciplina essêncial',	'200',	2),
	('Pscicologia Cognitiva',	'300	','matéria primordial',	'200'	,'1'),
	('Eletronica digita',	'280',	'conhecimento geral em lógica',	'200',	'2'),
	('Programação em C',	'400'	,'Uma das melhores linguagens de front',	'200'	,'5'),
	('Física Geral'	,'400',	'fenomenos da física','	200',	'2'),
	('Estatística',	'400',	'importante para negócios'	,'200'	,'2'),
	('Geometria Espacial',	'380'	,'usada em fabricação de automóveis',	'200',	'2'),
	('Direitos Humanos'	,'250','Leis mundias','	200'	,'1'),
	('Brasil',	'400'	,'Matéria chave do curso','	200',	'1'),
	('Literatura BR',	'800',	'primordial para letras'	,'300',	'1'),
	('Literatura',	'450'	,'matéria obrigatória de letras','300'	,'1'),
	('América'	,'350',	'matéria obrigatória de letras',	'300'	,'1'),
	('Embriologia',	'200'	,'matéria obrigatória de biologia','300	','3'),
	('Geologia',	'200'	,'matéria obrigatória de biologia',	'200',	'3'),
	('Histologia',	'200',	'matéria obrigatória de biologia',	'200',	'3'),
	('Bioquímica',	'200',	'matéria obrigatória de biologia',	'200',	'3'),
	('Genética'	,'200','	matéria obrigatória de biologia',	'200',	'3'),
	('Microbiologia',	'200',	'matéria obrigatória de biologia',	'200','3'),
	('Banco de Dados',	'200',	'matéria obrigatória de TI','200',	'5'),
	('Modelagem de Dados',	'200'	,'matéria obrigatória de TI',	'200','5'),
	('Computadores',	'200',	'matéria obrigatória de TI',	'200','	5'),
	('Governança de TI',	'200','matéria obrigatória de TI'	,'200','5'),
	('Gestão de Serviços',	'200',	'matéria obrigatória de TI','200',	'5'),
	('Comportamento',	'200'	,'matéria de psicologia',	'200',	'1'),
	('Psicologia Escolar'	,'200',	'matéria de psicologia',	'200'	,'1'),
	('História da Àfrica',	'200'	,'matéria de ciências humanas'	,'200','1'),
	('Econômia',	'200'	,'matéria de ciências humanas','200',	'1'),
	('Física Moderna',	'200','	matéria de matemática'	,'200'	,'2'),
	('Magnetismo','200'	,'matéria da matemática',	'200'	,'2'),
	('Termodinâmica'	,'200'	,'matéria da física',	'200'	,'2');

INSERT INTO endereço
(nome_rua,numero_rua,complemento,CEP,fk_cod_tipo_logradouro)
VALUES
	('rua a',	'1',	'conjunto a	'   ,'73252200',	'1'),
	('rua b',	'2',	'conjunto b'	,'73962992',	'2'),
	('rua c',	'3',	'conjunto c'    ,'73987400',    '3'),
	('rua d',	'4',	'conjunto d'	,'73525110',	'4'),
	('rua e',   '5',	'conjunto e'	,'73452212',	'5'),
	('rua f',	'6',	'conjunto f'	,'73352300',	'6'),
	('rua g',	'7',	'conjunto g'	,'73676700',	'7'),
	('rua h',	'8',	'conjunto h'	,'73433100',	'8'),
	('rua i',	'9',    'conjunto i'	,'76982123',	'9'),
	('rua j',	'10',	'conjunto j'	,'74543210',	'10'),
	('rua k',	'11',	'conjunto k'	,'73125020',	'11'),
	('rua l',	'12',	'conjunto l'	,'72252200',	'12'),
	('rua m',	'13',	'conjunto m'	,'71252200',	'13'),
	('rua n',	'14',	'conjunto n'	,'70952200',	'14'),
	('rua o',	'15',	'conjunto o'	,'69252200',	'15'),
	('rua p',	'16',	'conjunto p'	,'74252200',	'16'),
	('rua q',	'17',	'conjunto q'	,'75252200',	'17'),
	('rua r',	'18',	'conjunto r'	,'76252200',	'18'),
	('rua s',	'19',	'conjunto s'	,'77252200',	'19'),
	('rua t',	'20',	'conjunto t'	,'78252200',	'20');




INSERT INTO aluno_disciplina
(fk_RA,fk_cod_disciplina)
VALUES
	('1','5'),
	('3','5'),
	('4','4'),
	('6','1'),
	('7','4'),
	('8','1'),
	('9','4'),
	('10','1'),
	('11','5'),
	('12','1'),
	('13','3'),
	('14','1'),
	('15','5'),
	('16','4'),
	('18','1'),
	('19','5'),
	('20','1');


INSERT INTO curso_disciplina
(fk_cod_curso, fk_cod_disciplina)
VALUES
	('1','3'),
	('2','4'),
	('3','13'),
	('4','9'),
	('5','7'),
	('6','5'),
	('7','24'),
	('8','25'),
	('9','19'),
	('10','11'),
	('1','1'),
	('2','21'),
	('3','14'),
	('4','12'),
	('5','6'),
	('3','15'),
	('7','2'),
	('3','16'),
	('3','17'),
	('3','18'),
	('1','22'),
	('2','23'),
	('4','26'),
	('4','8'),
	('6','28'),
	('5','29'),
	('6','30'),
	('9','20'),
	('10','27');

INSERT INTO disciplina_historico
(fk_cod_historico,fk_cod_disciplina,nota,frequencia)
VALUES
	('1','1','80','100'),
	('2','2','80','100'),
	('3','3','80','100'),
	('4','4','80','100'),
	('5','5','80','100'),
	('6','6','80','100'),
	('7','7','80','100'),
	('8','8','80','100'),
	('9','9','80','100'),
	('10','10','80','100'),
	('11','11','80','100'),
	('12','12','80','100'),
	('13','13','80','100'),
	('15','14','80','100'),
	('16','16','80','100'),
	('18','17','80','100'),
	('19','19','80','100'),
	('20','20','80','100'),
	('1','21','80','100'),
	('2','22','80','100'),
	('3','23','80','100'),
	('4','24','80','100'),
	('5','25','80','100'),
	('6','26','80','100'),
	('7','27','80','100'),
	('8','28','80','100'),
	('9','29','80','100'),
	('10','30','80','100');

INSERT INTO professor_disciplina
(fk_cod_professor,fk_cod_disciplina)
VALUES 
	('1','1'),
	('2','9'),
	('3','22'),
	('4','7'),
	('5','16'),
	('6','15'),
	('7','20'),
	('8','6'),
	('9','17'),
	('10','4'),
	('11','3'),
	('1','2'),
	('2','11'),
	('3','23'),
	('4','5'),
	('5','13'),
	('6','14'),
	('7','19'),
	('8','28'),
	('8','30'),
	('11','29'),
	('1','25'),
	('2','26'),
	('3','27'),
	('5','18'),
	('7','21'),
	('1','8'),
	('1','24'),
	('2','12'),
	('1','10');

CREATE VIEW vw_alunocurso AS 
SELECT a.RA , CONCAT(a.nome_aluno,' ',a.sobrenome_aluno) AS nome , 
	c.nome_curso ,t.periodo
FROM aluno a
JOIN curso c 
	ON c.cod_curso=a.fk_cod_curso
JOIN turma t 
	ON a.fk_cod_turma=t.cod_turma
ORDER BY a.nome_aluno;

SELECT a.RA, a.nome_aluno,a.sobrenome_aluno , d.nome_disciplina, dh.nota
FROM aluno a
JOIN aluno_disciplina ad
 ON a.RA=ad.fk_RA
JOIN disciplina d
ON d.cod_disciplina = ad.fk_cod_disciplina
JOIN historico h
ON a.RA = h.fk_RA
JOIN disciplina_historico dh
ON dh.fk_cod_disciplina = d.cod_disciplina 
WHERE RA ='1'
ORDER BY dh.nota DESC;





