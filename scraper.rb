#!/usr/bin/env ruby
# frozen_string_literal: true

require 'scraperwiki'
require 'mechanize'

def overpass_query(query)
  r = Mechanize.new.get(
    'https://overpass-api.de/api/interpreter?data=' + CGI.escape(query)
  )
  Nokogiri::XML(r.body)
end

# Example overpass API query that gets campsites within a part of Sydney
# from OpenStreetMap

# Defines the bounding box of the search
lat_min = -34.011688599109
lng_min = 150.96038818359
lat_max = -33.652923027488
lng_max = 151.44172668457

bounding_box =
  "(#{lat_min},#{lng_min},#{lat_max},#{lng_max})"

# Slightly easier to handle if we split out into two queries
doc = overpass_query("node['tourism'='camp_site']#{bounding_box};out;")
doc.search('node').each do |node|
  record = {
    'osm_node_id' => node['id'],
    'latitude' => node['lat'],
    'longitude' => node['lon']
  }
  # Step through all the tags
  node.search('tag').each do |tag|
    key = tag['k'].tr(':', '_')
    value = tag['v']
    record[key] = value
  end
  ScraperWiki.save_sqlite(['osm_node_id'], record)
end

doc = overpass_query("way['tourism'='camp_site']#{bounding_box};out center;")
doc.search('way').each do |way|
  record = {
    'osm_way_id' => way['id'],
    'latitude' => way.at('center')['lat'],
    'longitude' => way.at('center')['lon']
  }
  # Step through all the tags
  way.search('tag').each do |tag|
    key = tag['k'].tr(':', '_')
    value = tag['v']
    record[key] = value
  end
  ScraperWiki.save_sqlite(['osm_way_id'], record)
end
