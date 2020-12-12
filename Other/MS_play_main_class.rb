class MS_play_main
    attr_accessor :game_state
    attr_accessor :user_input
    attr_accessor :mine_number
    attr_accessor :passback

    def initialize
        @game_state = "start"
        @grid_values = create_starting_grid()
        @user_input = ""
        @mine_number = 10
    end

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
    def load_grid()
        columns = "ABCDEFGHI".chars
        print "  "
        for i in columns
            print " #{i} ".colorize(:cyan)
        end
        puts ""
        
        for point_value in @grid_values
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
            if point_value[2] == "X" and @game_state == "lost"
                print " #{point_value[2]} ".colorize(:red)
            end 
            if point_value[2] == "X" and @game_state == "win"
                print " #{point_value[2]} ".colorize(:magenta)
            end 
            if point_value[2] == "X" and @game_state != "lost" and @game_state != "win"
                print "   "
            end 
            if point_value[1] == 9
                puts ""
            end
        end 
    end

    # this is the print message function that will print a mesage baced on the game state. start,win,lost,running,invalid input
    def print_message()
        if @game_state == "start"
            puts""
            puts "There are #{mine_number} mines"
            print "What grid point would you like to start at? column row eg. a1 or a 1 :".colorize(:white)
        end
        if @game_state == "win"
            puts""
            print "Congratulations you win!!    press enter to exit ".colorize(:white)
        end
        if @game_state == "lost"
            puts""
            print "Sorry you lost..  press enter to exit ".colorize(:white)
        end
        if @game_state == "running"
            puts""
            puts "There are #{mine_number} mines"
            print "What grid point do you think does not have a mine?  ".colorize(:white)
        end
        if @game_state == "invalid input"
            puts""
            puts "There are #{mine_number} mines"
            print "invalid input try again:  column row eg. a1 or a 1 ".colorize(:white)
        end
    end

    # this is the chack user input functoion that will make sure a valid input has been enterd. eg. a1 or A1
    def check_user_input()
        @passback = []
        @passback[0] = false
        user_input = @user_input.strip.gsub(/[^0-9a-z ]/i, '').delete(' ').chars
        if user_input.length() == 2
            if ("a".."i").to_a.include?(user_input[0].downcase) == true and (1..9).include?(user_input[1].to_i) == true
                @passback[0] = true
                @passback[1] = user_input[0].downcase
                @passback[2] = user_input[1].to_i
            end
        end
        return @passback
    end


    # this is the Alfa to int function that turns the users input for Column in to an int 1-9 for a-i
    # this function also flips the input so that it is now Row,Column not Column,Row as the user ented. this is to make printing the the terminal screen easy
    def alfa_to_int_and_swap()
        @user_input = []
        @user_input[0] = @passback[2]
        @user_input[1] = @passback[1]
        alfa = 1
        for i in ("a".."i")
            if @user_input[1] == i
                @user_input[1] = alfa
            end
            alfa = alfa +1
        end
        #@user_input = user_input
        return @user_input
    end

    # this is he Create first game grid function that takes the first input of the user and returns the grid after loading mine positions
    def create_first_game_grid()
        @user_input << "S"
        start_pos = @grid_values.index(@user_input)
        @user_input[2] = 0
        @grid_values[start_pos] = @user_input.map(&:clone)
        @grid_values = load_mine_poses()
        return @grid_values
    end 

    # this is the load mine positions function that puts random mines on the grid everywere but the starting point and the 8 grid points arroind it
    def load_mine_poses()
        random = SimpleRandom.new 
        mines = []
        exemption_list = get_poses_arround(@user_input)
        mines_placed = 0
        while mines_placed < @mine_number
            # Using Gen to randomise numbers
            mine_test = [random.uniform(1, 9.99999).to_i,random.uniform(1, 9.99999).to_i]
            if exemption_list.include?(mine_test) == false
                mines_placed = mines_placed + 1
                exemption_list << mine_test
                mine_test = mine_test.map(&:clone)
                mine_test << "S"
                mine_pos = @grid_values.index(mine_test)
                mine_test[2] = "X"
                @grid_values[mine_pos] = mine_test
            end
        end
        return @grid_values
    end

    # this is the get grid positions arround function that get the 8 grid points around a point if they they are on the board. e.g a1 only has 3 grid points arroind it. 
    def get_poses_arround(start_pos)
        exemption_list = []
        @user_input.delete_at(2)
        for i in (-1..+1)
            r = @user_input[0] + i
            for a in (-1..+1)
                c = @user_input[1] + a
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
    def reveal_points()
        @game_state = "running"
        points_to_revile = [@user_input]
        for i in points_to_revile
            t_user_input = i.map(&:clone).join("").to_s.scan(/./).map {|e| e.to_i }
            t_grid_values = @grid_values.map(&:clone)
            for i in t_grid_values
                i.delete_at(2)
            end
            point_index = t_grid_values.find_index(t_user_input.to_a)
            point = @grid_values[point_index]
            if point[2] == 0 and @game_state == "start"
                poses_arroung = get_poses_arround(@user_input)
                poses_arroung.delete(@user_input)   
                for i in poses_arroung
                    points_to_revile << i
                end
            end
            if point[2] == "X"
                @game_state = "lost"

            end
            if point[2] == "S"
                t_point = point.map(&:clone)
                poses_arroung = get_poses_arround(t_point)
                poses_arroung.delete(t_point)
                
                mines_next_to_point = 0 
                for i in poses_arroung
                    t_mine_point = i.map(&:clone).join("").to_s.scan(/./).map {|e| e.to_i }
                    t_mine_values = @grid_values.map(&:clone)
                    for i in t_mine_values
                        i.delete_at(2)
                    end
                    mine_point = @grid_values[t_mine_values.find_index(t_mine_point.to_a)]               
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
                @grid_values[point_index] = point
            end
        end
    end

    # this is the Test for win function that tests for the number of grid points with the "S" state. 
    #       if there are none left then the user has won!
    def test_for_win() 
        number_of_s = 0
        for i in @grid_values
            if i[2] == "S"
                number_of_s = number_of_s + 1
            end
        end
        if number_of_s == 0
            @game_state = "win"
        end
        return @game_state
    end


    # update instance vars
    def update_game_state(a)
        @game_state = a
    end

    def update_user_input(a)
        @user_input = a
    end

    def update_mine_number(a)
        @mine_number = a
    end
end