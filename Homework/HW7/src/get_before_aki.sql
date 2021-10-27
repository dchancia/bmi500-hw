WITH allaki AS
-- Find patients from the ICU that met criteria for 
-- AKI based on the kdigo_stages file from the
-- derived folder. The AKI stage was assigned based
-- on the cratinine serum and the urine output
(
SELECT 
    ks.icustay_id 
    , ks.charttime
    , ks.aki_stage
FROM physionet-data.mimiciii_derived.kdigo_stages ks
WHERE ks.aki_stage != 0 AND ks.creat is not null
)
, aki AS
-- Find the first time a patient met the conditions for 
-- AKI during the same ICU visit
(
    SELECT 
        ks.icustay_id 
        , MIN(ks.charttime) AS timeakidetected
    FROM physionet-data.mimiciii_derived.kdigo_stages ks
    WHERE ks.aki_stage != 0 AND ks.creat is not null
    GROUP BY ks.icustay_id
)
, firstaki AS
-- Find the first time a patient met the conditions for 
-- AKI 
(
    SELECT 
        icu.subject_id
        , MIN(aki.timeakidetected) as firsttime
    FROM aki 
    INNER JOIN physionet-data.mimiciii_clinical.icustays icu
    ON aki.icustay_id = icu.icustay_id
    GROUP BY icu.subject_id
    ORDER BY icu.subject_id
)
, addstage AS
-- Add AKI stage for each patient
(
    SELECT
        firstaki.subject_id
        , firstaki.firsttime
        , allaki.aki_stage
    FROM firstaki 
    INNER JOIN allaki 
    ON firstaki.firsttime = allaki.charttime
)
, beforeaki AS
(
-- Find the lab events that happened between 12 to 6 hours
-- before the patient met the conditions for the first time
    SELECT 
        fa.subject_id
        , fa.aki_stage
        , le.itemid
        , le.valuenum
    FROM addstage fa
    INNER JOIN physionet-data.mimiciii_clinical.labevents le
    ON fa.subject_id = le.subject_id
    WHERE le.charttime <= DATETIME_SUB(fa.firsttime, INTERVAL 6 HOUR)
    AND le.charttime >= DATETIME_SUB(fa.firsttime, INTERVAL 12 HOUR)
    AND le.valuenum is not null
    ORDER BY fa.subject_id, le.itemid
)
-- Add the selected biomarkers for each patient during the
-- interval of 6 hours
, creatblood AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 50912
)
, lactate AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 50954
)
, glucose AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 50931
)
, bicarbonate AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 50882
)
, hemoglobin AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 51222
)
, platelet AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 51265
)
, potassium AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 50971
)
, nitrogen AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 51006
)
, whitecells AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 51301
)
, calcium AS
(
    SELECT *
    FROM beforeaki 
    WHERE beforeaki.itemid = 50893
)
SELECT 
    beforeaki.subject_id
    , beforeaki.aki_stage
    , AVG(creatblood.valuenum) AS creatinine_blood
    , AVG(lactate.valuenum) AS lactate_dehyd
    , MAX(glucose.valuenum) AS glucose
    , MIN(bicarbonate.valuenum) AS bicarbonate
    , MIN(hemoglobin.valuenum) AS hemoglobin
    , MIN(platelet.valuenum) AS platelet_count
    , MAX(potassium.valuenum) AS potassium
    , MAX(nitrogen.valuenum) AS urea_nitrogen
    , MAX(whitecells.valuenum) AS white_cells
    , MIN(calcium.valuenum) AS calcium_blood
FROM beforeaki 
RIGHT JOIN creatblood 
ON beforeaki.subject_id = creatblood.subject_id
RIGHT JOIN lactate 
ON beforeaki.subject_id = lactate.subject_id
RIGHT JOIN glucose
ON beforeaki.subject_id = glucose.subject_id
RIGHT JOIN bicarbonate 
ON beforeaki.subject_id = bicarbonate.subject_id
RIGHT JOIN hemoglobin  
ON beforeaki.subject_id = hemoglobin.subject_id
RIGHT JOIN platelet 
ON beforeaki.subject_id = platelet.subject_id
RIGHT JOIN potassium 
ON beforeaki.subject_id = potassium.subject_id
RIGHT JOIN nitrogen 
ON beforeaki.subject_id = nitrogen.subject_id
RIGHT JOIN whitecells 
ON beforeaki.subject_id = whitecells.subject_id
RIGHT JOIN calcium 
ON beforeaki.subject_id = calcium.subject_id
GROUP BY beforeaki.subject_id, beforeaki.aki_stage
ORDER BY beforeaki.subject_id