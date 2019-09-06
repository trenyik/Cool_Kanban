require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra-websocket'
require './lib/user'
require './lib/board'
require './lib/task'
require './lib/column'




class Server < Sinatra::Base
    
    enable :sessions

    set :sockets, Hash.new

    get '/' do
        erb :boards, :locals => { boards: Board.all }
    end

    post "/boards/:board_id/columns/:column_id/tasks" do |board_id, column_id|
        puts params.inspect
        title = params['title'] || "task"
        status = params['status'] || nil
        text = params['text']
        user_id = params['user_id'] || 1
        Task.create(title: title, status: status, text: text, user_id: user_id, column_id: column_id.to_i )
        board_that_we_found = Board.find(board_id)
        erb :single_board, :locals => { matching_board: board_that_we_found }
    end

    post "/boards" do
        users_chosen_title = params["title"]
        created_board = Board.create(title: users_chosen_title)
        to_do_column = Column.create(name: 'to-do', board_id: created_board.id)
        doing_column = Column.create(name: 'doing', board_id: created_board.id)
        done_column = Column.create(name: 'done', board_id: created_board.id)
        # array_of_users_column_names = params["columns"].split(",")
        # array_of_users_column_names.each do |chosen_name|
        #     Column.create(board_id: created_board.id, name: chosen_name)
        # end
        erb :boards, :locals => {boards: Board.all}
        # binding.pry
    end

    get '/board/:id/socket' do |board_id|
        request.websocket do |ws|
            ws.onopen do
                if settings.sockets.key?(board_id)
                    settings.sockets[board_id] << ws
                else
                    settings.sockets[board_id] = [ws]
                end
            end

            ws.onmessage do |msg|
                action,message = msg.split("<*>")
                if action == "create"
                    column_id,text,user_id = message.split("|")
                    task = Task.create(title: "task", text: text, user_id: user_id, column_id: column_id)
                elsif action == "update"

                elsif action == "delete"
                end
                settings.sockets[board_id].each { |ws| ws.send([task.id, task.column_id, task.text, task.user_id].join("|"))}
            end
            ws.onclose do
                settings.sockets[board_id].delete(ws)
            end
        end
    end
    
    get '/board/:board_id' do |board_id|
        board_that_we_found = Board.find(board_id)
        # binding.pry 
        erb :single_board, :locals => { matching_board: board_that_we_found }
    end

    get "/boards/:board_id/delete" do |board_id|
        Board.find(board_id).destroy
        erb :boards, :locals => { boards: Board.all }
      end
# 
      get "/task/:task_id/delete" do |task_id|
        task_we_are_about_to_delete = Task.find(task_id)
        # Task.find(task_id).destroy
        column_of_the_task_we_will_delete = task_we_are_about_to_delete.column
        board_we_should_use = column_of_the_task_we_will_delete.board

        # binding.pry
        task_we_are_about_to_delete.destroy
        
        erb :single_board, :locals => { matching_board: board_we_should_use }
      end
end