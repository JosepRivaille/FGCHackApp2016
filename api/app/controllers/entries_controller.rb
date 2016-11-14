class EntriesController < ApplicationController

  #GET /forums/:id/entries
  def index

  end

  #POST /forums/:id/entries
  def create
    content = params[:entry_content].to_s
    user_id = params[:user_id].to_s
    forum_id = params[:forum_id].to_s

    if not content.empty?
      @forum = Forum.find(forum_id)
      @forum.entries.new(
          :content => content,
          :user => User.find(user_id) #Not working yet
      )
      if @forum.save
        head :status => :ok
      else
        head :status => :internal_server_error
      end
    else
      head :status => :bad_request
    end
  end

end
