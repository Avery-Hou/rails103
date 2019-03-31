class WelcomeController < ApplicationController
	def index
		flash[:notice] = "早安"
		flash[:alert] = "午安"
		flash[:warning] = "晚安"
	end
end
