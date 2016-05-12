class CategoriesController < InheritedResources::Base
	before_action :set_category, only: [:show, :edit, :update, :destroy, :vote]
  	before_filter :authenticate_user!

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
  end

  # GET /Categoriss/1
  # GET /categories/1.json
  def show
  end

  # GET /groups/new
  def new
    @category = Category.new

    @cat_name = Category.last
    @access_token = Token.last
    require 'open-uri'
	require 'koala'
	# require 'omniauth'
	require 'json'

	# app_id = ENV['app_id']
	# app_secret = ENV['app_secret']
	search_content = @cat_name.category_name.split(' ')

	access_token = @access_token.access_token # ENV['access_token']

	search_content.each do |s_name|
		graph = Koala::Facebook::API.new(access_token)
		group = graph.fql_query('SELECT gid, name, creator, description, privacy, website, email, icon50, icon
		FROM   group
		WHERE  CONTAINS("#{s_name}")')

		# puts user

		# Display Results
		# puts group[0]["name"]
		# puts JSON.pretty_generate group[0..5]

		# :user_id, :gid, :name, :creator, :description, :privacy, :website, :email, :icon50, :icon
		group.each do |group|

			@links = Group.new
			@links.user_id = current_user.id
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
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    # @category.user = current_user

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category_name)
    end
end

