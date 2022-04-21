# python3 install
# sudo python3 -m pip install pandas
import numpy as np
import pandas as pd



def csv():

    df= pd.read_csv("../data/kc.csv")

    kc_cups = pd.DataFrame(columns=['id', 'type', 'kc0','kc1','kcMid','earlyT','lateT','midT','label'])

    kc_cups_dates = pd.DataFrame(columns=['key', 'type', 'id','start_date','end_date', 'region'])


    kc_cups["id"] = "cups:" + df["CropNumber"].astype(str)
    kc_cups["type"] = "4stage_function"
    kc_cups["kc0"] = df["KcAB"].astype(str)
    kc_cups["kc1"] = df["KcE"].astype(str)
    kc_cups["kcMid"] = df["KcCD"].astype(str)
    kc_cups["earlyT"] = (df["seasonB"].astype(float) / 100).astype(str)
    kc_cups["midT"] = (df["seasonC"].astype(float) / 100).astype(str)
    kc_cups["lateT"] = (df["seasonD"].astype(float) / 100).astype(str)
    kc_cups["label"] = df["CropName"].astype(str)

    kc_cups_dates["key"] = "cups:/dates/Q99/" + df["CropNumber"].astype(str)
    kc_cups_dates["type"] = "GrowthSchedule"
    kc_cups_dates["id"] = "cups:" + df["CropNumber"].astype(str)
    kc_cups_dates["start_date"] = "--" + (df["plantMonth"].apply(lambda x: '{0:0>2}'.format(x))).astype(str) + "-" + (df["plantDay"].apply(lambda x: '{0:0>2}'.format(x))).astype(str) 
    kc_cups_dates["region"] = "wd:Q99"
    kc_cups_dates["end_date"] = "--" + (df["harvestMonth"].apply(lambda x: '{0:0>2}'.format(x))).astype(str)  + "-" + (df["harvestDay"].apply(lambda x: '{0:0>2}'.format(x))).astype(str) 


    kc_cups.to_csv("../data/kc_cups.csv",index=False)

    kc_cups_dates.to_csv("../data/kc_cups_dates.csv",index=False)
