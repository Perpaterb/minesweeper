require_relative '../minesweeper_main'

describe do
# should return true and curect grid coordinates or false
# this is supoer inportant as the users input needs to be in the currect format for the game to work.
    it do expect(check_user_input("A1")).to eq([true, "a", 1]) end
    it do expect(check_user_input("   D  4\n")).to eq([true, "d", 4]) end
    it do expect(check_user_input("  k  9")).to eq([false]) end
    it do expect(check_user_input("a29")).to eq([false]) end
end

describe do
    # should return curect grid coordinates in numbers starting with row and then column
    # this is supoer inportant as you print left to right on the screen not up to down.
    it do expect(alfa_to_int_and_swap(["a",1])).to eq([1,1]) end
    it do expect(alfa_to_int_and_swap(["d",4])).to eq([4,4]) end
    it do expect(alfa_to_int_and_swap(["i",2])).to eq([2,9]) end
    it do expect(alfa_to_int_and_swap(["f",9])).to eq([9,6]) end
end

describe do
    # stest for win state
    it do expect(test_for_win([[0,0,1],[0,1,1],[1,0,1],[1,1,"x"]],"running")).to eq("win") end
    it do expect(test_for_win([[0,0,"x"],[0,1,2],[1,0,2],[1,1,"x"]],"running")).to eq("win") end
    it do expect(test_for_win([[0,0,1],[0,1,1],[1,0,"S"],[1,1,"x"]],"running")).to eq("running") end
    it do expect(test_for_win([[0,0,"S"],[0,1,"S"],[1,0,"S"],[1,1,0]],"start")).to eq("start") end
end