class String
    def black;          "\033[30m#{self}\033[0m" end
    def red;            "\033[31m#{self}\033[0m" end
    def green;          "\033[32m#{self}\033[0m" end
    def brown;          "\033[33m#{self}\033[0m" end
    def blue;           "\033[34m#{self}\033[0m" end
    def magenta;        "\033[35m#{self}\033[0m" end
    def cyan;           "\033[36m#{self}\033[0m" end
    def gray;           "\033[37m#{self}\033[0m" end
end

def create_starting_grid()
    grid_values = []
    for a in 1..9
        for b in 1..9
            point_value = [a, b, "S"]
            grid_values << point_value 
        end
    end
    return grid_values
end

def load_grid(grid_values, game_state)
    columns = "ABCDEFGHI".chars
    print "  "
    for i in columns
        print " #{i} ".cyan
    end
    puts ""
    
    for point_value in grid_values
        if point_value[1] == 1            
            print "#{point_value[0]} ".cyan
        end
        if point_value[2] == 0
            print "[ ]".green
        end 
        if point_value[2] == "S"
            print "   "
        end 
        if (1..8).include?(point_value[2])
            print " #{point_value[2]} ".blue
        end 
        if point_value[2] == "X" and game_state == "lost"
            print " #{point_value[2]} ".red
        end 
        if point_value[2] == "X" and game_state == "win"
            print " #{point_value[2]} ".magenta
        end 
        if point_value[2] == "X" and game_state != "lost" and game_state != "win"
            print "   "
        end 
        if point_value[1] == 9
            puts ""
        end
    end 
end

def print_message(game_state)
    if game_state == "start"
        puts""
        print "What grid point would you like to start at? column row eg. a1 or a 1 :"
    end
    if game_state == "win"
        puts""
        print "Congratulations you win!!    press enter to exit "
    end
    if game_state == "lost"
        puts""
        print "Sorry you lost..  press enter to exit "
    end
    if game_state == "running"
        puts""
        print "What grid point do you think does not have a mine?  "
    end
    if game_state == "invalid input"
        puts""
        print "invalid input try again:  column row eg. a1 or a 1 "
    end
end

def check_user_input(user_input)
    passback = []
    passback[0] = false
    user_input = user_input.strip.gsub(/[^0-9a-z ]/i, '').delete(' ').chars
    if ("a".."i").to_a.include?(user_input[0].downcase) == true and (1..9).include?(user_input[1].to_i) == true
        passback[0] = true
        passback[1] = user_input[0].downcase
        passback[2] = user_input[1].to_i
    end
    return passback
end

def alfa_to_int_and_swap(user_input)
    alfa = 1
        for i in ("a".."i")
            if user_input[0] == i
                user_input[0] = alfa
            end
            alfa = alfa +1
        end
    #swap user imput from cl column row to row column
    user_input[0], user_input[1] = user_input[1], user_input[0]
end


def create_first_game_grid(grid_values, user_input)
    user_input << "S"
    start_pos = grid_values.index(user_input)
    user_input[2] = 0
    grid_values[start_pos] = user_input.map(&:clone)
    grid_values = load_mine_poses(grid_values, user_input)
    return grid_values
end 

def load_mine_poses(grid_values, start_ops)
    mines = []
    exemption_list = get_poses_arround(start_ops)
    mines_placed = 0
    while mines_placed < 10
        mine_test = [rand(1..9),rand(1..9)]
        if exemption_list.include?(mine_test) == false
            mines_placed = mines_placed + 1
            exemption_list << mine_test
            mine_test = mine_test.map(&:clone)
            mine_test << "S"
            mine_pos = grid_values.index(mine_test)
            mine_test[2] = "X"
            grid_values[mine_pos] = mine_test
        end
    end
    return grid_values
end

def get_poses_arround(start_ops)
    exemption_list = []
    start_ops.delete_at(2)
    for i in (-1..+1)
        r = start_ops[0] + i
        for a in (-1..+1)
            c = start_ops[1] + a
            if r > 0 and r < 10 and c > 0 and c < 10
                exemption_list << [r,c]
            end
        end
    end
    return exemption_list
end

def reveal_points(grid_values, start_point, let_first)
    game_state = "running"
    points_to_revile = [start_point]
    for i in points_to_revile
        t_start_point = i.map(&:clone).join("").to_s.scan(/./).map {|e| e.to_i }
        t_grid_values = grid_values.map(&:clone)
        for i in t_grid_values
            i.delete_at(2)
        end
        point_index = t_grid_values.find_index(t_start_point.to_a)
        point = grid_values[point_index]
        if point[2] == 0 and let_first == 1
            poses_arroung = get_poses_arround(start_point)
            poses_arroung.delete(start_point)   
            for i in poses_arroung
                points_to_revile << i
            end
        end
        if point[2] == "X"
            game_state = "lost"

        end
        if point[2] == "S"
            t_point = point.map(&:clone)
            poses_arroung = get_poses_arround(t_point)
            poses_arroung.delete(t_point)
             
            mines_next_to_point = 0 
            for i in poses_arroung
                t_mine_point = i.map(&:clone).join("").to_s.scan(/./).map {|e| e.to_i }
                t_mine_values = grid_values.map(&:clone)
                for i in t_mine_values
                    i.delete_at(2)
                end
                mine_point = grid_values[t_mine_values.find_index(t_mine_point.to_a)]               
                if  mine_point[2] == "X"
                    mines_next_to_point = mines_next_to_point + 1
                end
            end
            if mines_next_to_point == 0
                for m in poses_arroung
                    if points_to_revile.include?(m) == false
                        points_to_revile << m
                    end
                end
            end
            point[2] = mines_next_to_point
            grid_values[point_index] = point
        end
    end

    returned = [game_state, grid_values]
    return returned
end

def test_for_win(grid_values, game_state) 
    number_of_s = 0
    for i in grid_values
        if i[2] == "S"
            number_of_s = number_of_s + 1
        end
    end
    if number_of_s == 0
        game_state = "win"
    end
    return game_state
end 


puts `clear`
game_state = "start"
grid_values = create_starting_grid()
while game_state != "lost" or game_state != "win"
    game_state = test_for_win(grid_values, game_state)    
    puts `clear`
    load_grid(grid_values, game_state)
    print_message(game_state)
    user_input = gets
    if game_state == "lost" or game_state == "win"
        exit
    end
    user_input_is_ok = check_user_input(user_input)
    curect_user_input = []
    curect_user_input[0] = user_input_is_ok[1]
    curect_user_input[1] = user_input_is_ok[2]
    t_user_input = curect_user_input.map(&:clone)
    t_user_input = alfa_to_int_and_swap(t_user_input)
    let_first = 0
    if user_input_is_ok[0] == true
        
        if game_state == "start"
            let_first = 1
            game_state = "running"
            grid_values = create_first_game_grid(grid_values, t_user_input)
        end
        retured = reveal_points(grid_values, t_user_input, let_first)
        game_state = retured[0]
        grid_values = retured[1]
    else
        game_state = "invalid input"
    end 
end

