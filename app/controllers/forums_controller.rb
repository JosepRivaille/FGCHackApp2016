class ForumsController < ApplicationController

  #GET /forums
  def index
    @forums = Forum.all
    forums = []
    @forums.each do |forum|
      forums.push(
          {
            name: forum.name,
            category: 'films',#forum.entertainment.category,
            valoration: 8.0#forum.entertainment.score
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


  #POST /forums/:forumName
  def create
    name = [params[:id]].first.to_s
    @forum = Forum.new(:name => name, :visitors => 0, :participants => 0)
    # @entertainment = Entertainment.new(:name => name, :description => 'guapo', :category => 'films', :score => 8.0)
    #if @entertainment.save
    #  head :status => :ok
    if @forum.save
      head :status => :ok
    else
      head :status => :internal_server_error
    end
  end


  #PATCH /forums/:forumName
  def update

  end

end
