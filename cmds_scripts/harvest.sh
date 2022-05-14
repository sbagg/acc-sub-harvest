
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
## ONLY FOR CSV or JSON AT THE MOMENT
##
##
##
##

#!/bin/bash 

kc_cups(){
    if [[ $2 -eq "csv" ]] 
    then
      psql acc -c "\copy kc_cups (id, type, kc0, kc1, kcMid, earlyT, lateT, midT, label) FROM '$1' DELIMITER ',' CSV HEADER;"
    else 
      psql acc -c "\copy kc_cups (id, type, kc0, kc1, kcMid, earlyT, lateT, midT, label) FROM '$1';"
    fi  
}

kc_cups_dates(){
    # original csv data form
    if [[ $2 -eq "csv" ]] 
    then
      psql acc -c "\copy kc_cups_dates (key, type, id, start_date, end_date, region) FROM '$1' DELIMITER ',' CSV HEADER;"
    else 
      psql acc -c "\copy kc_cups_dates (key, type, id, start_date, end_date, region) FROM '$1';"
    fi 
}

grid(){
    # original csv data form
    if [[ $2 -eq "csv" ]] 
    then
      psql acc -c "\copy grid (id, type, cover, start_date, end_date, region) FROM '$1' DELIMITER ',' CSV HEADER;"
    else 
      psql acc -c "\copy grid (id, type, cover, start_date, end_date, region) FROM '$1';"
    fi 
}

eto(){
    # original csv data form
    if [[ $2 -eq "csv" ]] 
    then
      psql acc -c "\copy eto (id, type, cover, start_date, end_date, region) FROM '$1' DELIMITER ',' CSV HEADER;"
    else 
      psql acc -c "\copy eto (id, type, cover, start_date, end_date, region) FROM '$1';"
    fi 
}


sample(){
    echo "This is a sample: $1"
}

while getopts c:f: flag
do
    case "${flag}" in
        c) csv=1;;
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
    if "${csv}" -eq 1 then kc_cups "$file_name" "csv"; else  kc_cups "$file_name"; fi ;;   
  kc_cups_dates) 
    if "${csv}" -eq 1 then kc_cups_dates "$file_name" "csv"; else  kc_cups_dates "$file_name"; fi ;;    
  grid) 
    if "${csv}" -eq 1 then grid "$file_name" "csv"; else  grid "$file_name"; fi ;;   
  eto) 
    if "${csv}" -eq 1 then eto "$file_name" "csv"; else  eto "$file_name"; fi ;;   
  sample) 
    if "${csv}" -eq 1 then sample "$file_name" "csv"; else  sample "$file_name"; fi ;;   
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
