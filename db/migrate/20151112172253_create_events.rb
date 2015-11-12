class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_type, null: false
      t.string :event_details
      t.references :summoner

      t.timestamps null: false
    end
  end
end
