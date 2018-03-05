class UserController < ApplicationController

	def index
		@device = Device.all
		@countries = User.select(:country).map(&:country).uniq
		if(params[:search])
			@users = User.search(params[:search])
		else
			@users = User.order_by_bugcount
		end
	end

	def show
	end
end
