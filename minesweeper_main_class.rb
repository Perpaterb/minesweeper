


class Minesweeper_Main

    def initialize(user_input)
        @user_input = user_input
        @passback = [false]
    end

    def check_user_input()
        user_input = @user_input.chomp.strip.gsub(/[^0-9a-z ]/i, '').delete(' ').chars
        if user_input.length() == 2
            if ("a".."i").to_a.include?(user_input[0].downcase) == true and (1..9).include?(user_input[1].to_i) == true
                @passback[0] = true
                @passback[1] = user_input[0].downcase
                @passback[2] = user_input[1].to_i
            end
        end
        return @passback
    end 
    
    def alfa_to_int_and_swap()
        @user_input = []
        @user_input[0] = @passback[2]
        @user_input[1] = @passback[1]
        p @user_input
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

end