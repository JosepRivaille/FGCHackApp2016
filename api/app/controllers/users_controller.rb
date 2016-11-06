class UsersController < ApplicationController

  #POST /users
  def create
    id_tag = [params[:idTag]]
    @user = User.new
    @user.add_id_tag(id_tag)
    if @user.save
      head :status => :ok
    else
      head :status => :internal_server_error
    end
  end

end
