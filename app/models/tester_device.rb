class TesterDevice < ApplicationRecord
	validates :user_id, presence: true
	validates :device_id, presence: true
end
