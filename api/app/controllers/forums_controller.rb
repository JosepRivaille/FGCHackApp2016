class ForumsController < ApplicationController

  #GET /forums
  def index
    forums = [
        { name: 'nom', category: 'Porqueria', valoration: 1 },
    ]

    respond_to do |format|
      format.json do
        render json: forums
      end
    end

    #@forums = Forum.all
  end

  #GET /forums/:forumName
  def show
    @forum = Forum.find(params[:forumName])
  end

  #POST /forums/:forumName
  def create

  end

  #PATCH /forums/:forumName
  def update

  end

end
