class UsersController < ApplicationController

  #POST /users
  def create
    id_tag = params[:id_tag].to_s
    @user = User.new(:id_tag => id_tag)
    if @user.save
      head :status => :ok
    else
      head :status => :internal_server_error
    end
  end

end
