# wny_home_fire_analysis_nfirs_2024
This project analyzes residential home fire incidents across the 26 counties of the Red Cross Western New York region using 2024 data. The goal is to identify where home fires are occurring and how well Red Cross resources are aligned with community need.

# Data Sources
- NFIRS 2024 — National Fire Incident Reporting System, published by FEMA/USFA. Contains fire incident reports submitted by local fire departments across the US.
- NYS Fire Department Locations — New York State fire department registry. Used to link NFIRS incidents to counties and geographic coordinates.
- CDC Social Vulnerability Index — Used to identify communities with high social vulnerability for equity analysis.

#What the Query Does
The SQL script joins NFIRS incident data to NYS fire department locations to identify residential home fires in Western New York. It filters for:
- Fire incidents only (NFIRS 100-series incident types)
- Residential properties (property use codes 419 and 429)
- The 26 counties that make up the Red Cross Western NY region

Results are aggregated by county and can be used to compare fire incident volume across the region.

#Tools Used
- SQLite via DataGrip
- Power BI for visualization

#Data Caveats
- NFIRS is a voluntary reporting system. Not all fire departments report every incident, so fire counts may undercount actual residential fires in some counties.
- Some counties show limited NFIRS data due to inconsistent field reporting by local fire departments. Monroe County in particular shows lower incident counts than expected due to sparse property use field completion.
- Small counties with low incident counts should be interpreted carefully. A single multifamily fire can significantly affect ratios in counties with few total incidents.

# Notes
Red Cross Home Fire Response data is not included in this repository as it contains proprietary information. The SQL script and findings are based entirely on publicly available data sources.
