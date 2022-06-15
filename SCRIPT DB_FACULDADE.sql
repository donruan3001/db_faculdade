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
    status BOOLEAN);
    
CREATE TABLE IF NOT EXISTS turma(
	cod_turma INT(4) PRIMARY KEY AUTO_INCREMENT NOT NULL,
	periodo CHAR(8),
	num_aluno INT(4),
	dt_inicio DATE,
	dt_final DATE
);    

CREATE TABLE IF NOT EXISTS tipo_lougradouro(
	cod_tipo_lougradouro INT(4) PRIMARY KEY AUTO_INCREMENT,
    tipo_lougradouro CHAR(20)
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
    fk_cod_tipo_lougradouro INT (4),
    PRIMARY KEY (cod_endereço),
    FOREIGN KEY (fk_cod_tipo_lougradouro)REFERENCES tipo_lougradouro(cod_tipo_lougradouro));

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
       
CREATE TABLE IF NOT EXISTS  histórico(
	cod_histórico INT(4)AUTO_INCREMENT PRIMARY KEY NOT NULL,
    dt_inicio DATE ,
    dt_final DATE,
	fk_RA INT (4),
    FOREIGN KEY (fk_RA)REFERENCES aluno(RA));
    
 CREATE TABLE IF NOT EXISTS disciplina_histórico(
	fk_cod_histórico INT (4) NOT NULL,
    fk_cod_disciplina INT (4) NOT NULL,
    nota FLOAT (4,2),
    frequencia INT(4),
    PRIMARY KEY(fk_cod_histórico,fk_cod_disciplina),
	FOREIGN KEY (fk_cod_disciplina) REFERENCES disciplina (cod_disciplina),
    FOREIGN KEY (fk_cod_histórico ) REFERENCES histórico (cod_histórico));
    		
 CREATE TABLE IF NOT EXISTS telefone_aluno (
	 cod_tel_aluno INT (4) PRIMARY KEY AUTO_INCREMENT,
	 fk_RA INT (4),
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
