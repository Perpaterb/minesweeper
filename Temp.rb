card_1 = rand(1..13)
card_2 = rand(1..13)
card_3 = rand(1..13)

array = [card_1, card_2].sort

puts card_1
puts card_2
user_input = gets.chomp

if card_3 == card_2 or card_3 == card_1
    answer = "fail"
else
    if card_3 > card_2 or card_3 < card_1
        answer = "outside"
    else 
        answer = "inside"
    end
end

if user_input == answer
    puts "Currect"
else
    puts "incurect"
end 

puts card_3