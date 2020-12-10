require 'colorize'
require 'tty-font'
require 'ruby-progressbar'
require 'simple-random'

fontblock = TTY::Font.new(:block)
fontstr = TTY::Font.new(:straight)
random = SimpleRandom.new 
puts `clear`
progressbar = ProgressBar.create(:title => "Loading", :starting_at => 0, :total => 50, format: "%t: |\e[0;34m%B\e[0m|")
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts random.uniform(1, 9.99999).to_i
# puts (fontblock.write("MINESWEEPER")).colorize(:blue)
# puts (fontstr.write("                    Press Enter To Start")).colorize(:blue)
# puts "This is blue".colorize(:blue)
# puts "This is light blue with red background".colorize(:color => :light_blue, :background => :red)
# puts "This is blue text on red".blue.on_red
50.times { progressbar.increment; sleep(0.05) }