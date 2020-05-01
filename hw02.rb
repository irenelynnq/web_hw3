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
		@price -= count
		file = File.new("sales_log.txt", "a")
		file.puts @name.ljust(15) + count.to_s.ljust(5) + Time.now.strftime("%Y/%m/%d %H:%M:%S")
		file.close
	end
end

$vending_machine = Array.new
$money = 0

def fillStock
	$vending_machine.each do |drink|
		drink.fill
	end
end

def settle
	file = File.new("sales_log.txt", "a")
	file.puts "Fill stock at " + Time.now.strftime("%Y/%m/%d %H:%M:%S") + "."
	sum = 0
	$vending_machine.each do |drink|
		sum += drink.getPrice * $max_stock
	end
	money += sum
	file.puts "Earned " + sum.to_s + "won. In total, " money.to_s + "won."
	file.close
end

def printStock
	for i in 0...4
		unless $vending_machine[i].getStock <= 0
			puts (i+1).to_s + ": " + $vending_machine[i].getName
		end
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


fillStock

puts "Hello. This is a vending machine. let's start today's sales."
puts "If you want to shut down the machine, type \"close\"."

while 1 do
	puts "Hello. What do you want? Pick a number."
	printStock
	print"Pick: "
	input = gets.chomp
	
	if input.downcase == "close"
		break
	elsif
	else
	end
end


$vending_machine.each do |drink|
	money += drink.getPrice * ($max_stock - drink.getStock)
end


file = File.new("sales_log.txt", "w")
file.puts "The vending machine is closed at " + Time.now.strftime("%Y/%m/%d %H:%M:%S") + "."
file.puts "In total, " + money.to_s + "won was earned."

puts "Okay. Let's call it a day! I made a sales log for you. You can check it in the folder. Bye!"

