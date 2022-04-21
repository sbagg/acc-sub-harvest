
####################################################
####################################################
## TOO BE DEVELOPED WITH COMMAND LINE FUNCTIONALITY
##
##
## Harvest different sources to add to database so
## that functionality can remain in the server side.
##
## Potential Manipulation of data can take place later 
## on as functionality expands
##
## ONLY FOR CSV AT THE MOMENT
##
##
##
##

#!/bin/bash 

kc_cups(){
    # original csv data form
    psql acc -c "\copy kc_cups (id, type, kc0, kc1, kcMid, earlyT, lateT, midT, label) FROM '$1' DELIMITER ',' CSV HEADER;"
}

kc_cups_dates(){
    # original csv data form
    psql acc -c "\copy kc_cups_dates (key, type, id, start_date, end_date, region) FROM '$1' DELIMITER ',' CSV HEADER;"
}

grid(){
    # original csv data form
    psql acc -c "\copy grid (id, type, cover, start_date, end_date, region) FROM '$1' DELIMITER ',' CSV HEADER;"
}

eto(){
    # original csv data form
    psql acc -c "\copy eto (id, type, cover, start_date, end_date, region) FROM '$1' DELIMITER ',' CSV HEADER;"
}


sample(){
    echo "This is a sample: $1"
}

while getopts f: flag
do
    case "${flag}" in
        f) file=${OPTARG};;
    esac
done

file_name="../data/$file"

#########################################
## Run the format python for csv or json
#########################################
#########################################
#python3 -c "import format; format.csv()"

case "$3" in
  kc_cups) 
    kc_cups "$file_name" ;;
  kc_cups_dates)  
    kc_cups_dates "$file_name" ;;
  grid) 
    grid "$file_name" ;;
  eto) 
    eto "$file_name" ;;
  sample) 
    sample "$file_name" ;;
  *) echo "No harvest table verified! Add kc_cups, kc_cups_dates, grid, eto.  Run in order kc_cups, kc_cups_dates, eto, grid";;
esac


##
##
##
##
##
##
##
####################################################
####################################################
