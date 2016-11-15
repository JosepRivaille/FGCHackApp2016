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
          }
      )
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

    @forum = Forum.new do |f|
      f.name = name,
          f.visitors = 1,
          f.participants = 1
    end

    @forum.entertainment = Entertainment.new do |e|
      e.name = name,
          e.description = description,
          e.category = category,
          e.score = score
    end

    if @forum.save
      head :status => :ok
    else
      head :status => :internal_server_error
    end

  end


  #PATCH /forums/:id
  def update
    forum_id = params[:id]
    score = params[:score]

    @forum = Forum.find(forum_id)
    updated_score = @forum.entertainment.calculate_new_score(score)

    respond_to do |format|
      if @forum.entertainment.update(:score => updated_score, :total_votes => :total_votes + 1)
        format.json do
          render status: :ok, json: {
              message: 'Score updated'
          }.to_json
        end
      else
        format.json do
          render status: :internal_server_error, json: {
              message: 'Score updated',
              errors: @forum.errors
          }.to_json
        end
      end
    end

  end

end
