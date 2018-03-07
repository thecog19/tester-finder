FactoryBot.define do


  factory :user do
    first_name "John"
    last_name  "Doe"
    sequence :external_id { |n| n }
    country "TE"
    sequence :id { |n| n }
  end

  factory :device do 
    sequence :description  { |n| "iPhone #{n}"}
    sequence :external_id { |n| n }
    sequence :id { |n| n }
  end

  factory :tester_device do 
    user_id {create(:user).external_id}
    device_id {create(:device).external_id}
  end

  factory :bug do
    user_id {create(:user).external_id}
    device_id {create(:device).external_id}
    sequence :external_id{ |n| n }
    sequence :id { |n| n }
  end
end