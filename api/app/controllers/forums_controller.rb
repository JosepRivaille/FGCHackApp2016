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


  #POST /forums/:forumName
  def create
    name = [params[:id]]
    @forum = Forum.new(:name => name.first.to_s, :visitors => 0, :participants => 0)
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
