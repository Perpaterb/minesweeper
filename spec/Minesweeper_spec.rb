require_relative '../minesweeper_main_class'

describe Minesweeper_Main do
    # should return true and curect grid coordinates or false
    it do expect(Minesweeper_Main.new("A1").check_user_input).to eq([true, "a", 1]) end
    it do expect(Minesweeper_Main.new("   D  4\n").check_user_input).to eq([true, "d", 4]) end
    it do expect(Minesweeper_Main.new("  k  9").check_user_input).to eq([false]) end
    it do expect(Minesweeper_Main.new("a29").check_user_input).to eq([false]) end
end

describe Minesweeper_Main do
    # should return curect grid coordinates in numbers starting with row and then column
    it do expect(Minesweeper_Main.new("A1").check_user_input.alfa_to_int_and_swap).to eq([1,1]) end
    it do expect(Minesweeper_Main.new("   D  4\n").check_user_input.alfa_to_int_and_swap).to eq([4,4]) end
    it do expect(Minesweeper_Main.new("  i  2").check_user_input.alfa_to_int_and_swap).to eq([2,9]) end
    it do expect(Minesweeper_Main.new("F9").check_user_input.alfa_to_int_and_swap).to eq([9,6]) end
end