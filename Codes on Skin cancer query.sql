--EXPLORING TABLE 2

SELECT *
FROM table2;

--Identify environmental and demographic risk factors that correlate with specific skin lesions

--Demographic Risk Factors

--Q1. How does age distribution differ across specific skin lesion types
SELECT
	l.diagnostic AS skin_lesion_type,
	ROUND(AVG (p.age)) AS ave_age
FROM table1 p
JOIN table2 l
ON p.patient_id = l.patient_id
GROUP BY l.diagnostic;

--Q2. Find out if male/female are more associated with certain lesion
SELECT 
	l.diagnostic AS skin_lesion_type,
	p.gender,
	COUNT (*) AS gender_count
FROM table1 p
JOIN table2 l
ON p.patient_id = l.patient_id
GROUP BY l.diagnostic, p.gender
ORDER BY l.diagnostic, p.gender;

--Q3. Which age and gender groups have the highest proportion of malignant lesions?
SELECT
    CASE 
        WHEN p.age < 30 THEN '<30'
        WHEN p.age BETWEEN 30 AND 49 THEN '30-49'
        WHEN p.age BETWEEN 50 AND 69 THEN '50-69'
        ELSE '70+'
    END AS age_group,
    p.gender,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
      100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
      / COUNT(*),
      1
    ) AS malignant_pct
FROM table1 p
JOIN table2 l
  ON p.patient_id = l.patient_id
GROUP BY age_group, p.gender
ORDER BY age_group, p.gender;

--Q4. Does Fitzpatrick skin type relate to malignancy rate?
SELECT
    l.fitspatrick,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
      100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
      / COUNT(*),
      1
    ) AS malignant_pct
FROM table2 l
GROUP BY l.fitspatrick
ORDER BY l.fitspatrick;

--Q5. Are certain ethnic backgrounds more represented among malignant lesions?
SELECT
    p.background_father,
    p.background_mother,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions
FROM table1 p
JOIN table2 l
  ON p.patient_id = l.patient_id
GROUP BY p.background_father, p.background_mother
ORDER BY malignant_lesions DESC;

--Q6. Simple binary target (malignant vs non-malignant) using diagnostic

SELECT lesion_id,
       diagnostic,
       CASE 
         WHEN diagnostic IN ('MEL','BCC','SCC') THEN 1
         ELSE 0
       END AS is_malignant
FROM table2
GROUP BY lesion_id, diagnostic
ORDER BY lesion_id, diagnostic;


--ENVIRONMENTAL RISK FACTORS

--Q1. Does pesticide exposure correlate with malignant lesions?

SELECT
    p.pesticide,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
      100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
      / COUNT(*),
      1
    ) AS malignant_pct
FROM table1 p
JOIN table2 l
  ON p.patient_id = l.patient_id
GROUP BY p.pesticide;


--Q2. Is smoking associated with more malignant lesions?
SELECT
    p.smoke,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
      100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
      / COUNT(*),
      1
    ) AS malignant_pct
FROM table1 p
JOIN table2 l
  ON p.patient_id = l.patient_id
GROUP BY p.smoke;

--Q3. Is drinking associated with more malignant lesions?
SELECT
    p.drink,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
      100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
      / COUNT(*),
      1
    ) AS malignant_pct
FROM table1 p
JOIN table2 l
  ON p.patient_id = l.patient_id
GROUP BY p.drink;

--Do water/sewage access (environment/socioeconomic proxies) relate to malignancy?
SELECT
    p.has_piped_water,
    p.has_sewage_system,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
      100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
      / COUNT(*),
      1
    ) AS malignant_pct
FROM table1 p
JOIN table2 l
  ON p.patient_id = l.patient_id
GROUP BY p.has_piped_water, p.has_sewage_system;

--AIM 3: Analyze lesion characteristics to find patterns that indicate cancerous vs. benign lesions
SELECT
    CASE 
        WHEN (l.diameter_1 + l.diameter_2) / 2.0 < 5  THEN '<5 mm'
        WHEN (l.diameter_1 + l.diameter_2) / 2.0 BETWEEN 5 AND 9 THEN '5–9 mm'
        WHEN (l.diameter_1 + l.diameter_2) / 2.0 BETWEEN 10 AND 19 THEN '10–19 mm'
        ELSE '20+ mm'
    END AS size_category,
    CASE 
        WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 'Malignant'
        ELSE 'Benign'
    END AS malignancy_group,
    COUNT(*) AS lesion_count
FROM table2 l
GROUP BY size_category, malignancy_group
ORDER BY size_category, malignancy_group;


--AIM 4: To reate a ml-ready dataset that supports AI-based early detection of skin cancer using structured metadata.

CREATE OR REPLACE VIEW ml_skin_cancer_dataset AS
SELECT
    l.lesion_id,
    l.img_id,
    l.patient_id,

    CASE 
        WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1
        ELSE 0
    END AS is_malignant,

--patient features
    p.age,
    p.gender,
    p.smoke,
    p.drink,
    p.pesticide,
    p.skin_cancer_history,
    p.cancer_history,
    p.has_piped_water,
    p.has_sewage_system,
    p.background_father,
    p.background_mother,
	
    l.fitspatrick,
    l.region,
    (l.diameter_1 + l.diameter_2) / 2.0 AS mean_diameter_mm,
    l.itch,
    l.grew,
    l.hurt,
    l.changed,
    l.bleed,
    l.elevation,
    l.biopsed
FROM table2 l
JOIN table1 p
  ON p.patient_id = l.patient_id;

-- 3.2 Business question: Which symptoms are more common in malignant lesions, Use your symptom flags (itch, grew, hurt, changed, bleed, elevation)?

SELECT
    CASE 
        WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 'Malignant'
        ELSE 'Benign'
    END AS malignancy_group,
    AVG(CASE WHEN l.itch      THEN 1 ELSE 0 END) AS pct_itch,
    AVG(CASE WHEN l.grew      THEN 1 ELSE 0 END) AS pct_grew,
    AVG(CASE WHEN l.hurt      THEN 1 ELSE 0 END)AS pct_changed,
    AVG(CASE WHEN l.bleed     THEN 1 ELSE 0 END) AS pct_bleed,
    AVG(CASE WHEN l.elevation THEN 1 ELSE 0 END) AS pct_elevation
FROM table2 l
GROUP BY malignancy_group;

--Q Do specific body regions have more malignant lesions?

SELECT
    l.region,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
        100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS malignant_pct
FROM table2 l
GROUP BY l.region
ORDER BY malignant_pct DESC;


--Which combinations of symptoms are particularly risky? Group by symptom combinations to find “danger patterns
SELECT
    l.itch,
    l.grew,
    l.changed,
    l.bleed,
    l.elevation,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
        100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS malignant_pct
FROM table2 l
GROUP BY
    l.itch, l.grew, l.changed, l.bleed, l.elevation
HAVING COUNT(*) >= 5   -- optional: only show patterns with enough cases
ORDER BY malignant_pct DESC, total_lesions DESC;


-- How do lesion characteristics differ by diagnosis type? Compare each diagnosis (MEL, BCC, NEV, etc.) on size and symptoms.
SELECT
    l.diagnostic,
    AVG((l.diameter_1 + l.diameter_2) / 2.0) AS avg_size_mm,
    AVG(CASE WHEN l.itch      THEN 1 ELSE 0 END) AS pct_itch,
    AVG(CASE WHEN l.grew      THEN 1 ELSE 0 END) AS pct_grew,
    AVG(CASE WHEN l.changed   THEN 1 ELSE 0 END) AS pct_changed,
    AVG(CASE WHEN l.bleed     THEN 1 ELSE 0 END) AS pct_bleed,
    AVG(CASE WHEN l.elevation THEN 1 ELSE 0 END) AS pct_elevation,
    COUNT(*) AS lesion_count
FROM table2 l
GROUP BY l.diagnostic
ORDER BY lesion_count DESC;

--AIM 5:Enhance dermatological research by providing a well-organized dataset for epidemiological studies and AI model training

--Q1. Incidence pattern by lesion type and body region:

SELECT
    l.diagnostic,
    l.region,
    COUNT(*) AS lesion_count,
    ROUND(
      100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY l.diagnostic),
      1
    ) AS pct_of_type
FROM table2 l
GROUP BY l.diagnostic, l.region
ORDER BY l.diagnostic, lesion_count DESC;

-- Q2. Do personal or family history relate to current malignant lesions?
SELECT
    p.skin_cancer_history,
    p.cancer_history,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END) AS malignant_lesions,
    ROUND(
      100.0 * SUM(CASE WHEN l.diagnostic IN ('MEL','BCC','SCC') THEN 1 ELSE 0 END)
      / COUNT(*),
      1
    ) AS malignant_pct
FROM table1 p
JOIN table2 l
  ON p.patient_id = l.patient_id
GROUP BY p.skin_cancer_history, p.cancer_history;







