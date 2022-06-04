from fastapi import FastAPI
from fastapi.responses import StreamingResponse
import pandas as pd
from joblib import load
from sympy import print_rcode
import requests
from fastapi.middleware.cors import CORSMiddleware
#import tensorflow as tf
import cv2
import numpy as np
from deta import Deta

###
keyy = 'c005yeq6_CUCLAefVYejHYf3dbmh1GMXBPsWJGbcr'
pipeline1 = load('assets/xgb1.joblib')
pipeline2 = load('assets/xgb2.joblib')
defor = pd.read_csv('./assets/data.csv')
imgdata = pd.read_csv('./assets/img.csv')
#model = tf.keras.models.load_model("./assets/models/vgg16-amazon2")
label = {0: 'haze', 1: 'bare_ground', 2: 'blow_down', 3: 'artisinal_mine', 4: 'cloudy',
         5: 'water', 6: 'blooming', 7: 'habitation', 8: 'slash_burn',
         9: 'selective_logging', 10: 'conventional_mine', 11: 'agriculture', 12: 'road', 13: 'partly_cloudy',
         14: 'clear', 15: 'primary', 16: 'cultivation'}
input_size = 64

deta = Deta(keyy)
drive = deta.Drive("detax")

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


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
    url = f'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude={round(y_pred_1, 5)}&longitude={round(y_pred_2, 5)}&localityLanguage=en'
    data = requests.get(url)
    return {'latitude': y_pred_1.tolist(), 'longitude': y_pred_2.tolist(), 'continent': data.json()['continent'], 'city':  data.json()['city'], "countryName":  data.json()['countryName'], 'localityInfo':  data.json()['localityInfo']}


@app.get('/getlabel')
def getAll():
    _data = imgdata.sample(n=16).reset_index()
    return [_data.iloc[:,1:].T.to_dict()[i] for i in _data.iloc[:,1:].T.to_dict()]


@app.get("/download/{name}")
def download_img(name: str):
    res = drive.get(name)
    return StreamingResponse(res.iter_chunks(1024), media_type="image/png")



@app.get('/defor')
def deforX():
    X = defor.year.unique().tolist()
    data = {}
    for i, st in enumerate(defor.states.unique()):
        k = {}
        tt = defor[defor.states == st].area_km.tolist()
        tt += [0] * (len(X) - len(tt))
        tmp = []
        for i in range(len(X)):
            tmp.append({"year": str(X[i]), "rates": tt[i]})
        data[st.lower()] = tmp
    return data
