--Oracle database--

/*D00. 2+2*/
SELECT 2+2
FROM dual
;
--MS SQL
SELECT 2+2
;

/*D0. Najdi všechny studenty.*/
/* * */
SELECT *
FROM Studenti
;

/*D1. Najdi všechny studenty, kteří mají průměr míň než 2.0.*/
/* jedna podmínka */
SELECT *
FROM Studenti
WHERE prumer < 2.0
;

/*D1a. Najdi všechny studenty, kteří mají průměr mezi 1.0 a 2.0.*/
SELECT *
FROM Studenti
WHERE prumer BETWEEN 1.0 AND 2.4
;
-- stejné
SELECT *
FROM Studenti
WHERE prumer >= 1.0 AND prumer <= 2.4
;

/*D2. Najdi všechny prihlášky na obor IT na TUL.*/
/* víc podmínek - logické operátory*/
SELECT *
FROM Prihlasky
WHERE obor = 'IT' AND uJmeno = 'TUL'
;

/*D2a. Najdi všechny prihlášky na TUL a na KU.*/
/* víc podmínek na jeden atribut*/
SELECT *
FROM Prihlasky
WHERE uJmeno = 'MU' OR uJmeno = 'TUL'
;
--pozor, následující podmínku nesplňují žádna data
--neexistuje řadek, který by měl uJmeno zároveň MU a TUL
SELECT *
FROM Prihlasky
WHERE uJmeno = 'MU' AND uJmeno = 'TUL'
;

/*D3. Najdi ID a jména studentů, kteří mají průměr míň než 2.0.*/
/* výběr atributů */ 
SELECT sID, sJmeno 
FROM Studenti
WHERE prumer < 2.0
;

/*D4. Najdi ID studentů, kteří si podali prihlášku*/
/* distinct (bez duplicit) */
SELECT DISTINCT sID
FROM Prihlasky
;

/*D5. Najdi ID, jména a průměry studentů, kteří chodí na SPŠ a nebyli alespoň jednou přijati.*/
/* karteský součin, 2 sloupce s sID -> Studenti.sID a Prihlasky.sID, distinct */
SELECT DISTINCT Studenti.sID, sJmeno, prumer
FROM Studenti, Prihlasky
WHERE Studenti.sID = Prihlasky.sID AND typSkoly = 'spš' AND rozhodnuti = 'N'
;

/*D6. Najdi ID, jména studentů, jejich průměry a university, kam se hlásili a počty studentů na těch univerzitách.
Setřiď podle počtu studentů a jména studenta.*/
/* třídení podle názvu sloupce */
SELECT Studenti.sID, sJmeno, prumer, University.uJmeno, pocetStud
FROM Studenti, Prihlasky, University
WHERE Studenti.sID = Prihlasky.sID AND Prihlasky.uJmeno = University.uJmeno
ORDER BY pocetStud DESC, sJmeno
;

/* alias = přejmenování tabulek */
SELECT S.sID, sJmeno, prumer, U.uJmeno, pocetStud
FROM Studenti S, Prihlasky P, University U
WHERE S.sID = P.sID AND P.uJmeno = U.uJmeno
ORDER BY pocetStud DESC, sJmeno
;

/* přejmenování sloupců AS, třídění podle čísla sloupce a podle přejmenovaného sloupce */
SELECT 
   S.sID     AS "ID studenta",
   sJmeno    AS "Jméno studenta",
   prumer    AS "Průměr",
   U.uJmeno  AS "Universita",
   pocetStud AS "Počet studentů"
FROM Studenti S, Prihlasky P, University U
WHERE S.sID = P.sID AND P.uJmeno = U.uJmeno
ORDER BY 5 DESC, "Jméno studenta"
;
-- pokud jsou přejmenování jednoslovná a bez diakritiky
SELECT 
   S.sID     AS IdStud,
   sJmeno    AS JmenoStud,
   prumer    AS Prumer,
   U.uJmeno  AS Universita,
   pocetStud AS PocetStud
FROM Studenti S, Prihlasky P, University U
WHERE S.sID = P.sID AND P.uJmeno = U.uJmeno
ORDER BY 5 DESC, JmenoStud
;

/*D7. Najdi university a jejich rozpočty v miliónech, když na jednoho studenta připadá 60 000 Kč ročně.*/
/* výpočet a pojmenování nového sloupce */
SELECT uJmeno, pocetStud*0.06 AS "Rozpočet (miliónů)"
FROM University
;

/*D8. Najdi dvojice universit ze stejného města.*/ 
SELECT U1.uJmeno, U2.uJmeno
FROM University U1, University U2
--WHERE U1.mesto = U2.mesto;
--WHERE U1.mesto = U2.mesto AND U1.uJmeno <> U2.uJmeno;
WHERE U1.mesto = U2.mesto AND U1.uJmeno < U2.uJmeno
;

/*D9. Najdi ID studentů, kteří studovali SPŠ nebo SOŠ 
resp. školu se zkratkou začínající na s, končící na š, která má 3 písmena.*/
/* like - náhrada jednoho znaku _ */
SELECT sID, typSkoly
FROM Studenti
WHERE typSkoly LIKE 's_š'
;

/*D9a. Najdi ID studentů, kteří studovali střední školu v městě na P.*/
/* like - náhrada více znaků % */
SELECT sID, mesto
FROM Studenti
WHERE mesto LIKE 'P%'
;

------------------------MNOŽINOVÉ OPERACE--------------------------------------------------------------------------------

/*D10. Najdi města, ve kterých je universita nebo tam studují studenti na střední škole.*/
/* sjednocení UNION */
SELECT mesto
FROM Studenti
UNION
SELECT mesto
FROM University
;

/*D10a. Najdi jména všech studentů a všech universit.
/* (společný název sloupce - funguje i bez něj), jedinečné názvy */ 
SELECT sJmeno AS jmeno
FROM Studenti 
UNION
SELECT uJmeno AS "jmeno"
FROM University
; 
--vráti o jeden záznam navíc, protože jméno Bob se v Studenti nachází 2x
SELECT sJmeno AS jmeno
FROM Studenti 
UNION ALL
SELECT uJmeno AS "jmeno"
FROM University
; 

/*D11. Najdi města, ve kterých je universita a zároveň tam studují studenti na střední škole.*/
/* průnik INTERSECT */
SELECT mesto
FROM Studenti
INTERSECT
SELECT mesto
FROM University
;

/*když není podporován průnik - napr. MySQL (v nejnovší verzi 8.0 je už podporován)*/
SELECT DISTINCT S.mesto
FROM Studenti S, University U
WHERE S.mesto = U.mesto
;

/*D12. Najdi města, ve kterých studují studenti na střední škole, ale není tam universita.*/
/* rozdíl MINUS */
/* V MS SQL EXCEPT*/
SELECT mesto
FROM Studenti
MINUS
SELECT mesto
FROM University
;

/*D13. Najdi ID studentů, kteří se nikam nehlásili.*/
SELECT sID
FROM Studenti
MINUS
SELECT sID
FROM Prihlasky
;

------------------------SPOJENÍ--------------------------------------------------------------------------------

/*D14. Najdi, id, jména a průměry studentů, kteří chodí na SPŠ a byli přijati alespoň na jednu univerzitu.*/
--theta join ON (dva sloupce Studenti.sId, Prihlasky.sId)
SELECT Studenti.sId, sJmeno, prumer, typSkoly, rozhodnuti
FROM Studenti 
JOIN Prihlasky ON (Studenti.sId = Prihlasky.sId)
WHERE typSkoly = 'spš' AND rozhodnuti = 'A'
;
--natural join (jeden sloupec sID)
SELECT sId, sJmeno, prumer, typSkoly, rozhodnuti
FROM Studenti 
NATURAL JOIN Prihlasky
WHERE typSkoly = 'spš' AND rozhodnuti = 'A'
;
--join USING (jeden sloupec sID)
SELECT sId, sJmeno, prumer, typSkoly, rozhodnuti
FROM Studenti 
JOIN Prihlasky USING (sId)
WHERE typSkoly = 'spš' AND rozhodnuti = 'A'
;

/*D15. Vytvoř přehled o studentech a jejích přihláškách, u všech studentů najdi, na jakou universitu se hlásí*/
/* LEFT JOIN */
SELECT Studenti.sID, sJmeno, uJmeno
FROM Studenti 
LEFT JOIN Prihlasky ON Studenti.sId = Prihlasky.sID
;
--nahrazení NULL hodnoty
--V MS SQL ISNULL()
SELECT Studenti.sID, sJmeno, NVL(uJmeno, 'nepodal') AS "Universita"
FROM Studenti 
LEFT JOIN Prihlasky ON Studenti.sId = Prihlasky.sID
;

/*D16. Najdi všechny studenty, kteří mají průměr větší než 2, nebo jejich průměr není zadaný. */
/* IS NULL, IS NOT NULL */
SELECT *
FROM Studenti
WHERE prumer > 2.0 OR prumer IS NULL
;

------------------------VNOŘENÉ DOTAZY--------------------------------------------------------------------------------

/*D17. Najdi průměry studentů, kteří se hlásí na IT.*/
/* vnořený dotaz do WHERE */
/* IN a NOT IN */
SELECT prumer
FROM Studenti
WHERE Studenti.sID IN (SELECT sID
                       FROM Prihlasky 
                       WHERE obor = 'IT')
;

/* Alternativa D2a. Najdi všechny prihlášky na TUL a na KU*/
SELECT *
FROM Prihlasky
WHERE uJmeno IN ('MU', 'TUL')
;

/* Alternativa D12. Najdi města, ve kterých studují studenti na střední škole, ale není tam universita.*/
/* rozdíl, když není podporován rozdíl */
SELECT DISTINCT mesto
FROM Studenti
WHERE mesto NOT IN (SELECT mesto FROM University)
;

/*D18. Najdi všechna jména universit, pro které platí, že ve stejném městě existuje ještě další universita.*/
/*podmnožina, kterou jde použít pro porovnání, 
pro každou univerzitu U1, testujeme, jestli existuje universita/y,
které jsou ve stejném městě a mají jiný název*/ 
SELECT uJmeno
FROM University U1
WHERE EXISTS (SELECT * 
              FROM University U2
              WHERE U1.mesto = U2.mesto AND U1.uJmeno <> U2.uJmeno)
;

/*D19. Najdi jméno/a universit, které mají nejvyšší počet studentů.*/
/* pro každou universitu U1 testujeme jestli neexistuje universita/y,
které mají více studentů */
/* NOT EXISTS */
SELECT uJmeno
FROM University U1
WHERE NOT EXISTS (SELECT * 
  		          FROM University U2 
  		          WHERE U2.pocetStud > U1.pocetStud)
; 

/*D20. Najdi jméno/a universit, kterých rozpočet je vyšší jako 500 mil.*/
/* vnorený dotaz do FROM */
SELECT uJmeno, rozpocet
FROM (SELECT uJmeno, pocetStud*0.06 AS rozpocet
	  FROM University) U
WHERE rozpocet > 500
;
--stejné
SELECT uJmeno, pocetStud*0.06 AS rozpocet
FROM University
WHERE pocetStud*0.06 > 500
; 

/*D21. Najdi jména universit a k nim průměr nejlepšího studenta, který se na danou universitu hlásil.*/
/* vnořený dotaz v SELECT, vnořený dotaz musí vracet 1 hodnotu */
SELECT uJmeno,(SELECT MIN(prumer) 
		       FROM Studenti, Prihlasky
		       WHERE Studenti.sId = Prihlasky.sId AND
		       Prihlasky.uJmeno = University.uJmeno) AS minPrumer
FROM University
;
--jen pro university, kde jsou přihlášky
SELECT uJmeno,(SELECT MIN(prumer) 
		      FROM Studenti, Prihlasky
		      WHERE Studenti.sId = Prihlasky.sId AND
		      Prihlasky.uJmeno = U1.uJmeno) AS minPrumer
FROM (SELECT DISTINCT uJmeno
      FROM Prihlasky) U1 
;
--stejné
SELECT DISTINCT uJmeno,(SELECT MIN(prumer) 
		      FROM Studenti, Prihlasky
		      WHERE Studenti.sId = Prihlasky.sId AND
		      Prihlasky.uJmeno = P1.uJmeno) AS minPrumer
FROM Prihlasky P1 
;

------------------------AGREGAČNÍ FUNKCE--------------------------------------------------------------------------------

/*D22. Najdi počet studentů*/
/* COUNT */
--počíta řádky
SELECT COUNT(*) AS "počet studentů"
FROM Studenti
;
--počíta řádky v sloupci, kde není NULL
SELECT COUNT(prumer) AS "počet průměrů"
FROM Studenti
;

/*D22a. Najdi průměrný průměr studentů.*/
/* AVG */
/*počíta přes studenty s NOT NULL průměrem*/
SELECT AVG(prumer) as prumer
FROM Studenti
;
--ROUND() funkce zaokrouhlení
SELECT ROUND(AVG(prumer), 1) AS prumer
FROM Studenti
;
--nebude dobře fungovat, SUM bez NULL, COUNT s NULL
/* SUM */
SELECT SUM(prumer) / COUNT(*) AS prumer
FROM Studenti
;
--bude fungovat - musím upravit
SELECT SUM(prumer) / COUNT(*) AS prumer
FROM Studenti
WHERE prumer IS NOT NULL
;
--bude fungovat - musím upravit
SELECT SUM(prumer) / COUNT(prumer) AS prumer
FROM Studenti
;

/*D23. Najdi průměrný průměr studentů, kteří se hlásili na IT.*/ 
/* prvý započíta 2x ty, kteří mají 2 prihlášky na IT na různé university */ 
SELECT AVG(prumer)
FROM Studenti, Prihlasky
WHERE Studenti.sId = Prihlasky.sID AND obor = 'IT';
vs.
SELECT AVG(prumer)
FROM Studenti
WHERE sId IN (SELECT sId
              FROM Prihlasky
              WHERE obor = 'IT')
;

/*D24. Najdi počet studentů, kteří se hlásí na IT.*/
SELECT COUNT(DISTINCT sID) AS "počet studentů"
FROM Prihlasky
WHERE obor = 'IT'
;

/*D24a. Najdi počet prihlášek na obor IT.*/
SELECT COUNT(sID) AS "počet prihlášek"
FROM Prihlasky
WHERE obor = 'IT' 
;

/*D25. Najdi kolik studentů se hlásí na kterou universitu.*/
/* GROUP BY vytváření skupin */
SELECT uJmeno, COUNT(DISTINCT sID) AS "počet studentů"
FROM Prihlasky
GROUP BY uJmeno
;

/*D26. Najdi kolik prihlášek podal každý student.*/ 
SELECT Studenti.sID, COUNT (uJmeno) AS "počet přihlášek"
FROM Prihlasky, Studenti
WHERE Prihlasky.sID = Studenti.sId
GROUP BY Studenti.sId
;
--i ti, co se nehlásí nikam
SELECT Studenti.sID, COUNT (uJmeno) AS "počet přihlášek"
FROM Prihlasky RIGHT JOIN Studenti ON Studenti.sId = Prihlasky.sID
GROUP BY Studenti.sId
ORDER BY Studenti.sID
;
--i jméno studenta
/* GROUP BY se 2 atributy vytváření skupin a v nich podskupin */
SELECT Studenti.sID, sJmeno, COUNT (uJmeno) AS "počet přihlášek"
FROM Prihlasky RIGHT JOIN Studenti ON Studenti.sId = Prihlasky.sID
GROUP BY Studenti.sId, sJmeno
ORDER BY Studenti.sID
;

/*D26a. Najdi na kolik universit se hlásil každý student.*/
SELECT Studenti.sID, sJmeno, COUNT (DISTINCT uJmeno) AS "počet universit"
FROM Prihlasky RIGHT JOIN Studenti ON Studenti.sId = Prihlasky.sID
GROUP BY Studenti.sId, sJmeno
ORDER BY Studenti.sID
;

/*D26b. Najdi kolik prihlášek na které univerzity podal každý student.*/
--v SELECT jenom sloupce, přes které se dělá GROUP BY nebo agregační funkce 
--víc atribútů, aby pro podskupiny existoval jeden výsledek
SELECT Studenti.sID, sJmeno, uJmeno, COUNT (uJmeno) AS "počet přihlášek"
FROM Prihlasky RIGHT JOIN Studenti ON Studenti.sId = Prihlasky.sID
GROUP BY Studenti.sId, sJmeno, uJmeno 
ORDER BY Studenti.sID, uJmeno
;

/*D27. Najdi jmeno studenta s nejlepším průměrem*/
/* MIN */
SELECT sJmeno, minPrum
FROM (SELECT MIN(prumer) AS minPrum
      FROM Studenti
     ) MS,
     Studenti S
WHERE S.prumer = MS.minPrum
;
--nejlepší průměr
SELECT MIN(prumer)
FROM Studenti
;
--pozor, tohle dělá najlepší průměr pro jednotlivé studenti, ale jenom z jejich prumeru
SELECT sJmeno, MIN(prumer)
FROM Studenti
GROUP BY sJmeno
;

/*D28. Najdi pro každé universitní město počet přihlášek.*/
SELECT mesto, SUM(pocetPrihlasekNaUniversitu) AS pocetPrihlasekNaMesto
FROM (SELECT uJmeno, COUNT(sID) AS pocetPrihlasekNaUniversitu
      FROM Prihlasky
      GROUP BY uJmeno
     ) PS
     RIGHT JOIN University U ON U.uJmeno = PS.uJmeno
GROUP BY mesto
;

/*D29. Najdi university, na které se hlásí víc než 2 (různí) studenti.*/
/* HAVING podmínka na skupinu */
SELECT uJmeno, COUNT(DISTINCT sID)
FROM Prihlasky
GROUP BY uJmeno
HAVING COUNT(DISTINCT sID) > 2;
--pozor na CVUT 2 prihlášky od 1 studenta
SELECT uJmeno, COUNT(sID)
FROM Prihlasky
GROUP BY uJmeno
HAVING COUNT(sID) > 2
;

------------------------OSTATNÍ--------------------------------------------------------------------------------

/*D30. Najdi první 2 záznamy ze Studentů*/
--in MS SQL SELECT TOP 2
SELECT *
FROM Studenti
WHERE ROWNUM <= 2
;

--při složitějším Selectu
/* WITH AS */
WITH A AS (
SELECT mesto, SUM(pocetPrih) AS pocetPrih
FROM (SELECT uJmeno AS uJmeno, COUNT(sID) AS pocetPrih
      FROM Prihlasky
      GROUP BY uJmeno
     ) PS
     JOIN University U ON U.uJmeno = PS.uJmeno
GROUP BY mesto
)
SELECT *
FROM A
WHERE ROWNUM <= 2
;

/*D31. Funkce*/
--aktuální datum GETDATE() v MS SQL
SELECT COUNT(*) AS pocet, SYSDATE AS datum
FROM Prihlasky
;
-- spojování řetezců
SELECT CONCAT(sJmeno, CONCAT(' z ', mesto))
FROM Studenti
;

/*D32. Metadata - Najdi tabulky v databáze.*/
/*SELECT * FROM sys.tables v MS SQL
;*/

SELECT DISTINCT OBJECT_NAME 
  FROM USER_OBJECTS
 WHERE OBJECT_TYPE = 'TABLE'
 ;
--stejne
SELECT table_name from USER_TABLES
;