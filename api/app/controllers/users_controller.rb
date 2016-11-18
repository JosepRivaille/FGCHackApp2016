class UsersController < ApplicationController

  #POST /users
  def create
    id_tag = params[:id_tag]
    @user = User.new(:id_tag => id_tag)

    if @user.save
      render status: :ok, json: {
          message: 'User created successfully'
      }.to_json
    else
      render status: :internal_server_error, json: {
          errors: @user.errors
      }.to_json
    end
  end

end
