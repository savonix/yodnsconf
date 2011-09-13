class CreateWhoisRecords < ActiveRecord::Migration
  def change
    create_table :whois_records do |t|
      t.integer :zone_id
      t.text :record

      t.timestamps
    end
  end
end
