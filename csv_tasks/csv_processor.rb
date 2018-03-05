require "csv"
require 'logger'


class CSVProcessor
	def initialize(bugs_path = "csv/bugs.csv", 
				   devices_path="csv/devices.csv", 
				   testers_device_path="csv/tester_device.csv",
				   testers_path="csv/testers.csv")

		@logger = Logger.new('log/import.log')

		@bugs_path = bugs_path
		@devices_path = devices_path
		@testers_device_path = testers_device_path
		@testers_path = testers_path
	end

	def import_all
		@logger.debug("running run_all in processor")
		import_testers
		import_devices
		import_tester_to_device
		import_bugs 
		@logger.debug("finished run_all")
	end

	def import_bugs
		data =  CSV.read(@bugs_path)[1 .. -1]
		data.each do |row|
		  external_id =  row[0]
		  bug = Bug.new(external_id: external_id, device_id: row[1], user_id: row[2])
		  if(bug.save)
		  	@logger.debug("stored bug #{external_id}")
		  else
		  	@logger.error("failed to store bug #{external_id}, for reason #{bug.errors.full_messages.first}")
		  end
		end
	end

	def import_testers
		data =  CSV.read(@testers_path)[1 .. -1]
		data.each do |row|
		  external_id =  row[0]
		  user = User.new(external_id: external_id, first_name: row[1], last_name: row[2], country: row[3], last_login: row[4])
		  if(user.save)
		  	@logger.debug("stored user #{user.external_id}")
		  else
		  	@logger.error("failed to store user #{external_id}, for reason #{user.errors.full_messages.first}")
		  end
		end
	end

	def import_devices
		data =  CSV.read(@devices_path)[1 .. -1]
		data.each do |row|
		  external_id =  row[0]
		  device = Device.new(external_id: external_id, description: row[1])
		  if(device.save)
		  	@logger.debug("stored device #{external_id}")
		  else
		  	@logger.error("failed to store device #{external_id}, for reason #{device.errors.full_messages.first}")
		  end
		end

	end

	def import_tester_to_device
		data =  CSV.read(@testers_device_path)[1 .. -1]
		data.each do |row|
		  tester_to_device = TesterDevice.new(user_id: row[0], device_id: row[1])
		  if(tester_to_device.save)
		  	@logger.debug("stored device relationship to user #{row[0]} to #{row[1]} ")
		  else
		  	@logger.error("failed to store device relationship to user #{row[0]} to #{row[1]}, for reason #{tester_to_device.errors.full_messages.first}")
		  end
		end
	end
end