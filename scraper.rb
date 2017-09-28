#!/usr/bin/env ruby
# frozen_string_literal: true

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

# Example overpass API query that gets campsites within a part of Sydney
# from OpenStreetMap

# Defines the bounding box of the search
lat_min = -34.011688599109
lng_min = 150.96038818359
lat_max = -33.652923027488
lng_max = 151.44172668457

bounding_box =
  "(#{lat_min},#{lng_min},#{lat_max},#{lng_max})"
data = 'node["tourism"="camp_site"]' +
       bounding_box +
       ';out;way["tourism"="camp_site"]' +
       bounding_box +
       ';(._;>;);out;'
page = agent.get(
  'https://overpass-api.de/api/interpreter?data=' + CGI.escape(data)
)

puts page.body

# # Find somehing on the page using css selectors
# p page.at('div.content')
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
