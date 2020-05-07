
puts "This is a program that takes a year and judges whether it is a leap year or not. If you want to quit, type \"quit\"."

def isNum(input)
	result = true
	for i in 0...input.length
		if (input[i].to_i == 0) && (input[i] != "0")
			result = false
			break
		end
	end
	return result
end

while 1 do
	print "Type a year: "
	input = gets.chomp
	if input.downcase == "quit" 
		break
	elsif input == "0"
		puts "It does not exist, but it would be a leap year if it existed."
	elsif isNum(input) == false
		puts "Please give me a number."
	else
		year = input.to_i
		if year % 4 == 0
			if (year % 100 == 0) && (year % 400 != 0)
				puts "It is not a leap year."
			else
				puts "It is a leap year."
			end
		else
			puts "It is not a leap year."
		end
	end
end
