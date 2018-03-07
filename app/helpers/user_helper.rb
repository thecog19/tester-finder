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


	def get_user_bugcount(device_ids, user)
		if(device_ids == "All" || device_ids == "")
			return user.bug_ids.count
		end
		Bug.user_by_device(user.id, device_ids)
	end

	def format_device_names(device_names)
		if(device_names == "All" || !device_names || device_names == "")
			return "All"
		else
			return device_names.map{|device| device.description}.join(" , ")
		end
	end

	def format_country_names(country_names)
		if(country_names == "All" || !country_names || country_names == "")
			return "All"
		else
			return country_names.join(" , ")
		end
	end
end
