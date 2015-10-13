from __future__ import with_statement

import pandas as pd
import re
import urllib2
from urllib import quote_plus
import json
import unicodedata
import os.path
import time



def get_masterlist(fname):
	names_df = pd.read_csv( fname )
	csv_names = list( names_df['Name'] )
	replace_list = ['jr.', 'ii', 'iii','[a-z]\.', 'i,',',']
	replace_regexp = "|".join( replace_list )
	csv_names = [ re.sub( replace_regexp, '', x.lower() ) for x in csv_names ]
	csv_names = [ name.strip().split() for name in csv_names ]
	csv_names = [ " ".join( name[::-1] ) for name in csv_names ]
	return csv_names

def parse_json_stream(stream):
    decoder = json.JSONDecoder()
    while stream:
        obj, idx = decoder.raw_decode( stream )
        yield obj
        stream = stream[idx:].lstrip()

def get_completed_names(fname):
	if not os.path.isfile(fname):
		print 'no file exists'
		return []

	with open(fname, 'r') as f:
		read_data = parse_json_stream( f.readlines()[0] )     
		completed = []
		for qry in read_data:
			nfo = qry.get( "queries", '' ).get( 'request','' )
			nfo = nfo[0].get( 'searchTerms','' )
			nfo = re.sub( 'white house','', nfo )
			nfo = nfo.strip().lower()
			completed.append( nfo )
		return completed

	
def google_qry(remaining, fname):
	with open(fname, 'a') as f:
		for idx, name in enumerate(remaining):
			print "{0}/{1} remaining".format( idx+1, len(remaining) )
			url = base_url + '&q=' + "+".join( name.split() ) + '+white+house'
			opener = urllib2.build_opener( urllib2.BaseHandler )
			req = urllib2.Request( url )
			time.sleep(1.5)

			try:
				url_handle = opener.open( req )
			except urllib2.URLError, err:
				print err
				raise
			except urllib2.HTTPError, err:
				print err
				raise
			except:
				raise Exception('Unexpected error')

			data = json.loads( url_handle.read() )
			json.dump( data, f )




API_BASE_URL = 'https://www.googleapis.com/customsearch/v1?'
API_KEY = ''
SEARCH_ENGINE = ''

base_url = API_BASE_URL + 'key=' + API_KEY + '&cx=' + SEARCH_ENGINE
master_fname = 'names.csv'
json_fname = 'google_qry.json'

remaining = set( get_masterlist( master_fname ) ) - set( get_completed_names( json_fname ) )
google_qry( remaining, json_fname )