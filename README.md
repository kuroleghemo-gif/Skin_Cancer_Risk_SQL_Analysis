# SQL-Based Skin Cancer Analysis for Early Detection

### Healthcare Analytics | PostgreSQL | Clinical Data Analysis

<img width="286" height="176" alt="image" src="https://github.com/user-attachments/assets/f59e0d14-ec83-420c-a897-933c98a7f7b8" />

## Table of Content
##### • [Project Overview](#project-overview)
##### • [Business Problem](#business-problem)
##### • [Project Objectives](#project-objective)
##### • [Data Sources](#data-sources)
##### • [Data Summary](#data-summary)
##### • [Team Collaboration](#team-collaboration)
##### • [Tools and Technologies](#tools-and-technologies)
##### • [Skills Demonstrated](#skills-demonstrated)
##### • [Methodology](#methodology)
##### • [Key Insights](#key-insights)
##### • [Business and Healthcare Impact](#business-and-healthcare-impact)
##### • [Future Improvements](#future-improvements)
##### • [Conclusion](#conclusion)


## Project Overview
Developed a SQL-driven healthcare analytics solution analyzing 1,089 clinical skin lesion records to identify demographic, environmental, and lesion-specific factors associated with malignant skin cancer.

This project demonstrates the application of SQL, relational database design, and healthcare analytics in transforming raw clinical data into machine-learning-ready datasets capable of supporting early detection research and AI-assisted diagnostic systems.

The analysis focused on uncovering high-risk patterns linked to:
* Age
* Gender
* Environmental exposure
* Skin type
* Lesion characteristics
* Tumour severity

This project was completed collaboratively within a 6-member analytics team as part of a healthcare SQL analytics capstone project.

## Business Problem
Skin cancer remains one of the most common and life-threatening diseases worldwide, with delayed diagnosis significantly reducing treatment success and survival outcomes. Healthcare systems continue to face challenges including:
* Misdiagnosis
* Limited access to dermatologists
* Poor understanding of environmental risk factors
* Lack of structured clinical datasets for AI development

This project addresses those challenges by building a structured healthcare analytics workflow capable of supporting:
* Early-stage detection research
* Clinical decision support
* Epidemiological analysis
* AI-ready healthcare datasets

## Project Objectives
* Design and structure a relational SQL database for clinical skin lesion analysis
* Identify demographic and environmental factors associated with malignant lesions
* Analyze lesion characteristics distinguishing malignant from benign tumours
* Prepare a machine-learning-ready dataset for downstream predictive modeling workflows
* Generate actionable healthcare insights using SQL-driven exploratory analysis

## Data Source
Dataset provided by 10Alytics as part of a healthcare SQL analytics capstone project focused on clinical skin lesion analysis and early cancer detection research.

## Dataset Summary
The dataset was already cleaned and comprises:
#### Clinical Dataset
* 1,089 skin lesion records
* 2 relational healthcare tables
* 29+ demographic and clinical variables

#### Patient_Info Table
Includes:
* Age
* Gender
* Smoking status
* Alcohol consumption
* Family cancer history
* Pesticide exposure
* Water access
* Sewage system access
* Ethnicity background

#### Lesion_Info Table
Includes:
* Lesion diagnosis type
* Fitzpatrick skin type
* Lesion diameter measurements
* Growth indicators
* Bleeding and pain symptoms
* Biopsy confirmation
* Lesion image metadata

## Team Collaboration
Led a 6-member analytics team in the design and analysis of a SQL-based healthcare dataset focused on early skin cancer detection.

## Tools & Technologies
* PostgreSQL
* pgAdmin 4
* SQL
* Relational Database Design
* Exploratory Data Analysis (EDA)
* Healthcare Analytics

## Skills Demonstrated
* Advanced SQL querying and analytical thinking
* Relational database design
* Clinical healthcare data analysis
* Business-oriented insight generation
* Machine learning data preparation
* End-to-end analytical workflow development
* Ability to translate raw healthcare data into actionable insights
* Cross-functional team collaboration

## Methodology

#### Database Design
Designed a normalized relational healthcare database integrating patient demographic data with lesion-specific clinical records using primary and foreign key relationships.

#### Data Preparation
Imported and validated structured healthcare datasets within PostgreSQL to ensure query reliability and analytical consistency.

#### SQL Analysis
Performed exploratory SQL analysis using:
* INNER JOIN operations
* Aggregations
* CASE statements
* Filtering logic
* Grouped statistical analysis

#### Analytics
Investigated relationships between:
* Age and malignant lesion prevalence
* Gender and tumour occurrence
* Environmental exposure and cancer risk
* Fitzpatrick skin type susceptibility
* Ethnicity background and lesion distribution
* Lesion size and malignancy

#### ML-Ready Data Structuring
Prepared structured metadata suitable for downstream machine learning and AI-assisted diagnostic workflows.

## Key Insights

#### Age-Related Cancer Risk
Malignant lesions were predominantly concentrated among individuals aged 60–70, reinforcing age as a major demographic risk factor.

#### Gender Distribution Patterns
Male patients consistently showed higher malignant lesion prevalence across most tumour categories, indicating increased cumulative environmental and occupational exposure risk.

#### Fitzpatrick Skin Type Correlation
Malignant lesions were overwhelmingly concentrated among lighter Fitzpatrick skin types, particularly Type II, aligning with established UV-mediated cancer formation patterns.

#### Environmental Exposure Findings
Pesticide exposure and piped water usage showed measurable association with increased malignant lesion occurrence, suggesting potential environmental carcinogen influence.

#### Lesion Size as a Diagnostic Indicator
Larger lesion diameters strongly correlated with malignant tumour classifications, while smaller lesions were predominantly benign.

## Business and Healthcare Impact
This project demonstrates how structured healthcare analytics can support:
* Early cancer detection initiatives
* AI-assisted dermatology systems
* Clinical decision support
* Epidemiological research
* Public health risk assessment
* Predictive healthcare workflows

The project also highlights the growing intersection between:
* Healthcare
* SQL analytics
* Machine learning readiness
* Clinical research
* Data-driven medical decision-making

## Future Improvements
* Build predictive skin lesion classification models
* Develop interactive healthcare dashboards
* Integrate Python-based machine learning workflows
* Expand analytical pipelines for real-time clinical reporting

## Conclusion
This project demonstrates how SQL and healthcare analytics can be leveraged to uncover clinically relevant patterns associated with skin cancer risk and malignancy.
By combining structured database engineering with healthcare-focused exploratory analysis, the project delivers a scalable analytical foundation capable of supporting future AI-driven diagnostic and early detection systems.
