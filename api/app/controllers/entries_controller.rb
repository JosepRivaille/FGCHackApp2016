class EntriesController < ApplicationController

  #GET /forums/:forum_id/entries
  def index
    @forum = Forum.find(params[:forum_id])
    @entries = @forum.entries
    entries = []
    @entries.each do |entry|
      entries.push(
          {
              id_tag: entry.user.id_tag,
              content: entry.content,
              timestamp: entry.created_at
          }
      )
    end
    respond_to do |format|
      format.json do
        render json: entries
      end
    end
  end


  #POST /forums/:forum_id/entries
  def create
    content = params[:content].to_s
    user_id = params[:user_id].to_s
    forum_id = params[:forum_id].to_s

    if not content.empty?
      @forum = Forum.find(forum_id)
      @forum.entries.new(
          :content => content,
          :user => User.find(user_id)
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
