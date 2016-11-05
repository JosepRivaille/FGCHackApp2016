class UsersController < ApplicationController

	#POST /users/
	def create
		@user = User.new
		@user.idTag
	end
end
