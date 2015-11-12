class CreateSummoners < ActiveRecord::Migration
  def change
    create_table :summoners do |t|
      t.integer :summoner_id
      t.string :name
      t.string :region
      t.integer :profile_icon_id
      t.integer :summoner_level
      t.timestamps
    end
  end
end
