class ForumsController < ApplicationController

  #GET /forums
  def index
    @forums = [
        {
            name: 'The Lord of the Rings',
            category: 'Books',
            valoration: 9.5
        },
        {
            name: 'Deadpool',
            category: 'Films',
            valoration: 7
        }
    ]
    respond_to do |format|
      format.json do
        render json: @forums
      end
    end
  end

  #GET /forums/:forumName
  def show
    forum = {
        name: 'The Lord of the Rings',
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
