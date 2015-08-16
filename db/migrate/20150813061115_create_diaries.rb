class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.integer :user_id
      t.date :date
      t.text :diary
      t.integer :status

      t.timestamps
    end
  end
end
