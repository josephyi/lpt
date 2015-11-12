class CreateMatchListResponses < ActiveRecord::Migration
  def change
    create_table :match_list_responses do |t|
      t.references :summoner
      t.jsonb :response

      t.timestamps null: false
    end

    add_index :match_list_responses, :summoner_id
    add_index :match_list_responses, :response, using: :gin
  end
end
