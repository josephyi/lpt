class CreateMatchResponses < ActiveRecord::Migration
  def change
    create_table :match_responses do |t|
        t.integer :match_id
        t.jsonb :response

      t.timestamps null: false
    end
    add_index :match_responses, :match_id
    add_index :match_responses, :response, using: :gin
  end
end
