class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |col|
      col.string :name
    end
  end
end
