class UsersController < ApplicationController

  #POST /users/:idTag
  def create
    if request.get?
      id_tag = [params[:idTag]]
      @user = User.new
      @user.idTag = id_tag
      if @user.save
        render :nothing => true, :status => :ok
      else
        render :nothing => true, :status => :internal_server_error
      end
    end
  end

end
