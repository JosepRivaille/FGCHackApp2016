class ForumsController < ApplicationController

  #GET /forums
  def index
    @forums = Forum.all
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
