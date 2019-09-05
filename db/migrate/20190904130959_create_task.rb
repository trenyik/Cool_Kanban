class CreateTask < ActiveRecord::Migration[5.2]
    def change
      create_table :tasks do |col|
        col.string :title
        col.string :status
        col.string :text
        col.integer :column_id
        col.integer :user_id
      end
    end
end
