class Device < ApplicationRecord
	 validates :description, presence: true
	 validates :external_id, uniqueness: true, presence: true
	 has_and_belongs_to_many :users, join_table: :tester_devices, :foreign_key => 'device_id', :primary_key => 'user_id'

end
