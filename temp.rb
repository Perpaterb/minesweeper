
user_imput = gets
user_imput = user_imput.strip.chars
p user_imput
if ("a".."i").to_a.include?(user_imput[0].downcase) == true and (1..9).include?(user_imput[1].to_i) == true
    p "yay"
else
    p "boo"
end