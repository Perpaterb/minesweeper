require_relative '../minesweeper_main_class'

describe Minesweeper_Main do
    it 'should return curect grid coordinates or invalid input' do
        user_input = Minesweeper_Main.new("A1")
        expect(user_input.processed).to eq("a1")
    end
end