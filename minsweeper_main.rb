# Gum for Coloured font
require 'colorize'
# Gum for font in title screen
require 'tty-font'
# Gum for font good random numbers for mine plasment.
require 'simple-random'
# Gum for loading bar game start
require 'ruby-progressbar'

fontblock = TTY::Font.new(:block)
fontstr = TTY::Font.new(:straight)
random = SimpleRandom.new 
progressbar = ProgressBar.create(:title => "Loading", :starting_at => 0, :total => 50, format: "%t: |\e[0;34m%B\e[0m|")

# This is creating the starting gring array 9 by 9 each array is [Row , column, state]
# The default empty state is "S"
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

# this is the load grind function that will print the Grid to the screen
def load_grid(grid_values, game_state)
    columns = "ABCDEFGHI".chars
    print "  "
    for i in columns
        print " #{i} ".colorize(:cyan)
    end
    puts ""
    
    for point_value in grid_values
        if point_value[1] == 1            
            print "#{point_value[0]} ".colorize(:cyan)
        end
        if point_value[2] == 0
            print "[ ]".colorize(:green)
        end 
        if point_value[2] == "S"
            print "   "
        end 
        if (1..8).include?(point_value[2])
            print " #{point_value[2]} ".colorize(:blue)
        end 
        if point_value[2] == "X" and game_state == "lost"
            print " #{point_value[2]} ".colorize(:red)
        end 
        if point_value[2] == "X" and game_state == "win"
            print " #{point_value[2]} ".colorize(:magenta)
        end 
        if point_value[2] == "X" and game_state != "lost" and game_state != "win"
            print "   "
        end 
        if point_value[1] == 9
            puts ""
        end
    end 
end

# this is the print message function that will print a mesage baced on the game state. start,win,lost,running,invalid input
def print_message(game_state)
    if game_state == "start"
        puts""
        print "What grid point would you like to start at? column row eg. a1 or a 1 :".colorize(:white)
    end
    if game_state == "win"
        puts""
        print "Congratulations you win!!    press enter to exit ".colorize(:white)
    end
    if game_state == "lost"
        puts""
        print "Sorry you lost..  press enter to exit ".colorize(:white)
    end
    if game_state == "running"
        puts""
        print "What grid point do you think does not have a mine?  ".colorize(:white)
    end
    if game_state == "invalid input"
        puts""
        print "invalid input try again:  column row eg. a1 or a 1 ".colorize(:white)
    end
end

# this is the chack user input functoion that will make sure a valid input has been enterd. eg. a1 or A1
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


# this is the Alfa to int function that turns the users input for Column in to an int 1-9 for a-i
# this function also flips the input so that it is now Row,Column not Column,Row as the user ented. this is to make printing the the terminal screen easy
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

# this is he Create first game grid function that takes the first input of the user and returns the grid after loading mine positions
def create_first_game_grid(grid_values, user_input)
    user_input << "S"
    start_pos = grid_values.index(user_input)
    user_input[2] = 0
    grid_values[start_pos] = user_input.map(&:clone)
    grid_values = load_mine_poses(grid_values, user_input)
    return grid_values
end 

# this is the load mine positions function that puts random mines on the grid everywere but the starting point and the 8 grid points arroind it
def load_mine_poses(grid_values, start_ops)
    mines = []
    exemption_list = get_poses_arround(start_ops)
    mines_placed = 0
    while mines_placed < 10
        # Using Gen to randomise numbers
        mine_test = [random.uniform(1, 9.99999).to_i,random.uniform(1, 9.99999).to_i]
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

# this is the get grid positions arround function that get the 8 grid points around a point if they they are on the board. e.g a1 only has 3 grid points arroind it. 
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

# this is the reveal points function that from a starting points reveals the start point. 
#       if it is a mine that game_state = "lost"
#       if it is not a mine reveals the number of mines next to it.
#       if that number is 0 then reveal all the points around it. 
#       if any of them are 0 then reveal all the all the points around them. 
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

# this is the Test for win function that tests for the number of grid points with the "S" state. 
#       if there are none left then the user has won!
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

# make sure gets works 
def gets
    STDIN.gets
end



# this is the Game

# strat by clearing the terminal screen
puts `clear`
# Welcome page 
puts (fontblock.write("MINESWEEPER")).colorize(:blue)
50.times { progressbar.increment; sleep(0.05) }
# set the game state to start
game_state = "start"
# Create the starting grid with the "creating the starting grid" function
grid_values = create_starting_grid()
# Start main game while loop.
while game_state != "lost" or game_state != "win"
    # 1st see if the game is won of not with the "Test for win" function
    game_state = test_for_win(grid_values, game_state)
    # 2nd clearing the terminal screen 
    puts `clear`
    # 3rd load the grid and print it to screen with the "Load Grid" function
    load_grid(grid_values, game_state)
    # 4th print the message to the user with the "print message" function 
    print_message(game_state)
    # 5th pause while we ask the user for input. 
    user_input = gets
    # 6th the main game loop is broken by game_state == "lost" or game_state == "win"
    if game_state == "lost" or game_state == "win"
        exit
    end
    # 7th take the user input and Check it with the "check user input" function
    user_input_is_ok = check_user_input(user_input)
    # 8th Get the output from "check user input" function and remap to new Array Var.
    curect_user_input = []
    curect_user_input[0] = user_input_is_ok[1]
    curect_user_input[1] = user_input_is_ok[2]
    t_user_input = curect_user_input.map(&:clone)
    # 9th change the alfa charicter in the user input to an int 1-9 for a-i using the "Alfa to int" function
    t_user_input = alfa_to_int_and_swap(t_user_input)
    let_first = 0
    # 10th if the users input is OK then run the calculation. else game_state = "invalid input".
    if user_input_is_ok[0] == true
        # 11th if the game_state = "start" then change game_state to "running" and run the "create first game grid" function.
        if game_state == "start"
            let_first = 1
            game_state = "running"
            grid_values = create_first_game_grid(grid_values, t_user_input)
        end
        # 12th Reveal all the point needed 
        retured = reveal_points(grid_values, t_user_input, let_first)
        game_state = retured[0]
        grid_values = retured[1]
    else
        game_state = "invalid input"
    end 
end


