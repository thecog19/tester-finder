class UserController < ApplicationController
	def index
		#devices and countries for the dropdowns
		@devices = Device.all
		@countries = User.select(:country).map(&:country).uniq

		if(params[:search])
			#if there was a search, we need to maintain that state
			@search = params[:search]
			@device_name = Device.where(params[:search][:device])
			
			#we can't search for a device if it's just the string "All", so handle that
			if(params[:search][:device] == "All")
				@device_name = "All"
			else
				@device_name = @device_name.first.description	
			end

			@users = User.search(params[:search])
		else
			#page state on first landing
			@search = {device: "All", country: "All"}
			@users = User.order_by_bugcount
		end
	end

	def show
		@user = User.where(id: params[:id]).first
		@devices = @user.devices
	end

	def search
		redirect_to user_index_path({search: {device: params[:device], country: params[:country]}})
	end
end
