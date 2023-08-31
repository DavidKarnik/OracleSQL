INSERT INTO Studenti (sID, sJmeno, prumer, typSkoly, mesto) VALUES (1, 'Alice', 1.2, 'gym', 'Liberec');
INSERT INTO Studenti (sID, sJmeno, prumer, typSkoly, mesto) VALUES (2, 'Bob', 2.3, 'soš', 'Liberec');
INSERT INTO Studenti (sID, sJmeno, prumer, typSkoly, mesto) VALUES (3, 'Cyril', 1.3, 'spš', 'Praha');
INSERT INTO Studenti (sID, sJmeno, prumer, typSkoly, mesto) VALUES (4, 'David', NULL, NULL, 'Plzeň');
INSERT INTO Studenti (sID, sJmeno, prumer, typSkoly, mesto) VALUES (5, 'Bob', 3.2, 'spš', 'Liberec');
INSERT INTO Studenti (sID, sJmeno, prumer, typSkoly, mesto) VALUES (6, 'Erik', 2.4, 'gym', 'Plzeň');

INSERT INTO University (uJmeno, mesto, pocetStud) VALUES ('TUL', 'Liberec', 8000);
INSERT INTO University (uJmeno, mesto, pocetStud) VALUES ('KU', 'Praha', 15000);
INSERT INTO University (uJmeno, mesto, pocetStud) VALUES ('CVUT', 'Praha', 13000);
INSERT INTO University (uJmeno, mesto, pocetStud) VALUES ('MU', 'Brno', 11000);
INSERT INTO University (uJmeno, mesto, pocetStud) VALUES ('TUO', 'Ostrava', 9000);

INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (1,'TUL', 'IT', 'N');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (1,'KU', 'IT', 'A');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (2,'KU', 'IT', 'A');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (2,'MU', 'EE', 'A');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (3,'CVUT', 'IT', 'N');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (3,'KU', 'EE', 'N');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (5,'TUL', 'IT', 'N');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (5,'CVUT', 'IT', 'N');
INSERT INTO Prihlasky (sID, uJmeno, obor, rozhodnuti) VALUES (5,'CVUT', 'EE', 'A');


