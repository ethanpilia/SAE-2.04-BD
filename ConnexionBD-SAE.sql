/*==============================================================*/
/* C) DROITS ET PRIVILEGES*/
/*==============================================================*/

-- Vérification de la vue MATCH_USA_JUIN2026
SELECT *
FROM brod0022.MATCH_USA_JUIN2026;

/* Modifier la date du match aux Etats-Unis du 15 juin 2026 */
UPDATE brod0022.MATCH_USA_JUIN2026
SET DATEMATCH = DATEMATCH + 10
WHERE TRUNC(DATEMATCH)=TO_DATE('15/06/2026','DD/MM/YYYY');

/* Supprimer les achats pour des matchs aux Etats-Unis en juin 2026
   dont la date d'achat est postérieure à aujourd'hui */
DELETE FROM BROD0022.ACHAT
WHERE DATEACHAT>SYSDATE 
AND NUMMATCH IN (
SELECT m.NUMMATCH
FROM BROD0022.MATCH_USA_JUIN2026 m
JOIN BROD0022.STADE st ON m.CDSTD=st.CDSTD
WHERE st.CDPAYS='USA'
AND TRUNC(m.DATEMATCH) BETWEEN DATE '2026-06-01' AND DATE '2026-06-30'
);