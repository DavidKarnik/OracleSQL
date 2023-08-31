--Oracle database--

/*D00. 2+2*/

/*D0. Najdi všechny studenty*/
/* * */
SELECT *
FROM Sudenti;

/*D1. Najdi všechny studenty, kteří mají průměr míň než 2.0.*/
/* jedna podmínka */
SELECT *
FROM Studenti
WHERE prumer < 2;

/*D1a. Najdi všechny studenty, kteří mají průměr mezi 1.0 a 2.0.*/
SELECT *
FROM Studenti
WHERE prumer >= 1 AND prumer <= 2;

/*D2. Najdi všechny prihlášky na obor IT na TUL.*/
/* víc podmínek - logické operátory*/
SELECT *
FROM Prihlasky
WHERE obor = 'IT' AND uJmeno 'TUL';

/*D2a. Najdi všechny prihlášky na TUL a na KU.*/
/* víc podmínek na jeden atribut*/
SELECT *
FROM Prihlasky
WHERE uJmeno = 'KU' OR uJmeno 'TUL';

/*D3. Najdi ID a jména studentů, kteří mají průměr míň než 2.0.*/
/* výběr atributů */ 
SELECT sId, sJmeno
FROM Studenti
WHERE prumer < 2;

/*D4. Najdi ID studentů, kteří si podali prihlášku.*/
/* distinct (bez duplicit) */
SELECT DISTINCT sId
FROM Prihlasky;

/*D5. Najdi ID, jména a průměry studentů, kteří chodí na SPŠ a nebyli alespoň jednou přijati.*/
/* karteský součin, 2 sloupce s sID -> Studenti.sID a Prihlasky.sID, distinct */
SELECT DISTINCT Studenti.sID, sJmeno, prumer
FROM Studenti, Prihlasky
WHERE Studenti.sID = Prihlasky.sID AND typSkoly = 'spš' AND rozhodnuti = 'N';

/*D6. Najdi ID, jména studentů, jejich průměry a university, kam se hlásili a počty studentů na těch univerzitách.
Setřiď podle počtu studentů a jména studenta.*/
/* třídení podle názvu sloupce */
SELECT DISTINCT Studenti.sID, sJmeno, prumer, Univerzity.uJmeno, Univerzity.pocetStud
FROM Studenti, Prihlasky, Univerzity
WHERE Studenti.sID = Prihlasky.sID AND Prihlasky.uJmeno = Univerzity.uJmeno
ORDER BY pocetStud DESC, sJmeno;

/* alias = přejmenování tabulek*/
SELECT S.sID, sJmeno, prumer, U.uJmeno, pocetStud
FROM Studenti S, Prihlasky P, University U
WHERE S.sID = P.sID AND P.uJmeno = U.uJmeno
ORDER BY pocetStud DESC, sJmeno
;

/* přejmenování sloupců AS, třídění podle čísla sloupce a podle přejmenovaného sloupce*/
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
/* výpočet a pojmenování nového sloupce*/
SELECT uJmeno, pocetStud*0.06 AS "Rozpočet (miliónů)"
FROM University;

/*D8. Najdi dvojice universit ze stejného města.*/ 
SELECT A.uJmeno, B.uJmeno
FROM University A, University B;
WHERE A.mesto = B.mesto AND U1.uJmeno != U2.uJmeno;

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
FROM University;

/*D10a. Najdi jména všech studentů a všech universit.*/
/* (společný název sloupce - funguje i bez něj), jedinečné názvy */ 
SELECT sJmeno AS jmeno
FROM Studenti 
UNION
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

/*D12. Najdi města, ve kterých studují studenti na střední škole, ale není tam universita.*/
/* rozdíl MINUS */
/* V MS SQL EXCEPT*/
SELECT mesto
FROM Studenti
EXCEPT
SELECT mesto
FROM University
;

/*D13. Najdi ID studentů, kteří se nikam nehlásili.*/
SELECT sId
FROM Studenti
EXCEPT
SELECT sId
FROM Prihlasky;

------------------------SPOJENÍ--------------------------------------------------------------------------------

/*D14. Najdi, id, jména a průměry studentů, kteří chodí na SPŠ a byli přijati alespoň na jednu univerzitu.*/
--theta join ON (dva sloupce Studenti.sId, Prihlasky.sId)

--natural join (jeden sloupec sID)

--join USING (jeden sloupec sID)

/*D15. Vytvoř přehled o studentech a jejích přihláškách, u všech studentů najdi, na jakou universitu se hlásí*/
/* LEFT JOIN */

/*D16. Najdi všechny studenty, kteří mají průměr větší než 2, nebo jejich průměr není zadaný. */
/* IS NULL, IS NOT NULL */

------------------------VNOŘENÉ DOTAZY--------------------------------------------------------------------------------

/*D17. Najdi průměry studentů, kteří se hlásí na IT.*/
/* vnořený dotaz do WHERE */
/* IN a NOT IN */

/* Alternativa D2a. Najdi všechny prihlášky na TUL a na KU*/

/* Alternativa D12. Najdi města, ve kterých studují studenti na střední škole, ale není tam universita.*/
/* rozdíl, když není podporován rozdíl */

/*D18. Najdi všechna jména universit, pro které platí, že ve stejném městě existuje ještě další universita.*/
/* podmnožina, kterou jde použít pro porovnání, 
pro každou univerzitu U1, testujeme, jestli existuje universita/y,
které jsou ve stejném městě a mají jiný název */ 

/*D19. Najdi jméno/a universit, které mají nejvyšší počet studentů.*/
/* pro každou universitu U1 testujeme jestli neexistuje universita/y,
které mají více studentů */
/* NOT EXISTS */ 

/*D20. Najdi jméno/a universit, kterých rozpočet je vyšší jako 500 mil.*/
/* vnorený dotaz do FROM */

/*D21. Najdi jména universit a k nim průměr nejlepšího studenta, který se na danou universitu hlásil.*/
/* vnořený dotaz v SELECT, vnořený dotaz musí vracet 1 hodnotu */

------------------------AGREGAČNÍ FUNKCE--------------------------------------------------------------------------------

/*D22. Najdi počet studentů*/
/* COUNT */
--počíta řádky

/*D22a. Najdi průměrný průměr studentů.*/
/* AVG */
/*počíta přes studenty s NOT NULL průměrem*/

/*D23. Najdi průměrný průměr studentů, kteří se hlásili na IT.*/ 

/*D24. Najdi počet studentů, kteří se hlásí na IT.*/

/*D24a. Najdi počet prihlášek na obor IT.*/

/*D25. Najdi kolik studentů se hlásí na kterou universitu.*/
/* GROUP BY vytváření skupin */

/*D26. Najdi kolik prihlášek podal každý student.*/ 

/*D26a. Najdi na kolik universit se hlásil každý student.*/

/*D26b. Najdi kolik prihlášek na které univerzity podal každý student.*/
--v SELECT jenom sloupce, přes které se dělá GROUP BY nebo agregační funkce 
--víc atribútů, aby pro podskupiny existoval jeden výsledek

/*D27. Najdi jmeno studenta s nejlepším průměrem*/
/* MIN */

/*D28. Najdi pro každé universitní město počet přihlášek.*/

/*D29. Najdi university, na které se hlásí víc než 2 (různí) studenti.*/
/* HAVING podmínka na skupinu */

------------------------OSTATNÍ--------------------------------------------------------------------------------

/*D30. Najdi první 2 záznamy ze Studentů*/

/*D31. Funkce*/
--aktuální datum GETDATE() v MS SQL

-- spojování řetezců

/*D32. Metadata - Najdi tabulky v databáze.*/
