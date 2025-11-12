--1 Zutaten eines Rezepts abrufen
DELIMITER //
CREATE PROCEDURE GetZutatenEinesRezepts(IN p_RezeptID INT)
BEGIN
  SELECT r.Name AS Rezeptname,
         z.Name AS Zutat,
         rz.Menge,
         rz.Einheit
  FROM Rezept_Zutat rz
  INNER JOIN Zutat z ON rz.Zutat_ID = z.Zutat_ID
  INNER JOIN Rezept r ON rz.Rezept_ID = r.Rezept_ID
  WHERE r.Rezept_ID = p_RezeptID;
END //
DELIMITER ;
--„Zutaten eines Rezepts abrufen“
--Verwendet INNER JOIN


--2 Rezepte mit bestimmter Zutat finden
DELIMITER //
CREATE PROCEDURE GetRezepteMitZutat(IN p_ZutatName VARCHAR(255))
BEGIN
  SELECT DISTINCT r.Rezept_ID, r.Name AS Rezeptname
  FROM Rezept r
  INNER JOIN Rezept_Zutat rz ON r.Rezept_ID = rz.Rezept_ID
  INNER JOIN Zutat z ON rz.Zutat_ID = z.Zutat_ID
  WHERE z.Name = p_ZutatName;
END //
DELIMITER ;
--Deckt ab: „Rezepte mit bestimmter Zutat finden“
--Verwendet INNER JOIN und DISTINCT


--3 Anzahl Rezepte nach Ernährungskategorie
DELIMITER //
CREATE PROCEDURE CountRezepteNachKategorie()
BEGIN
  SELECT k.Name AS Kategorie,
         COUNT(r.Rezept_ID) AS Anzahl_Rezepte
  FROM Kategorie k
  LEFT JOIN Rezept_Kategorie rk ON k.Kategorie_ID = rk.Kategorie_ID
  LEFT JOIN Rezept r ON rk.Rezept_ID = r.Rezept_ID
  GROUP BY k.Name;
END //
DELIMITER ;
-- Deckt ab: „Anzahl Rezepte nach Ernährungskategorie“
-- Verwendet LEFT JOIN + Aggregatfunktion COUNT()


--4 Durchschnittliche Nährwerte pro Bestellung eines Kunden
DELIMITER //
CREATE PROCEDURE AvgNaehrwerteProBestellung(IN p_KundeID INT)
BEGIN
  SELECT b.Bestell_ID,
         AVG(n.Kalorien) AS avg_kcal,
         AVG(n.Protein) AS avg_protein,
         AVG(n.Kohlenhydrate) AS avg_kohlenhydrate,
         AVG(n.Fett) AS avg_fett
  FROM Bestellung b
  INNER JOIN Bestellung_Rezept br ON b.Bestell_ID = br.Bestell_ID
  INNER JOIN Rezept_Zutat rz ON br.Rezept_ID = rz.Rezept_ID
  INNER JOIN Naehrwerte n ON rz.Zutat_ID = n.Zutat_ID
  WHERE b.Kunde_ID = p_KundeID
  GROUP BY b.Bestell_ID;
END //
DELIMITER ;
-- Deckt ab: „Durchschnittliche Nährwerte berechnen“
-- Verwendet Aggregatfunktionen (AVG), mehrere INNER JOINs


--5 Unverknüpfte Zutaten identifizieren
DELIMITER //
CREATE PROCEDURE GetUnverknuepfteZutaten()
BEGIN
  SELECT z.Zutat_ID, z.Name
  FROM Zutat z
  LEFT JOIN Rezept_Zutat rz ON z.Zutat_ID = rz.Zutat_ID
  WHERE rz.Zutat_ID IS NULL;
END //
DELIMITER ;
-- Deckt ab: „Unverknüpfte Zutaten identifizieren“
-- Verwendet LEFT JOIN mit IS NULL


--6  Rezepte nach maximaler Kalorienmenge
DELIMITER //
CREATE PROCEDURE GetRezepteNachKalorien(IN p_MaxKalorien INT)
BEGIN
  SELECT r.Rezept_ID, r.Name, r.Kalorien_SUM
  FROM Rezept r
  WHERE r.Kalorien_SUM <= p_MaxKalorien;
END //
DELIMITER ;
-- Deckt ab: „Rezepte nach Kalorienmenge filtern“


--7 Rezepte mit weniger als fünf Zutaten
DELIMITER //
CREATE PROCEDURE GetRezepteMitWenigenZutaten()
BEGIN
  SELECT r.Rezept_ID, r.Name, COUNT(rz.Zutat_ID) AS Zutaten_Anzahl
  FROM Rezept r
  INNER JOIN Rezept_Zutat rz ON r.Rezept_ID = rz.Rezept_ID
  GROUP BY r.Rezept_ID
  HAVING COUNT(rz.Zutat_ID) < 5;
END //
DELIMITER ;
--Deckt ab: „Rezepte mit wenigen Zutaten finden“
--Verwendet Aggregatfunktion COUNT() + HAVING


--8 Kombinierter Filter (weniger als 5 Zutaten UND bestimmte Kategorie)
DELIMITER //
CREATE PROCEDURE GetRezepteMitFilter(IN p_KategorieName VARCHAR(100))
BEGIN
  SELECT r.Rezept_ID, r.Name
  FROM Rezept r
  INNER JOIN Rezept_Zutat rz ON r.Rezept_ID = rz.Rezept_ID
  INNER JOIN Rezept_Kategorie rk ON r.Rezept_ID = rk.Rezept_ID
  INNER JOIN Kategorie k ON rk.Kategorie_ID = k.Kategorie_ID
  GROUP BY r.Rezept_ID
  HAVING COUNT(rz.Zutat_ID) < 5 AND k.Name = p_KategorieName;
END //
DELIMITER ;
--Deckt ab: „Kombinierte Filter“
--Verwendet GROUP BY + HAVING + INNER JOIN


--10 Zusatz-Abfragen (eigene Ideen)
-- a) Top 5 meistgenutzten Zutaten in Rezepten
DELIMITER //
CREATE PROCEDURE GetTopZutaten()
BEGIN
  SELECT z.Name, COUNT(rz.Rezept_ID) AS Verwendung
  FROM Zutat z
  INNER JOIN Rezept_Zutat rz ON z.Zutat_ID = rz.Zutat_ID
  GROUP BY z.Zutat_ID
  ORDER BY Verwendung DESC
  LIMIT 5;
END //
DELIMITER ;

-- b) Durchschnittlicher Preis eines Rezepts basierend auf Zutatenpreisen
DELIMITER //
CREATE PROCEDURE GetRezeptDurchschnittspreis()
BEGIN
  SELECT r.Name AS Rezept,
         SUM(z.Preis * rz.Menge) AS Gesamtpreis
  FROM Rezept r
  INNER JOIN Rezept_Zutat rz ON r.Rezept_ID = rz.Rezept_ID
  INNER JOIN Zutat z ON rz.Zutat_ID = z.Zutat_ID
  GROUP BY r.Rezept_ID;
END //
DELIMITER ;

-- c) Kunden mit den meisten Bestellungen
DELIMITER //
CREATE PROCEDURE GetTopKunden()
BEGIN
  SELECT k.Kunde_ID, k.Name, COUNT(b.Bestell_ID) AS Anzahl_Bestellungen
  FROM Kunde k
  LEFT JOIN Bestellung b ON k.Kunde_ID = b.Kunde_ID
  GROUP BY k.Kunde_ID
  ORDER BY Anzahl_Bestellungen DESC;
END //
DELIMITER ;
-- Deckt ab: „Eigenständige Abfragen“ + „komplexe SQL-Elemente“



----------------------------
-- Beispielrollen
CREATE ROLE 'gast';
CREATE ROLE 'admin';

-- Beispiel-View: Gast darf nur Rezeptnamen und Zutaten sehen, keine Preise
CREATE VIEW V_Rezept_Gast AS
SELECT r.Name AS Rezept, z.Name AS Zutat, rz.Menge, rz.Einheit
FROM Rezept r
INNER JOIN Rezept_Zutat rz ON r.Rezept_ID = rz.Rezept_ID
INNER JOIN Zutat z ON rz.Zutat_ID = z.Zutat_ID;

GRANT SELECT ON V_Rezept_Gast TO 'gast';

-- Beispiel-Trigger: Datenschutz-Flag prüfen vor INSERT
DELIMITER //
CREATE TRIGGER check_datenschutz
BEFORE INSERT ON Kunde
FOR EACH ROW
BEGIN
  IF NEW.Datenschutz = FALSE THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datenschutz muss aktiv sein!';
  END IF;
END //
DELIMITER ;
