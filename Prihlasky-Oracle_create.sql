-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-01-06 12:45:37.306

-- tables
-- Table: Prihlasky
CREATE TABLE Prihlasky (
    sId int  NOT NULL,
    uJmeno varchar2(10)  NOT NULL,
    obor varchar2(10)  NOT NULL,
    rozhodnuti char(1)  NULL,
    CONSTRAINT check_rozhodnuti CHECK (rozhodnuti IN ('A', 'N')),
    CONSTRAINT Prihlasky_pk PRIMARY KEY (sId,uJmeno,obor)
) ;

-- Table: Studenti
CREATE TABLE Studenti (
    sId int  NOT NULL,
    sJmeno varchar2(100)  NOT NULL,
    prumer number(3,2)  NULL,
    mesto varchar2(100)  NULL,
    typSkoly varchar2(5)  NULL,
    CONSTRAINT check_typSkoly CHECK (typSkoly IN ('spš', 'soš', 'gym')),
    CONSTRAINT Studenti_pk PRIMARY KEY (sId)
) ;

-- Table: University
CREATE TABLE University (
    uJmeno varchar2(10)  NOT NULL,
    mesto varchar2(100)  NULL,
    pocetStud int  NULL,
    CONSTRAINT University_pk PRIMARY KEY (uJmeno)
) ;

-- foreign keys
-- Reference: Prihlasky_Studenti (table: Prihlasky)
ALTER TABLE Prihlasky ADD CONSTRAINT Prihlasky_Studenti
    FOREIGN KEY (sId)
    REFERENCES Studenti (sId);

-- Reference: Prihlasky_University (table: Prihlasky)
ALTER TABLE Prihlasky ADD CONSTRAINT Prihlasky_University
    FOREIGN KEY (uJmeno)
    REFERENCES University (uJmeno);

-- End of file.

