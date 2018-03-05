class User < ApplicationRecord
	 validates :first_name, presence: true
	 validates :last_name, presence: true
	 validates :external_id, uniqueness: true, presence: true 
	 validates :country, length: {is: 2}
	 has_and_belongs_to_many :devices, join_table: :tester_devices, :foreign_key => 'user_id', :primary_key => 'device_id'

end
