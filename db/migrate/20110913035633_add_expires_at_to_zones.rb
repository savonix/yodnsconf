class AddExpiresAtToZones < ActiveRecord::Migration
  def change
    add_column :zones, :expires_at, :date
  end
end
