require 'rails_helper'

RSpec.describe User, type: :model do
	context "validations" do

		it "validates presence of last name" do
			user = User.new(country: "us", first_name: "name", external_id: 1)
			expect(user.save).to eq(false)
			expect(user.errors.full_messages).to eq(["Last name can't be blank"])
		end

		it "validates presence of first name" do
			user = User.new(country: "us", last_name: "name", external_id: 1)
			expect(user.save).to eq(false)
			expect(user.errors.full_messages).to eq(["First name can't be blank"])
		end

		it "validates presence and length of country" do
			user = User.new(first_name: "name", last_name: "name", external_id: 1)
			expect(user.save).to eq(false)
			expect(user.errors.full_messages).to eq(["Country is the wrong length (should be 2 characters)"])
		end

		it "validates presence of external id" do
			user = User.new(first_name: "name", last_name: "name", country: "sb")
			expect(user.save).to eq(false)
			expect(user.errors.full_messages).to eq(["External can't be blank"])
		end

		it "validates uniqueness of external id" do
			user1 = create(:user)
			user2 = User.new(first_name: "name", last_name: "name", country: "sb", external_id: user1.external_id)
			expect(user2.save).to eq(false)
			expect(user2.errors.full_messages).to eq(["External has already been taken"])
		end

	end

 	it "Has a full_name method" do
 		user = create(:user, last_name: "Smith", first_name: "John")	

 		expect(user.full_name).to eq("John Smith")
 	end

 	context("has many bugs") do 
 		it("User.bugs returns a list of bugs") do
 			user = create(:user)
 			bug = create(:bug, user_id: user.external_id)
 			expect(user.bugs.first).to eq(bug)
 			expect(user.bugs.length).to eq(1)
 		end
 	end

 	context("has many devices") do
 		it("User.devices returns a list of devices") do
 			user = create(:user)
 			device = create(:device)
 			user_device = create(:tester_device, user_id: user.external_id, device_id: device.external_id)
 			expect(user.devices.first).to eq(device)
 			expect(user.devices.length).to eq(1)
 		end
 	end

 	context("order_by_bugcount") do
 		before(:context) do
 			User.destroy_all
 			Device.destroy_all
 			Bug.destroy_all
 			@user_with_bugs = create(:user)
 			@user_without_bugs = create(:user)
 			@device = create(:device)
    		@bugs = create_list(:bug, 25, user_id: @user_with_bugs.external_id, device_id: @device.external_id )
  			@unrelated_bugs = create_list(:bug, 10)
  		end

  		it "Returns an active record relation" do
  			expect(User.order_by_bugcount).to be_a_kind_of(ActiveRecord::Relation)
  		end

	 	it "the user with the most bugs is first in the array" do
	 		expect(User.order_by_bugcount.first).to eq(@user_with_bugs)
	 	end
	 	it "the user with the least bugs is last in the array" do
	 		expect(User.order_by_bugcount.last).to eq(@user_without_bugs)
	 	end
	 	it "every user is in the array" do
	 		expect(User.all.count).to eq(User.order_by_bugcount.length)
	 	end
 	end

 	context("search") do
 		#TODO: more unit tests
 		before(:context) do
 			User.destroy_all
 			Device.destroy_all
 			Bug.destroy_all
	 		@user_with_bugs = create(:user, country: "AM")
	 		@user_from_russia = create(:user, country: "RU")
	 		@user_without_bugs = create(:user)
	 		@user_with_other_device = create(:user)
	 		@device1 = create(:device)
	 		@device2 = create(:device)
	 		@device3 = create(:device)
	 		@bugs_ru_device3 = create_list(:bug, 3, user_id: @user_from_russia.external_id, device_id: @device3.external_id )
	 		@bugs_for_russia = create_list(:bug, 5, user_id: @user_from_russia.external_id, device_id: @device1.external_id )
	    	@bugs = create_list(:bug, 25, user_id: @user_with_bugs.external_id, device_id: @device1.external_id )
	  		@unrelated_bugs = create_list(:bug, 100)
	  		@bugs_with_diff_device = create_list(:bug, 15, user_id: @user_with_other_device.external_id, device_id: @device2.external_id )
  		end

  		context("empty strings behave as blank strings") do
  			it "the user with the most bugs is first in the array" do
	 			expect(User.search({devices:"", countries:""}).first).to eq(@user_with_bugs)
	 		end
		 	it "removes all users with no bugs" do
		 		expect(User.search({devices:"", countries:""}).last).not_to eq(@user_without_bugs)
		 	end

  		end

	 	context("All is passed as both parameters") do
 			it "the user with the most bugs is first in the array" do
	 			expect(User.search({devices:"All", countries:"All"}).first).to eq(@user_with_bugs)
	 		end
		 	it "removes all users with no bugs" do
		 		expect(User.search({devices:"All", countries:"All"}).last).not_to eq(@user_without_bugs)
		 	end
 		end

 		context("A country is passed as a param, All is passed as device") do
 			it "with the most bugs is first in the array" do
	 			expect(User.search({devices:"All", countries:["RU"]}).first).to eq(@user_from_russia)
	 		end
		 	it "removes all users with no bugs" do
		 		expect(User.search({devices:"All", countries:["RU"]}).count.length).to eq(1)
		 	end
 		end

 		context("All is passed as country, a device id is passed as a param") do
 			it "returns the user with the most bugs is first in the array" do
	 			expect(User.search({devices:[@device2.external_id], countries:"All"}).first).to eq(@user_with_other_device)
	 		end
	 		it "removes all users with no bugs" do
		 		expect(User.search({devices:[@device2.external_id], countries:"All"}).count.length).to eq(1)
		 	end
 		end

 		context("A country and a device are passed in") do
 			context("the overlap of country and device should have no results") do
 				it("Returns an empty array") do
	 				expect(User.search({devices:[@device2.external_id], countries:["RU"]}).empty?).to eq(true)
 				end
 			end
 			context("the country doesn't exist") do
 				it("Returns an empty array")  do
	 				expect(User.search({devices:[@device2.external_id], countries:["AU"]}).empty?).to eq(true)
 				end
 			end
 			context("The device doesn't exist") do
 				it("Returns an empty array") do
	 				expect(User.search({devices:[29], countries:["RU"]}).empty?).to eq(true)
 				end
 			end

 			context("The device and country are valid") do
 				it("Resturns the correct users") do
	 				expect(User.search({devices:[@device3.external_id], countries:["RU"]}).first).to eq(@user_from_russia)
 				end
 			end

 		end
 		context("Two countries are passed in") do
 			context("there are users from both countries") do
 				it("returns the right number of users") do
 					expect(User.search({devices:"", countries:["RU", "AM"]}).count.length).to eq(2)
 				end
 			end
 		end

 		context("Two devices are passed in" ) do
 			context("there is an user with both devices") do
 				it("returns the right number of users") do
 					expect(User.search({devices:[@device3.external_id, @device2.external_id], countries:""}).count.length).to eq(2)
 				end
 			end
 		end

 		context("Two devices and a country are passed in" ) do
 			context("there is an user with both devices") do
 				it("returns the right user") do
 					expect(User.search({devices:[@device3.external_id, @device2.external_id], countries:["RU"]})).to eq([@user_from_russia])
 				end
 			end
 		end

 	end



end
