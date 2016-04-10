class CreateApiRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.timestamps null: false
      t.text :username, null: false
      t.text :response
    end

    add_index :api_requests, :username, unique: true
  end
end
