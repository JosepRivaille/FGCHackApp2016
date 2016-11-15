class EntriesController < ApplicationController

  #GET /forums/:forum_id/entries
  def index
    forum_id = params[:forum_id]

    @entries = Entry.where(:forum_id => forum_id)

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

    render status: :ok, json: entries

  end


  #POST /forums/:forum_id/entries
  def create
    content = params[:content]
    user_id = params[:user_id]
    forum_id = params[:forum_id]

    #TODO: Store through forums
    @entry = Entry.new do |e|
      e.content = content
      e.forum_id = forum_id
      e.user_id = user_id
    end

    if @entry.save
      render status: :ok, json: {
          message: 'Entry created successfully'
      }
    else
      render status: :internal_server_error, json: {
          errors: @entry.errors
      }.to_json
    end

  end

end
