class User < ApplicationRecord
	 validates :first_name, presence: true
	 validates :last_name, presence: true
	 validates :external_id, uniqueness: true, presence: true 
	 validates :country, length: {is: 2}
	 has_and_belongs_to_many :devices, join_table: :tester_devices, foreign_key: 'user_id', primary_key: 'device_id'
	 has_many :bugs, foreign_key: "user_id"

	 def self.order_by_bugcount
	 	User.left_joins(:bugs).group(:user_id).order('COUNT(bugs.id) DESC')
	 end

	 def self.search(search_terms)
	 	country = search_terms[:country]
	 	device_id = search_terms[:device]
	 	user = User.all
	 	unless(country == "All")
	 		user = user.where(country: country)
	 	end
	 	user = user.joins("JOIN bugs ON users.external_id == user_id").where("device_id == #{device_id}").group(:user_id).order('COUNT(bugs.id) DESC')
	 end
end
