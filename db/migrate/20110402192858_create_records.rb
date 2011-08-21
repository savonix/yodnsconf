class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.integer :zone_id
      t.string :name
      t.integer :type_id
      t.string :host
      t.string :text
      t.integer :aux
      t.integer :ttl
      t.integer :pri
      t.integer :weight
      t.integer :port

      t.timestamps
    end
  end

  def self.down
    drop_table :records
  end
end
