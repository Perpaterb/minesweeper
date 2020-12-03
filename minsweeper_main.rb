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

def load_grid(grid_values, ended)
    colums = "ABCDEFGHI".chars
    print "  "
    for i in colums
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
        if (1..8).include?(point_value[2])
            print " #{point_value[2]} ".blue
        end 
        if point_value[2] == "X" #and game_state == "lost"
            print " #{point_value[2]} ".red
        end 
        if point_value[2] == "X" #and game_state == "win"
            print " #{point_value[2]} ".magenta
        end 
        if point_value[1] == 9
            puts ""
        end
    end 
end

def print_message(game_state)
    if game_state == "start"
        print "What grid point would you like to start at?  :"
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
        print "invalid input try again  "
    end
end

def check_user_imput(user_imput)
    passback = []
    user_imput = user_imput.strip.chars
    if ("a".."i").to_a.include?(user_imput[0].downcase) == true and (1..9).include?(user_imput[1].to_i) == true
        passback[0] = true
        passback[1] = user_imput[0].downcase
        passback[2] = user_imput[1].to_i
    else
        passback[0] = false
    end
    return passback
end

def create_game_grid(user_imput)
    grid_values = []

    return ["running", grid_values]
end 

def calculate(grid_values, user_imput, game_state)
    returning []
    if game_state == "start"
        game_state = "running"
    end


    return [game_state, grid_values]
end

game_state = "start"
grid_values = create_starting_grid()
while game_state == "running" or game_state == "start"
    load_grid(grid_values, game_state)
    print_message(game_state)
    user_imput = gets
    user_imput_is_ok = check_user_imput(user_imput)
    curect_user_imput = []
    curect_user_imput[0] = user_imput_is_ok[1]
    curect_user_imput[1] = user_imput_is_ok[2]
    if user_imput_is_ok[0] == true
        if game_state == "start"
            retured = create_game_grid(curect_user_imput)
        else
            retured = calculate(grid_values, curect_user_imput, game_state)
        end
        game_state = retured[0]
        grid_values = retured[1]
    else
        game_state = "invalid input"
    end 
end





