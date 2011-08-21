class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.string :origin
      t.string :primary
      t.string :email
      t.integer :ttl
      t.integer :serial
      t.string :axfr
      t.integer :minimumTTL
      t.boolean :active
      t.integer :zone_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :zones
  end
end
