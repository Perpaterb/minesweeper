require 'simple-random'

random = SimpleRandom.new 

array = [] 
array2 = [] 

for i in 1..1000000
    number = random.uniform(0, 21).to_i
    if array[number] == nil
        array[number] = 1
    else
        array[number] += 1
    end

    number = rand(0..20)
    if array2[number] == nil
        array2[number] = 1
    else
        array2[number] += 1
    end
end

p array
p array2

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
#50.times { progressbar.increment; sleep(0.05) }