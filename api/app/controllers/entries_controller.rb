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
        render status: :ok, json: {
            message: 'Entries found for this forum',
            data: entries
        }.to_json
      end
    end
  end


  #POST /forums/:forum_id/entries
  def create
    content_entry = params[:content_entry]
    user_id = params[:user_id]
    forum_id = params[:forum_id]

    @entry = Entry.new do |e|
      e.content = content_entry,
      e.forum_id = forum_id,
      e.user_id = user_id
    end

    if @entry.save
      render status: :ok, json: {
          message: 'Successfully created entry'
      }
    else
      render status: :internal_server_error, json: {
          message: 'Something went wrong, try it again'
      }.to_json
    end

  end

end
