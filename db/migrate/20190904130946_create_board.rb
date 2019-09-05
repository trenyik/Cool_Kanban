class CreateBoard < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |col|
      col.string :title
    end
  end
end
