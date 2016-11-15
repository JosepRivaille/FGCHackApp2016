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

  #TODO: NO ACABAT.
#PATCH /forums/:id
def update
#  forum_id = params[:id]
#  @forum = Forum.find(forum_id)
#  Entertainment.update(:forum_id, :score => 7.1)

  respond_to do |format|
    if @forum.update_attributes(params[:score])
      format.json { head :no_content, status: :ok }
    else
      format.json { render json: @forum.errors, status: :unprocessable_entity }
    end
  end
end



end
