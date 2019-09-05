class Column < ActiveRecord::Base
    has_many :tasks
    belongs_to :board
end