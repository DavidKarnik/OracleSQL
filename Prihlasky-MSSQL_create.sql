-- CREATE DATABASE Prihlasky;

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-12-14 06:39:47.866

-- tables
-- Table: Prihlasky
CREATE TABLE Prihlasky (
    sId int  NOT NULL,
    uJmeno nvarchar(10)  NOT NULL,
    obor nvarchar(10)  NOT NULL,
    rozhodnuti char(1)  NULL,
    CONSTRAINT check_rozhodnuti CHECK (rozhodnuti IN ('A', 'N')),
    CONSTRAINT Prihlasky_pk PRIMARY KEY  (sId,uJmeno,obor)
);

-- Table: Studenti
CREATE TABLE Studenti (
    sId int IDENTITY(7,1) PRIMARY KEY,
    sJmeno nvarchar(100)  NOT NULL,
    prumer numeric(3,2)  NULL,
    mesto nvarchar(100)  NULL,
    typSkoly nvarchar(5)  NULL,
    CONSTRAINT check_typSkoly CHECK (typSkoly IN ('spš', 'soš', 'gym'))
);

-- Table: University
CREATE TABLE University (
    uJmeno nvarchar(10)  NOT NULL,
    mesto nvarchar(100)  NULL,
    pocetStud int  NULL,
    CONSTRAINT University_pk PRIMARY KEY  (uJmeno)
);

-- foreign keys
-- Reference: Prihlasky_Studenti (table: Prihlasky)
ALTER TABLE Prihlasky ADD CONSTRAINT Prihlasky_Studenti
    FOREIGN KEY (sId)
    REFERENCES Studenti (sId)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE;

-- Reference: Prihlasky_University (table: Prihlasky)
ALTER TABLE Prihlasky ADD CONSTRAINT Prihlasky_University
    FOREIGN KEY (uJmeno)
    REFERENCES University (uJmeno)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE;

-- End of file.