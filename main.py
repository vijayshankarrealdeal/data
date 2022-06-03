from fastapi import FastAPI
import pandas as pd
from joblib import load
from sympy import print_rcode
import requests

###
pipeline1 = load('assets/xgb1.joblib')
pipeline2 = load('assets/xgb2.joblib')
defor = pd.read_csv('./assets/data.csv')
app = FastAPI()


@app.get('/')
def predictX(area, day, month, year, state):
    df = pd.DataFrame(
        columns=['areakm_squared', 'day', 'month', 'year', 'states'],
        data=[[area, day, month, year, state]])
    df.areakm_squared = pd.to_numeric(df.areakm_squared)
    df.day = pd.to_numeric(df.day)
    df.month = pd.to_numeric(df.month)
    df.year = pd.to_numeric(df.year)
    df.states = df.states.astype(str)
    y_pred_1 = pipeline1.predict(df)[0]
    y_pred_2 = pipeline2.predict(df)[0]
    latitude = round(y_pred_1, 5)
    longitude = round(y_pred_2, 5)
    url = f'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude={latitude}&longitude={longitude}&localityLanguage=en'
    data = requests.get(url)
    x = data.json()
    continent = x['continent']
    city = x['city']
    countryName = x['countryName']
    localityInfo = x['localityInfo']
    return {'latitude': y_pred_1.tolist(), 'longitude': y_pred_2.tolist(), 'continent': continent, 'city': city, "countryName": countryName, 'localityInfo': localityInfo}



@app.get('/defor')
def deforX():
    X = defor.year.unique().tolist()
    data = {}
    for i,st in enumerate(defor.states.unique()):
        k = {}
        tt = defor[defor.states==st].area_km.tolist() 
        tt += [0] * (len(X) - len(tt))
        tmp = []
        for i in range(len(X)):
            tmp.append({"year":str(X[i]),"rates":tt[i]})
        data[st.lower()] = tmp
    return data