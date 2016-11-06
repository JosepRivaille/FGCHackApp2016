class UsersController < ApplicationController

  #POST /users
  def create
    id_tag = [params[:idTag]]
    @user = User.new(:idTag => id_tag.first.to_s)
    if @user.save
      head :status => :ok
    else
      head :status => :internal_server_error
    end
  end

end
