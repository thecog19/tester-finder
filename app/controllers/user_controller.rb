class UserController < ApplicationController
	def index
		#devices and countries for the dropdowns
		@devices = Device.all
		@countries = User.select(:country).map(&:country).uniq

		if(params[:search])
			#if there was a search, we need to maintain that state
			@search = params[:search]
			@device_names = Device.where("id IN (?)", params[:search][:devices])
			
			#we can't search for a device if it's just the string "All", so handle that
			if(params[:search][:devices] == "All" || params[:search][:devices] == "")
				@device_names = "All"	
			end

			@users = User.search(params[:search])
		else
			#page state on first landing
			@search = {devices: "All", countries: "All"}
			@users = User.order_by_bugcount
		end
	end

	def show
		@user = User.where(id: params[:id]).first
		@devices = @user.devices
	end

	def search
		redirect_to user_index_path({search: {devices: params[:devices], countries: params[:countries]}})
	end
end
