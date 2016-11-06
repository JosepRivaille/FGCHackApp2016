class ForumsController < ApplicationController

  #GET /forums
  def index
    forums = [{
        name: 'nom',
        category: 'Porqueria',
        valoration: 1
    },]
    respond_to do |format|
      format.json do
        render json: forums
      end
    end
  end

  #GET /forums/:forumName
  def show
    forum = {
        name: 'The lord of the rings',
        visitors: 1,
        participants: 1,
        entertainment: {
            description: 'Book written by Tolkien.',
            category: 'Books'
        }
    }
    respond_to do |format|
      format.json do
        render json: { forum: forum }
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
