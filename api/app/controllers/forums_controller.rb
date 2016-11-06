class ForumsController < ApplicationController

  #GET /forums
  def index
    @forums = Forum.all
    forums = []
    @forums.each do |forum|
      @entertainment = Entertainment.find_by(name: forum.name)
      forums.push(
          {
            name: forum.name,
            category: @entertainment.category,
            valoration: @entertainment.score
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
    @entertainment = Entertainment.find(params[:id])
    forum = {
        name: @forum.name,
        visitors: @forum.visitors,
        participants: @forum.participants,
        entertainment: {
            description: @entertainment.description,
            category: @entertainment.category
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

  end


  #PATCH /forums/:forumName
  def update

  end

end
