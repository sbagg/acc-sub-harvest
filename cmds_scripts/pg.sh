#!/bin/bash  


create_local() {
    echo "Starting Creation of Tables...."
    while getopts u: flag
    do
        case "${flag}" in
            u) user=${OPTARG};;
        esac
    done
    $name= "acc"

    # psql -tc "SELECT 1 FROM pg_database WHERE datname = '$name'" | grep -q 1 | psql -U postgres -c "CREATE DATABASE $name"
    if [ "$( psql -tAc "SELECT 1 FROM pg_database WHERE datname='$name'" )" = '1' ]
    then
        echo "The database $name already exists.  Starting table creation."
    else
        psql -c "CREATE DATABASE $name"
    fi


    psql $name -c "CREATE EXTENSION adminpack;"
    psql $name -c "CREATE EXTENSION postgis;"

    psql $name -c "CREATE TABLE ETo(eto_id serial PRIMARY KEY, pid integer unique, type varchar(50),e double precision[], d double precision[], re double precision[], im double precision[]);"
    echo "Created Eto Table."

    psql $name -c "CREATE TABLE grid (grid_id serial PRIMARY KEY, pid integer, CONSTRAINT fk_ETo_grid FOREIGN KEY(pid) REFERENCES ETo(pid), east integer, north integer,resolution varchar(50),boundary geometry);"
    echo "Created Grid Table."

    psql $name -c "CREATE TABLE kc_cups(kc_cups_id serial PRIMARY KEY, id varchar(50) unique, type varchar(50), kc0 varchar(50), kc1 varchar(50), kcMid varchar(50), earlyT varchar(50), lateT varchar(50), midT varchar(50), label varchar(50));"
    echo "Created kc_cups Table."

    psql $name -c "CREATE TABLE kc_cups_dates(kc_cups_dates_id serial PRIMARY KEY, key varchar(50), type varchar(50), id varchar(50) unique, CONSTRAINT fk_cups_dates FOREIGN KEY(id) REFERENCES kc_cups(id),start_date varchar(50), end_date varchar(50), region varchar(50));"
    echo "Created kc_cups_dates Table."

    psql $name -c "CREATE TABLE calculations(calculations_id serial PRIMARY KEY, date varchar(50) unique, crop varchar(50) unique, kc_date varchar(50), kc_growth varchar(50), ETo varchar(50), ETc varchar(50), ETc_estimate varchar(50),creation_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);"
    echo "Created calculations Table."

    echo "Below is the database created/used"
    psql -c "\l $name"

    echo "Below is the tables created"
    psql $name -c "\d"

}

connect_instance() {
    while getopts p: flag
    do
        case "${flag}" in
            p) password=${OPTARG};;
        esac
    done
    # psql "sslmode=disable dbname=postgres user=postgres hostaddr=INSTANCE_IP"

}

# }

retrieve() {
    if [[ $1 -eq "kc_cups" ]]
    then
        if [ "$2" -eq "csv" ]
        then
        psql acc -c "\copy kc_cups to '../data/output/kc_cups.csv' csv header"
        else
        psql acc -c "\copy kc_cups to '../data/output/kc_cups.json'"
        fi
    elif [[ $1 -eq "kc_cups_dates" ]]
    then
        if [ "$2" -eq "csv" ]
        then
        psql acc -c "\copy kc_cups_dates to '../data/output/kc_cups_dates.csv' csv header"
        else
        psql acc -c "\copy kc_cups_dates to '../data/output/kc_cups_dates.json'"
        fi
    elif [[ $1 -eq "grid" ]]
    then
        if [ "$2" -eq "csv" ]
        then
        psql acc -c "\copy grid to '../data/output/grid.csv' csv header"
        else
        psql acc -c "\copy grid to '../data/output/grid.json'"
        fi
    elif [[ $1 -eq "eto" ]]
    then
        if [ "$2" -eq "csv" ]
        then
        psql acc -c "\copy eto to '../data/output/eto.csv' csv header"
        else
        psql acc -c "\copy eto to '../data/output/eto.json'"
        fi
    else
    echo "This is not one of the accessible tables; choose from kc_cups, kc_cups_dates, grid, or eto."
    fi
}

# run_equation(){
#     echo "Starting Equation Call..."
    
#     while getopts q:E:D:d:N:e:k:s: flag
#     do
#         case "${flag}" in
#             q) equation=${OPTARG};;
#             E) E=${OPTARG};;
#             D) D=${OPTARG};;
#             d) d=${OPTARG};;
#             N) N=${OPTARG};;
#             e) et=${OPTARG};;
#             k) kc=${OPTARG};;
#             s) sample=${OPTARG};;
#         esac
#     done

#     if [ -z "$equation" ]
#     then
#         echo "Equation is not input....Exiting Program"
#         exit 125
#     fi

#     val=$(node functions.js --equation=$equation ${sample:+--sample=$sample} ${E:+--E=$E} ${D:+--D=$D} ${d:+--d=$d} ${N:+--N=$N} ${et:+--et=$et} ${kc:+--kc=$kc})

#     #insert_calc $val $equation
# }

"$@"
