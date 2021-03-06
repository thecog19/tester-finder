class User < ApplicationRecord
	 validates :first_name, presence: true
	 validates :last_name, presence: true
	 validates :external_id, uniqueness: true, presence: true 
	 validates :country, length: {is: 2}
	 has_and_belongs_to_many :devices, join_table: :tester_devices, foreign_key: 'user_id', primary_key: 'device_id'
	 has_many :bugs, foreign_key: "user_id"

	 def self.order_by_bugcount
	 	#we use a left join because we don't care about the properties on bugs
	 	#basically group all the users, and then sort them under the count of unique bug ids they have
	 	User.left_joins(:bugs).group(:external_id).order('COUNT(bugs.id) DESC')
	 end

	 #TODO Refactor to handle multiple inputs.

	 def self.search(search_terms)
	 	countries = search_terms[:countries] 
	 	device_ids = search_terms[:devices]

	 	if(countries == "" || countries.empty?)
	 		countries = "All"
	 	end

	 	if(device_ids == "" || device_ids.empty?)
	 		device_ids = "All"
	 	end
	 	#.map{|id| id.to_i}

	 	user = User.all

	 	#if the country is specificed, filter users by country
	 	unless(countries == "All")
	 		user = user.where(country: countries)
	 	end

	 	#query needs to be limited by the device id if its specified. 
	 	if (device_ids == "All")
			return user.joins("JOIN bugs ON users.external_id == user_id")
					   .group(:user_id)
					   .order('COUNT(bugs.id) DESC')
		end

		#not too bad of a query. Join bugs to users, filter out based on device id, group all the user_ids, and then order them based on the count of unique bug ids
 		user = user.joins("JOIN bugs ON users.external_id == user_id")
 				   .where("device_id IN (?)", device_ids)
 				   .group(:user_id)
 				   .order('COUNT(bugs.id) DESC')
	 end


	 def full_name
  		"#{first_name} #{last_name}"
	end
end
