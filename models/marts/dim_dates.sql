with 
    date_spine as (

        -- usings dbt_utils package to create dim_dates
        {{ dbt_utils.date_spine(
            datepart="day"
            , start_date="cast('1970-01-01' as date)"
         , end_date="current_date + (365*10)"
        )}}

    )

    , datetime as (
        select

            -- timestamp
            cast(date_day as timestamp) as date_time

        from date_spine
    )

    , date_only as (
        select

            -- extracting full date 
            extract(date from date_time) as full_date

        from datetime
    )

    , calendar as (
        select

            -- extracting full date, year, month and day
            full_date
            , extract(year from full_date) as year
            , extract(day from full_date) as day
            , extract(month from full_date) as month

        from date_only
    )

    , full_calendar as (
        select 
            
            -- adding columns from calendar
            full_date
            , year
            , day
            , month 

            -- month names
            ,  CASE
                WHEN month = 1 THEN 'Janeiro'
                WHEN month = 2 THEN 'Fevereiro'
                WHEN month = 3 THEN 'Março'
                WHEN month = 4 THEN 'Abril'
                WHEN month = 5 THEN 'Maio'
                WHEN month = 6 THEN 'Junho'
                WHEN month = 7 THEN 'Julho'
                WHEN month = 8 THEN 'Agosto'
                WHEN month = 9 THEN 'Setembro'
                WHEN month = 10 THEN 'Outubro'
                WHEN month = 11 THEN 'Novembro'
                WHEN month = 12 THEN 'Dezembro'
            END AS month_name

        from calendar
    )

    , moth_year_calendar as (
        select

            -- columns from full_calendar 
            full_date
            , year
            , day
            , month
            , month_name

            -- concatenating month name and year
            , month_name || '/' || year as month_year

        from full_calendar
    )

select *
from moth_year_calendar
order by full_date desc