#baseball game

def isCorrect(answer, input)
	#get two array of numbers and compare
	$try += 1
	strike = 0
	ball = 0
	input.each do |num|
		if answer.include?(num)
			ball += 1
		end
	end
	for i in 0...input.size
		if input[i] == answer[i]
			ball -= 1
			strike += 1
		end
	end
	puts strike.to_s + "S" + ball.to_s + "B"
	if strike == 4
		return true
	else
		return false
	end
end

def newGame
	$try = 0
	$isGaming = true
	$startTime = Time.now
	answer = Array.new
	newNum = rand(9)
	answer.push(newNum)
	for i in 1...4
		while answer.include?(newNum)
			newNum = rand(9)
		end
		answer.push(newNum)
	end
	puts "The game starts. Guess the number!"
	#print "[DEBUG] "
	#answer.each {|num| print num}
	#puts ""
	return answer
end

def checkInput(input)
	if input.length != 4
		return nil
	else
		inputArray = Array.new
		for i in 0...4
			converted = input[i].to_i
			if (converted == 0) && (input[i] != "0")
				return nil
			else
				if inputArray.include?(converted)
					return nil
				else
					inputArray.push(converted)
				end
			end
		end
	end
	return inputArray
end

def youWin
	$isGaming = false
	endTime = Time.now
	gameTime = Time.at(endTime - $startTime).utc.strftime("%H:%M:%S")
	puts "Yes! You got it. What's your name?"
	print "Your name: "
	name = gets.chomp 
	file = File.new("baseball game score.txt", "a")
	file.puts "[ #{name} / #{$try} / #{gameTime} ]"
	file.close
	puts "If you want to start another game, type \"new\"."
end
			
		


puts "This is a baseball game. If you want to quit, type \"quit\"."
puts "If you want to start a new game, type \"new\"."
$try = 0
$startTime = Time.now
$isGaming = false
$answer = newGame()

while 1 do
	print "Input: "
	input = gets.chomp
	if input.downcase == "quit"
		break
	elsif input.downcase == "new"
		$answer = newGame()
	elsif !$isGaming
		puts "If you want to start a new game, type \"new\"."
	else
		inputArray = checkInput(input)
		if inputArray == nil
			puts "Oops, please type 'four diffrent numbers'."
		else
			#it is a answer in right format
			if isCorrect($answer, inputArray)
				youWin()
			end
		end
	end
end
	
