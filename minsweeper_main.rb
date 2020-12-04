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
        print " #{i} ".gray
    end
    puts ""
    
    for point_value in grid_values
        if point_value[1] == 1            
            print "#{point_value[0]} ".gray
        end
        if point_value[2] == 0
            print "[ ]".green
        end 
        if point_value[2] == "S"
            print "   ".green
        end 
        if (1..8).include?(point_value[2])
            print " #{point_value[2]} ".blue
        end 
        if point_value[2] == "X" #and game_state == "lost"
            print " #{point_value[2]} ".red
        end 
        if point_value[2] == "X" and game_state == "win"
            print " #{point_value[2]} ".magenta
        end 
        if point_value[1] == 9
            puts ""
        end
    end 
end

def print_message(game_state)
    if game_state == "start"
        print "What grid point would you like to start at? column row eg. a1 or a 1 :"
    end
    if game_state == "win"
        print "Congratulations you win!!    press enter to exit "
    end
    if game_state == "lost"
        print "Sorry you lost..  press enter to exit "
    end
    if game_state == "running"
        print "What grid point do you think does not have a mine?  "
    end
    if game_state == "invalid input"
        print "invalid input try again:  column row eg. a1 or a 1 "
    end
end

def check_user_input(user_input)
    passback = []
    user_input = user_input.strip.gsub(/[^0-9a-z ]/i, '').delete(' ').chars
    if ("a".."i").to_a.include?(user_input[0].downcase) == true and (1..9).include?(user_input[1].to_i) == true
        passback[0] = true
        passback[1] = user_input[0].downcase
        passback[2] = user_input[1].to_i
    else
        passback[0] = false
    end
    return passback
end

def create_first_game_grid(grid_values, user_input)
    alfa = 1
        for i in ("a".."i")
            if user_input[0] == i
                user_input[0] = alfa
            end
            alfa = alfa +1
        end
    #swap user imput from cl column row to row column
    user_input[0], user_input[1] = user_input[1], user_input[0]
    user_input << "S"
    start_pos = grid_values.index(user_input)
    user_input[2] = 0
    grid_values[start_pos] = user_input.clone
    grid_values = load_mine_poses(grid_values, user_input)
    return ["running", grid_values]
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
            mine_test = mine_test.clone
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


def calculate(grid_values, user_input, game_state)
    returning []
    if game_state == "start"
        game_state = "running"
    end
    get_poses_arround(start_ops)

    return [game_state, grid_values]
end



puts `clear`
game_state = "start"
grid_values = create_starting_grid()
while game_state == "running" or game_state == "start"
    #puts `clear`
    load_grid(grid_values, game_state)
    print_message(game_state)
    user_input = gets
    user_input_is_ok = check_user_input(user_input)
    curect_user_input = []
    curect_user_input[0] = user_input_is_ok[1]
    curect_user_input[1] = user_input_is_ok[2]
    if user_input_is_ok[0] == true
        if game_state == "start"
            retured = create_first_game_grid(grid_values, curect_user_input)
        else
            retured = calculate(grid_values, curect_user_input, game_state)
        end
        game_state = retured[0]
        grid_values = retured[1]
    else
        game_state = "invalid input"
    end 
end





