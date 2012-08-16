# This task scrapes the given website using the given xPath,
# And adds all categories with their associated urls.

task :cats => :environment do
	# Required gems
	require 'nokogiri'
	require 'open-uri'
	
	# Reset database to remove unwanted data
	Rake::Task["db:reset"].invoke
	
	# User defined variables
	url = "http://www.awear.com"
	xPath = '//ul/li/div/ul/li/a'
	
	# Get the Nokogiri HTML document for given url
	doc = Nokogiri::HTML(open(url))
  
	# Search for nodes matching the xPath and add them to database
	doc.xpath(xPath).each do |link|
		oneCategory = link.content
		oneUrl = link['href']
		Category.create!(:category => oneCategory, :url => oneUrl)
	end
end