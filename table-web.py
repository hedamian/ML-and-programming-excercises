import urllib.request, json
import requests
import pandas as pd
import csv

url='https://analytics.usa.gov/data/live/realtime.json'
r = requests.get(url).json()

urllib.request.urlretrieve('https://analytics.usa.gov/data/live/realtime.json', 'datos.json')



print (r)


#https://analytics.usa.gov/data/live/realtime.json
