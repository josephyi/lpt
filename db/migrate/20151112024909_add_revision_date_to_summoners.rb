class AddRevisionDateToSummoners < ActiveRecord::Migration
  def change
      add_column :summoners, :revision_date, :bigint
  end
end
