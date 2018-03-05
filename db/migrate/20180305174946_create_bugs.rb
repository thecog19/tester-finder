class CreateBugs < ActiveRecord::Migration[5.1]
  def change
    create_table :bugs do |t|
      t.integer :device_id
      t.integer :user_id
      t.integer :external_id
      t.timestamps
    end
  end
end
