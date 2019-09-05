class CreateColumn < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |col|
      col.text :name
      col.integer :board_id
    end
  end
end
