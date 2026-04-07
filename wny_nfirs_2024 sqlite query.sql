-- Project:  Western New York Home Fire Analysis
-- Purpose:  Identify residential fire incidents across the
--           26 counties of the Red Cross Western NY Region
-- Data:     National Fire Incident Report (NFIRS) 2024, NYS Fire Department Locations,
-- Platform: SQLite
-- Author:   [Your Name]

WITH unique_depts AS (
    -- Remove duplicates from NYS Fire Departments so each FDID appears once
    -- Prevents many-to-many joins when joining to NFIRS
    SELECT
        "Fire Department Code" AS fdid,
        "County Name"          AS county,
        "County Code"          AS county_code,
        state
    FROM NYS_Fire_Departments
    WHERE "County Code" IN (2,4,5,6,7,8,9,12,13,15,19,26,28,32,35,37,39,49,50,51,53,54,55,59,61,62)
    -- County codes represent the 26 counties in the Red Cross Western NY Region
    GROUP BY 1, 2, 3, 4
)

SELECT
    b.INCIDENT_KEY,
    d.county,
    d.county_code,
    -- NFIRS stores inc_date as mmddyyyy text
    -- Normalizing date column to a proper date format: yyyy-mm-dd
    DATE(
        substr(b.inc_date, 5, 4) || '-' ||
        substr(b.inc_date, 1, 2) || '-' ||
        substr(b.inc_date, 3, 2)
    ) AS inc_date,
    a.Match_addr,
    a.ZIP5,
    b.INC_TYPE,
    b.PROP_USE
FROM basicincident b
INNER JOIN unique_depts d    ON b.FDID = d.fdid
                             AND b.STATE = d.state
                             -- Joining on both FDID and state
                             -- FDID alone is not unique nationally
INNER JOIN incidentaddress a ON b.INCIDENT_KEY = a.INCIDENT_KEY
WHERE b.STATE = 'NY'
  AND b.INC_TYPE LIKE '1%'
    -- 100-series INC_TYPE = fire incidents only (According to NFIRS fire codes)
    -- Excludes EMS (300s), false alarms (700s), and all other non-fire calls
  AND b.PROP_USE IN ('419', '429')
    -- 419 = 1 or 2 family dwelling
    -- 429 = Multifamily dwelling
    -- Restricts to residential properties that align with Red Cross mission
ORDER BY inc_date DESC;