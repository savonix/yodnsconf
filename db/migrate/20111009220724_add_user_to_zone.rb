class AddUserToZone < ActiveRecord::Migration
  def change
    add_column :zones, :user_id, :integer
  end
end
