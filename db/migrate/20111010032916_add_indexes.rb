class AddIndexes < ActiveRecord::Migration
  def up
    add_index :zones, :user_id
    add_index :zones, :origin
    add_index :zones, [:id, :user_id], { :name => "id_users_index" }
    add_index :zones, [:origin, :user_id], { :name => "origin_users_index", :unique => "true" }
    add_index :records, :zone_id
    add_index :whois_records, :zone_id
  end

  def down
  end
end
