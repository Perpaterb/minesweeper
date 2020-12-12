require_relative 'minesweeper_main'

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
progressbar = ProgressBar.create(:title => "Loading", :starting_at => 0, :total => 50, format: "%t: |\e[0;34m%B\e[0m|")

# make sure gets works 
def gets
    STDIN.gets
end

##### this is the Game

# help
if ARGV[0] == "-h" or ARGV[0] == "-help"
    puts "Help Doc TBA"
    exit!
end

# strat by clearing the terminal screen
puts `clear`
#comand line input for number of mines\ 
mine_number = 10
if ARGV[0] != nil 
    cla = ARGV[0].tr('^0-9', '').to_i
end
if cla == 0 or cla == nil
else
    if cla < 73 and cla > 0
        mine_number = cla
    end
end

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
    print_message(game_state, mine_number)
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
            grid_values = create_first_game_grid(grid_values, t_user_input, mine_number)
        end
        # 12th Reveal all the point needed 
        retured = reveal_points(grid_values, t_user_input, let_first)
        game_state = retured[0]
        grid_values = retured[1]
    else
        game_state = "invalid input"
    end 
end