class ForumsController < ApplicationController

  #GET /forums
  def index
    @forums = Forum.all

    forums_simples = []
    @forums.each do |forum|
      forums_simples.push(
          {
              id: forum.id,
              name: forum.name,
              category: forum.entertainment.category,
              score: forum.entertainment.score
          }
      )
    end

    render status: 200, json: forums_simples

  end


  #GET /forums/:id
  def show
    forum_id = params[:id]

    @forum = Forum.find(forum_id)
    @forum.increment!(:visitors)

    forum_details = {
        name: @forum.name,
        visitors: @forum.visitors,
        participants: @forum.participants,
        entertainment: {
            description: @forum.entertainment.description,
            category: @forum.entertainment.category,
            score: @forum.entertainment.score
        }
    }

    render status: 200, json: forum_details

  end


  #POST /forums
  def create
    name = params[:name]
    description = params[:description]
    category = params[:category]
    score = params[:score].to_f

    # TODO: Refactor into model validations
    if check_correct_parameters(description, category, score)
      @forum = Forum.new do |f|
        f.name = name
        f.visitors = 1
        f.participants = 1
      end

      @forum.entertainment = Entertainment.new do |e|
        e.name = name
        e.description = description
        e.category = category
        e.score = score
      end

      if @forum.save
        render status: :ok, json: {
            message: 'Forum created'
        }.to_json
      else
        render status: :internal_server_error, json: {
            errors: @forum.errors
        }.to_json
      end
    else
      render status: :bad_request, json: {
          errors: 'invalid params'
      }.to_json
    end

  end


  #PATCH /forums/:id
  def update
    forum_id = params[:id]
    score = params[:score].to_f

    if score.between?(0,10)
      @forum = Forum.find(forum_id)
      updated_score = @forum.entertainment.calculate_new_score(score)

      if @forum.entertainment.update_attributes(:score => updated_score)
        @forum.entertainment.increment!(:total_votes)
        render status: :ok, json: {
            message: 'Score updated'
        }.to_json
      else
        render status: :internal_server_error, json: {
            errors: @forum.errors
        }.to_json
      end

    else
      render status: :bad_request, json: {
          errors: 'invalid params'
      }.to_json
    end

  end


  private

  def check_correct_parameters(description, category, score)
    if description.nil? or category.nil? or score.nil?
      false
    else
      if %w(cinema sports music books games).include? category
        return true
      else
        return false
      end
    end
  end

end
