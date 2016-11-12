class ForumsController < ApplicationController

  #GET /forums
  def index
    @forums = Forum.all
    forums = []
    @forums.each do |forum|
      forums.push(
          {
              id: forum.id,
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


  #GET /forums/:id
  def show
    forum_id = params[:id]
    @forum = Forum.find(forum_id)
    forum = {
        name: @forum.name,
        visitors: @forum.visitors,
        participants: @forum.participants,
        entertainment: {
            description: @forum.entertainment.description,
            category: @forum.entertainment.category
        },
        # entries: getRelatedEntries(forum_id)
    }
    respond_to do |format|
      format.json do
        render json: forum
      end
    end
  end



  #POST /forums
  def create
    name = params[:forumName].to_s
    description = params[:description].to_s
    category = params[:category].to_s
    score = params[:score].to_f

    if check_valid_params(name, description, category)
      @forum = Forum.new(
          :name => name,
          :visitors => 1,
          :participants => 1
      )
      @entertainment = Entertainment.new(
          :name => name,
          :description => description,
          :category => category,
          :score => score
      )
      @forum.entertainment = @entertainment
      if @forum.save
        head :status => :ok
      else
        head :status => :internal_server_error
      end
    else
      head :status => :bad_request
    end

  end


  #PATCH /forums/:id
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
