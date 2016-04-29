namespace :scraper do
  desc "Fetch Facbook Data Using FQL"
  task group_scrape: :environment do

  	require 'open-uri'
	require 'koala'
	# require 'omniauth'
	require 'json'

	app_id = ENV['app_id']
	app_secret = ENV['app_secret']
	search_content = ENV['searc_content']

	access_token = ENV['access_token']


	graph = Koala::Facebook::API.new(access_token)
	group = graph.fql_query('SELECT gid, name, creator, description, privacy, website, email, icon50, icon
	FROM   group
	WHERE  CONTAINS("#{search_content}")')

	# puts user

	# Display Results
	# puts group[0]["name"]
	# puts JSON.pretty_generate group[0..5]

	# :user_id, :gid, :name, :creator, :description, :privacy, :website, :email, :icon50, :icon
	group.each do |group|

		@links = Group.new
		@links.user_id = "1"
		@links.gid = group["gid"]
		@links.name = group["name"]
		@links.creator = group["creator"]
		@links.description = group["description"]
		@links.privacy = group["privacy"]
		@links.website = group["website"]
		@links.email = group["email"]
		@links.icon50 = group["icon50"]
		@links.icon = group["icon"]

		@links.save
	end	
  end

  desc "TODO"
  task destroy_all_group_lists: :environment do
  end

end
