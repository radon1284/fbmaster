namespace :scraper do
  desc "Fetch Facbook Data Using FQL"
  task group_scrape: :environment do

  	require 'open-uri'
	require 'koala'
	# require 'omniauth'
	require 'json'

	app_id = '570544799790506'
	app_secret = '988c949cead262144c43ae05bf587a4e'

	access_token = 'EAACEdEose0cBAHl7gi53oYDmk67mGf32ZCkVTLXnHkMnn4UpKC5PWb7cYaX9pCaHJ87q7B5FEceWwTu9k7n9V2G7lqvRYXkhDc1FY8c8ZCcvkeoct4Q4sp9UhnDbMgVKAqaJ1vlOg8WhMzND7q5EV2rYVKNkk6MZC7JaFH6VQZDZD'


	graph = Koala::Facebook::API.new(access_token)
	group = graph.fql_query('SELECT gid, name, creator, description, privacy, website, email, icon50, icon
	FROM   group
	WHERE  CONTAINS("jobs")')

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
