class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.integer :external_id, uninqueness: true
      t.string :description, presence: true
      t.timestamps
    end
  end
end
