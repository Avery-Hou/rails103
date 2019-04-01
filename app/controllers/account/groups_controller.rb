class Account::GroupsController < ApplicationController
	before_action :authenticate_user!, only: [:index]
	
	def index
		@groups = current_user.joined_groups
	end
end
