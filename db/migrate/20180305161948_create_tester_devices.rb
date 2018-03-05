class CreateTesterDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :tester_devices do |t|
     t.integer :user_id
     t.integer :device_id
      t.timestamps
    end
  end
end
