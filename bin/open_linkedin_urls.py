import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common import action_chains, keys
from selenium.common.exceptions import ElementNotVisibleException
import random
import json
import re
import pandas as pd


def init_driver():
	driver = webdriver.Firefox()
	driver.wait = WebDriverWait(driver, 5)
	return driver

def get_html(driver, link_tuple, fname):
    name, url = link_tuple[0], link_tuple[1]
    try:
        driver.get(url)
        html = driver.page_source
    except:
        raise

    with open(fname, 'a') as f:
        json.dump( (name, html), f)


df = pd.read_csv('links_merged_edited.csv')

#find all columns that are not checked and have urls
refs = df[(~pd.isnull(df['Ref'])) & (df['Checked']!='x')].Ref
for item in ref:
	


#open the file with links
#loop over the file and open the urls
#pause 10s between each retrieval

"""

fname = 'google_qry.json'
stream = get_qry_results( fname )

profile_links = get_profile_links( stream )

fname = 'linkedin_data.json'        
driver = init_driver()
driver.get(url)
time.sleep(10)

for idx, site in enumerate( profile_links ):
    print "{0}/{1}".format(idx+1, len( profile_links ))
    get_html( driver, site, fname )
    time.sleep( random.randint(10,100) )




"""