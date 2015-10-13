import time
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
import random
import json
import re

def init_driver():
	driver = webdriver.Firefox()
	driver.wait = WebDriverWait(driver, 5)
	return driver

def get_qry_results(fname):
    with open('google_qry.json', 'r') as f:
        read_data = parse_json_stream(f.readlines()[0])
    return read_data

def parse_json_stream(stream):
    decoder = json.JSONDecoder()
    while stream:
        obj, idx = decoder.raw_decode(stream)
        yield obj
        stream = stream[idx:].lstrip()

def get_profile_links(stream):
    value_regex = re.compile("View the profiles of professionals")
    profile_links = []

    for person in stream:
        profileList = person.get('items','')
        if not profileList:
            continue

        entry = person['queries']['request'][0]['searchTerms']    
        name = re.sub('white house', '', entry).strip()

        text = profileList[0]['snippet']
        if not re.search(value_regex, text):
            link = profileList[0]['link']
            profile_links.append((name, link))
    return profile_links

def get_html(driver, link_tuple, fname):
    name, url = link_tuple[0], link_tuple[1]
    try:
        driver.get(url)
        html = driver.page_source
    except:
        raise

    with open(fname, 'a') as f:
        json.dump( (name, html), f)


fname = 'google_qry.json'
stream = get_qry_results( fname )

profile_links = get_profile_links( stream )

fname = 'linkedin_data.json'        
driver = init_driver()
for idx, site in enumerate( profile_links ):
    print "{0}/{1}".format(idx+1, len( profile_links ))
    get_html( driver, site, fname )
    time.sleep( random.randint(10,100) )




