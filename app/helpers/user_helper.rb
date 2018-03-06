module UserHelper
	def device_selected_status(selected, id)
		if(selected.to_i == id.to_i)
			return "selected"
		else
			return ""
		end
	end

	def country_selected_status(selected, country)
		if(selected == country)
			return "selected"
		else
			return ""
		end
	end


	def get_user_bugcount(device_id, user)
		if(device_id == "All")
			return user.bug_ids.count
		end
		Bug.user_by_device(user.id, device_id)
	end
end
