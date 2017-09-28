#!/usr/bin/env ruby
# frozen_string_literal: true

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

# Example overpass API query that gets campsites within a part of Sydney
# from OpenStreetMap
page = agent.get('https://overpass-api.de/api/interpreter?data=node%5B%22tourism%22%3D%22camp%5Fsite%22%5D%28%2D34%2E011688599109%2C150%2E96038818359%2C%2D33%2E652923027488%2C151%2E44172668457%29%3Bout%3Bway%5B%22tourism%22%3D%22camp%5Fsite%22%5D%28%2D34%2E011688599109%2C150%2E96038818359%2C%2D33%2E652923027488%2C151%2E44172668457%29%3B%28%2E%5F%3B%3E%3B%29%3Bout%3B')

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
