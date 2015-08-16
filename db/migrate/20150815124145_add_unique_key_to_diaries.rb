class AddUniqueKeyToDiaries < ActiveRecord::Migration
  def change
    add_index :diaries, [:date, :user_id], :unique => true
  end
end
