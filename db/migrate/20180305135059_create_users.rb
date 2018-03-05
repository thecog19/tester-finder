class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, presence: true
      t.string :last_name, presence: true
      t.string :country, length: { is: 2 }
      t.datetime :last_login
      t.integer :external_id, presence: true
      t.timestamps
    end
  end
end
