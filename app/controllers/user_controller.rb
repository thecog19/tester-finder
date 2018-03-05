class UserController < ApplicationController

	def index
		@device = Device.all
		@countries = User.select(:country).map(&:country).uniq
	end

	def show
	end
end
