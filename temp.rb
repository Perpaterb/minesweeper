class Run
    m
    def initialize
        @game_state = "start"
        #@grid_values = create_starting_grid()
        @user_input = ""
        @mine_number = 10
    end
    attr_reader :running
    def start
       @running = true
    end
 
    def stop
       @running = false
    end
 end
 
 runner = Run.new
 p runner.mine_number
 runner.start
 p runner.running
 runner.stop 
 p runner.running