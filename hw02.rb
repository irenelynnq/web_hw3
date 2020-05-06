#This is a vending machine.

$max_stock = 5
class Drink
	def initialize(name, price)
		@name = name
		@price = price
		@stock = $max_stock
	end

	def fill
		@stock = $max_stock
	end

	def getStock
		@stock
	end

	def getName
		@name
	end

	def getPrice
		@price
	end

	def sell(count)
		#this method does not check stock. vending machine should check it.
		@stock -= count
		file = File.new("sales_log.txt", "a")
		file.puts @name.ljust(15) + count.to_s.ljust(10) + Time.now.strftime("%Y/%m/%d %H:%M:%S")
		file.close
	end
end

$vending_machine = Array.new
$money = 0

def fillStock
	$vending_machine.each do |drink|
		drink.fill
	end
	settle()
end

def settle
	file = File.new("sales_log.txt", "a")
	file.puts "Fill stock at " + Time.now.strftime("%Y/%m/%d %H:%M:%S") + "."
	sum = 0
	$vending_machine.each do |drink|
		sum += drink.getPrice * $max_stock
	end
	$money += sum
	file.puts "Earned " + sum.to_s + "won. In total, " + $money.to_s + "won."
	file.close
end

def printStock
	isSoldOut = true
	for i in 0...4
		unless $vending_machine[i].getStock < 1
			puts (i+1).to_s + ": " + $vending_machine[i].getName
			isSoldOut = false
		end
	end
	if isSoldOut
		puts "Filling the Stock..."
		fillStock()
		printStock()
	end
end

def sellDrink(num)
	drinkWanted = $vending_machine[num-1]
	if drinkWanted.getStock < 1
		puts "Sorry. #{drinkWanted.getName} is sold out."
	else
		drinkWanted.sell(1)
		puts "Here is your #{drinkWanted.getName}!"
	end
end


#start vending machine!
file = File.new("sales_log.txt", "w")
file.puts "This is a sales log of a vending machine."
file.puts "name".ljust(15) + "count".ljust(5) + "time"
file.close

$vending_machine.push(Drink.new("Coke", 1000))
$vending_machine.push(Drink.new("Water", 600))
$vending_machine.push(Drink.new("Coffee", 700))
$vending_machine.push(Drink.new("Black Tea", 900))


puts "Hello. This is a vending machine. let's start today's sales."
puts "If you want to shut down the machine, type \"close\"."

while 1 do
	puts "What do you want? Pick a number."
	printStock
	print"Pick: "
	input = gets.chomp
	
	if input.downcase == "close"
		break
	elsif (input.length > 1) || (input.to_i < 1) || (input.to_i > 4)
		puts "Sorry, it is not available. Please pick a number between 1 and 4."
	else
		sellDrink(input.to_i)
	end
end


$vending_machine.each do |drink|
	$money += (drink.getPrice) * ($max_stock - drink.getStock)
end


file = File.new("sales_log.txt", "a")
file.puts "The vending machine is closed at " + Time.now.strftime("%Y/%m/%d %H:%M:%S") + "."
file.puts "In total, " + $money.to_s + "won was earned."

puts "Okay. Let's call it a day! I made a sales log for you. You can check it in the folder. Bye!"

