
puts "This is a program that takes a year and judges whether it is a leap year or not. If you want to quit, type \"quit\"."

while 1 do
	print "Type a year: "
	input = gets.chomp
	if input.downcase == "quit" 
		break
	elsif input == "0"
		puts "It does not exist, but it would be a leap year if it existed."
	else
		year = input.to_i
		if year == 0
			puts "Please give me a number."
		elsif year % 4 == 0
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
