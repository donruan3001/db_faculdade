<<<<<<< HEAD
ALTER TABLE departamento
	CHANGE nome_departamento nome_departamento CHAR(20) NOT NULL;	

ALTER TABLE professor
    CHANGE nome_professor nome_professor CHAR (20)NOT NULL,
    CHANGE sobrenome_professor sobrenome_professor CHAR (50) NOT NULL,
ADD fk_cod_departamento INT(4), ADD FOREIGN KEY (fk_cod_departamento) REFERENCES departamento (cod_departamento);

ALTER TABLE turma
ADD fk_cod_curso INT (4),
ADD FOREIGN KEY (fk_cod_curso)REFERENCES curso(cod_curso);
DESCRIBE  turma;
	
    
ALTER TABLE disciplina 
    CHANGE carga_horario carga_horaria INT (4) NOT NULL,
    CHANGE num_alunos num_alunos INT(4) NOT NULL;

ALTER TABLE endereço 
	CHANGE nome_rua nome_rua CHAR (50)NOT NULL,
	CHANGE numero_rua numero_rua INT (4)NOT NULL,
	CHANGE complemento complemento CHAR (20)NOT NULL,
	CHANGE CEP CEP CHAR(8)NOT NULL,
	CHANGE fk_cod_tipo_lougradouro fk_cod_tipo_lougradouro INT (4)NOT NULL;
    
ALTER TABLE telefone_aluno						
	CHANGE fk_RA fk_RA INT (4)NOT NULL,
    ADD fk_cod_telefone INT(4)NOT NULL, ADD FOREIGN KEY (fk_cod_telefone)REFERENCES telefone(cod_telefone);
    
		
ALTER TABLE histórico
	CHANGE fk_RA fk_RA INT (4) NOT NULL;
    
 ALTER TABLE curso 
 	CHANGE nome_curso nome_curso CHAR(30);
  
    
   ALTER TABLE disciplina
   CHANGE nome_disciplina nome_disciplina CHAR (30);
=======

>>>>>>> 6829c4900517237e272e0e7876c55f90ebced09d
