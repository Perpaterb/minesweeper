require_relative 'MS_play_main_class'

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
#msclass = MS_play_main.new 

# make sure gets works 
def gets
    STDIN.gets
end

# ##### this is the Game

# help file
if ARGV[0] == "-h" or ARGV[0] == "-help"
    puts "Help Doc TBA"
    exit!
end

# strat by clearing the terminal screen
puts `clear`
#comand line input for number of mines\ 
if ARGV[0] != nil 
    cla = ARGV[0].tr('^0-9', '').to_i
end
if cla == 0 or cla == nil
else
    msclass.update_mine_number(cla)
end
# Welcome page 
puts (fontblock.write("MINESWEEPER")).colorize(:blue)
50.times { progressbar.increment; sleep(0.02)}
# Start main game while loop.
while msclass.game_state != "lost" or msclass.game_state != "win"
    # 1st see if the game is won of not with the "Test for win" function
    msclass.test_for_win()
    # 2nd clearing the terminal screen 
    puts `clear`
    # 3rd load the grid and print it to screen with the "Load Grid" function
    msclass.load_grid()
    # 4th print the message to the user with the "print message" function 
    msclass.print_message()
    # 5th pause while we ask the user for input. 
    input = gets
    msclass.update_user_input(input)
    # 6th the main game loop is broken by game_state == "lost" or game_state == "win"
    if msclass.game_state == "lost" or msclass.game_state == "win"
        exit
    end
    # 7th take the user input and Check it with the "check user input" function
    msclass.check_user_input()
    # 8th if the users input is OK then run the calculation. else game_state = "invalid input".
    if msclass.passback[0] == true
        # 9th change the alfa charicter in the user input to an int 1-9 for a-i using the "Alfa to int" function
        msclass.alfa_to_int_and_swap()    
        # 10th if the game_state = "start" then change game_state to "running" and run the "create first game grid" function.
        if msclass.game_state == "start"
            msclass.update_game_state("running")
            msclass.create_first_game_grid()
        end
        # 11th Reveal all the point needed 
        msclass.reveal_points()
    else
        msclass.update_game_state("invalid input")
    end 
end

