-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para faculdade
CREATE DATABASE IF NOT EXISTS `faculdade` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `faculdade`;

-- Copiando estrutura para tabela faculdade.aluno
CREATE TABLE IF NOT EXISTS `aluno` (
  `id_pessoa` int(11) DEFAULT NULL,
  `cre` varchar(50) DEFAULT NULL,
  UNIQUE KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `FK_aluno_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.aluno_curso
CREATE TABLE IF NOT EXISTS `aluno_curso` (
  `id_pessoa` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  PRIMARY KEY (`id_pessoa`,`id_curso`),
  KEY `FK_aluno_curso_curso` (`id_curso`),
  CONSTRAINT `FK_aluno_curso_curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_aluno_curso_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.aluno_disciplinas_realizadas
CREATE TABLE IF NOT EXISTS `aluno_disciplinas_realizadas` (
  `id_pessoa` int(11) NOT NULL,
  `id_periodo` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  `concluiu` bit(1) DEFAULT NULL,
  `em_andamento` bit(1) DEFAULT NULL,
  `monitor` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id_pessoa`,`id_periodo`,`id_disciplina`),
  KEY `FK_aluno_disciplinas_realizadas_periodo` (`id_periodo`),
  KEY `FK_aluno_disciplinas_realizadas_disciplina` (`id_disciplina`),
  CONSTRAINT `FK_aluno_disciplinas_realizadas_disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_aluno_disciplinas_realizadas_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_aluno_disciplinas_realizadas_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.curso
CREATE TABLE IF NOT EXISTS `curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dt_inicio` date DEFAULT NULL,
  `dt_fim` date DEFAULT NULL,
  `nome_curso` varchar(30) NOT NULL,
  `ativo` bit(1) NOT NULL DEFAULT b'0',
  `admitindo_alunos` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.disciplina
CREATE TABLE IF NOT EXISTS `disciplina` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(70) DEFAULT NULL,
  `numeroDeCreditos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.disciplina_curso
CREATE TABLE IF NOT EXISTS `disciplina_curso` (
  `id_disciplina` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  PRIMARY KEY (`id_disciplina`,`id_curso`),
  KEY `FK__curso` (`id_curso`),
  CONSTRAINT `FK__curso` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK__disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.disciplina_dependencias
CREATE TABLE IF NOT EXISTS `disciplina_dependencias` (
  `id_disciplina` int(11) NOT NULL,
  `id_disciplina_dependencia` int(11) NOT NULL,
  PRIMARY KEY (`id_disciplina`,`id_disciplina_dependencia`),
  KEY `FK_disciplina_dependencias_disciplina_2` (`id_disciplina_dependencia`),
  CONSTRAINT `FK_disciplina_dependencias_disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_disciplina_dependencias_disciplina_2` FOREIGN KEY (`id_disciplina_dependencia`) REFERENCES `disciplina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.disciplina_periodo
CREATE TABLE IF NOT EXISTS `disciplina_periodo` (
  `id_disciplina` int(11) NOT NULL,
  `id_periodo` int(11) NOT NULL,
  PRIMARY KEY (`id_disciplina`,`id_periodo`),
  KEY `FK_disciplina_periodo_periodo` (`id_periodo`),
  CONSTRAINT `FK_disciplina_periodo_disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_disciplina_periodo_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.disciplina_professor
CREATE TABLE IF NOT EXISTS `disciplina_professor` (
  `id_pessoa` int(11) NOT NULL,
  `id_disciplina` int(11) NOT NULL,
  PRIMARY KEY (`id_pessoa`,`id_disciplina`),
  KEY `FK_disciplina_pessoa_disciplina` (`id_disciplina`),
  CONSTRAINT `FK_disciplina_pessoa_disciplina` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplina` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_disciplina_pessoa_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.empresa
CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL DEFAULT '',
  `cnpj` varchar(50) NOT NULL DEFAULT '',
  `endereco` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.estagio
CREATE TABLE IF NOT EXISTS `estagio` (
  `id` int(11) NOT NULL,
  `id_pessoa` int(11) NOT NULL DEFAULT 0,
  `id_empresa` int(11) NOT NULL DEFAULT 0,
  `dt_inicio` date NOT NULL,
  `dt_termino` date NOT NULL,
  `em_andamento` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK__pessoa` (`id_pessoa`),
  KEY `FK__empresa` (`id_empresa`),
  CONSTRAINT `FK__empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK__pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.periodo
CREATE TABLE IF NOT EXISTS `periodo` (
  `id` int(11) NOT NULL,
  `ano` smallint(6) DEFAULT NULL,
  `semestre` bit(1) DEFAULT NULL COMMENT '0=1º semestre e 1=2º semestre',
  `dataDeInicio` date DEFAULT NULL,
  `dataDeTermino` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.pessoa
CREATE TABLE IF NOT EXISTS `pessoa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `cidade` varchar(30) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `dadosPessoais` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.professor
CREATE TABLE IF NOT EXISTS `professor` (
  `id_pessoa` int(11) DEFAULT NULL,
  `email_profissional` varchar(100) DEFAULT NULL,
  `RF` varchar(10) DEFAULT NULL,
  `ativo` bit(1) DEFAULT NULL,
  UNIQUE KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `FK_professor_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela faculdade.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_pessoa` int(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `senha` varchar(30) DEFAULT NULL,
  UNIQUE KEY `id_pessoa` (`id_pessoa`),
  CONSTRAINT `FK_usuario_pessoa` FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Exportação de dados foi desmarcado.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
