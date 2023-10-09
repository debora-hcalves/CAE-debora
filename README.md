# Analytics Engineer Certification

Repository to be used in the challenge for obtaining the Analytics Engineer certification by Indicium. Fork this repository and use it during the challenge to ingest the SAP tables from Adventure Works.

## Table of Contents

- [The Certification](#the-certification)
- [Context](#context)
- [Data Description](#data-description)
- [Results](#results)
- [Getting Started](#getting-started)
- [Oauth](#oauth)
- [dbt Setup](#dbt-setup)
- [Instructions for Data Ingestion (EL)](#instructions-for-data-ingestion-el)
- [Resources](#resources)

## The Certification

The aim of this certification is to assess your skills in a practical Analytics Engineering project following the methodology of the Modern Analytics Stack, developed by Indicium but closely resembling the Modern Data Stack used by thousands of modern data teams.

Achieving this certification indicates that you:

Understand the process of building a modern analytics platform.
Comprehend the goals of dimensional modeling in modern data warehouses.
Are proficient in applying SQL language and the dbt tool for data modeling in modern data warehouses.
Have knowledge of best practices in data visualization and their application in a Self-Service BI tool.

## Context

Adventure Works, a growing bicycle company, aims to become data-driven and use its data for strategic decision-making. The data project started with a focus on sales. The CEO demands data quality and accuracy and requests validation tests.

## Data Description

Adventure Works has a transactional database (PostgreSQL) that stores data from its various departments. This data is distributed across 68 tables divided into 5 schemas: HR (human resources), sales, production, and purchasing.
To access the complete diagram, please use this [link.](https://github.com/dpavancini/analytics-engineering/blob/main/AdventureWorks/AdventureWorksERD.jpeg)

## Results

Adventure Works trusts in your technical ability to design and implement its modern analytics infrastructure from start to finish, which should include items 1 through 4 below.

1. Conceptual data warehouse diagram in PDF format: create the conceptual model with the necessary fact and dimension tables to answer the business questions in item 4. Provide a concise overview of the source tables used to create each dimension and the fact table. 
2. Cloud data warehouse configuration and dbt setup. Suggestion: Google Bigquery.
3. Data transformation: transform raw data using dbt. This transformation should include the following points:
    - Documentation of tables and columns in the marts
    - Source tests
    - Tests on the primary keys of dimension and fact tables
    - Data testing (Gross sales for 2011 matched the amount of $12,646,112.16)
    - The code needs to be in a repository (suggestion: github).
4. BI Dashboards: create in a tool of your choice, but one that allows you to answer the following business questions:
    - What is the number of orders, quantity purchased, total negotiated value per product, card type, sale reason, sale date, customer, status, city, state, and country?
    - What are the products with the highest average ticket per month, year, city, state, and country? (Average ticket = Gross revenue - product discounts / number of orders in the analysis period)
    - Who are the top 10 customers by total negotiated value, filtered by product, card type, sale reason, sale date, status, city, state, and country?
    -  What are the top 5 cities by total negotiated value, filtered by product, card type, sale reason, sale date, customer, status, city, state, and country
    - What is the number of orders, quantity purchased, total negotiated value per month and year?
    - Which product has the highest quantity purchased for the sale reason "Promotion"?


## Getting Started
1. To use this repository locally, first clone it to your local machine:

`git clone https://github.com/debora-hcalves/analytics-engineer-certification.git`

2. After cloning, create a [virtual environment](https://virtualenv.pypa.io/en/latest/installation.html) for the installation. The recommended python version for dbt is 3.8 and any of its patches. For Linux: 

`python3.8 -m venv venv`

3. To activate the virtual environment, use the following code for Linux:

`source venv/bin/activate`.

Ensure that you are in the folder where the virtual environment was created. If it is activated correctly, the terminal will display a flag (venv). To deactivate the virtual environment, simply run the command: `deactivate`

4. Install the requirements from the project:

`pip install requirements.txt`

5. Install project dependencies:

`dbt deps`

5. By invoking dbt from the CLI, it should parse `dbt_project.yml` and, in case it doesn't already exist, create a `~/.dbt/profiles.yml`. This file exists outside of the project to avoid sensitive credentials in the version control code and it's not recommended to change it's location. 

## Oauth

6. Oauth - Follow the GCP CLI installation guide [here](https://cloud.google.com/sdk/docs/install?hl=en). After the installation, run `gcloud init` and provide the requested account information in order to properly setup your Oauth GCP account.

7. Open the `profiles.yml` file and add the following configurations:

```
# Note that only one of these targets is required

my-bigquery-db:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: oauth
      project: [GCP project id]
      dataset: [the name of your dbt dataset] # You can also use "schema" here
      threads: [1 or more]

```

## dbt Setup

8. Following best practices, a dbt project informs dbt about the contect of your project and how to transform your data. To do so, open the dbt_project.yml project configuration file on your dbt project folder.

```
# Name your project! Project names should contain only lowercase characters
# and underscores. A good package name should reflect your organization's
# name or the intended use of these models
name: 'analytics-engineer-certification' # <-- Name of the project.
version: '1.0.0'
config-version: 2

# This setting configures which "profile" dbt uses for this project.
profile: 'default'

# These configurations specify where dbt should look for different types of files.
# The `source-paths` config, for example, states that models in this project can be
# found in the "models/" directory. You probably won't need to change these!
model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target"  # directory which will store compiled SQL files
clean-targets:         # directories to be removed by `dbt clean`
  - "target"
  - "dbt_packages"


# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

# In this example config, we tell dbt to build all models in the example/ directory
# as tables. These settings can be overridden in the individual model files
# using the `{{ config(...) }}` macro.

models:
  # Be sure to namespace your model configs to your project name
  analytics-engineer-certification:
      database: my_bigquery_db # Name of your Bigquery database
      staging:
        +materialized: table
      intermediate:
        +materialized: ephemeral
      marts:
        +materialized: table


seeds:
  analytics-engineer-certification: # <-- Name of the project. If you renamed your project you have to change this as well
    database: my_bigquery_db # Name of your Bigquery database
    schema: sap_adw

```

9. You can also execute the command `dbt debug` to ensure that all configurations are working correctly, and it is possible to initiate data loading and transformation.



## Instructions for Data Ingestion (EL)

All tables from the source SAP database of Adventure Works will be loaded as seeds by dbt. The `.csv` files with the data are already in the seeds folder.

To load all tables, use the command:

`dbt seed`

To load a specific table, use the command:

`dbt seed -s csv_file_name`


## Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
