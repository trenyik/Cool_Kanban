class Task < ActiveRecord::Base
    belongs_to :column
    belongs_to :user

    # def self.all_by_status
    #     tasks = self.where(board_id: matching_board.id)
    #     tasks.group_by { |task| task.status }
    # end
end