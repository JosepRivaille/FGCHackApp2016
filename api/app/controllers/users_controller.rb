class UsersController < ApplicationController

  #POST /users/:idTag
  def create
    @user = User.new
    @user.idTag
  end

end
