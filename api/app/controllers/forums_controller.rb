class ForumsController < ApplicationController

  #GET /forums
  def index
    @forums = Forum.all
    forums = []
    @forums.each do |forum|
      forums.push(
          {
              name: forum.name,
              category: forum.entertainment.category,
              valoration: forum.entertainment.score
          })
    end
    respond_to do |format|
      format.json do
        render json: forums
      end
    end
  end


  #GET /forums/:forumName
  def show
    @forum = Forum.find(params[:id])
    forum = {
        name: @forum.name,
        visitors: @forum.visitors,
        participants: @forum.participants,
        entertainment: {
            description: @forum.entertainment.description,
            category: @forum.entertainment.category
        }
    }
    respond_to do |format|
      format.json do
        render json: forum
      end
    end
  end


  #POST /forums
  def create
    name = [params[:forumName]].first.to_s
    description = [params[:description]].first.to_s
    category = [params[:category]].first.to_s

    if check_valid_params(name, description, category)
      @forum = Forum.new(:name => name, :visitors => 0, :participants => 0)
      @entertainment = Entertainment.new(:name => name, :description => description, :category => 'category', :score => 0)
      @forum.entertainment = @entertainment
      if @forum.save
        head :status => :ok
      end
    end

    head :status => :internal_server_error

  end


  #PATCH /forums/:forumName
  def update

  end


  private

  def check_valid_params(name, description, category_name)
    if name.equal? ''
      return false
    elsif description.equal? ''
      return false
    else
      categories_list = %w(cinema sports music books games)
      categories_list.each do |category|
        if category === category_name
          return true
        end
      end
    end
    false
  end

end
