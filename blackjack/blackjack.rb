#Interactive Blackjack Game

puts 'Welcome to Blackjack! Place your bets!'

puts ''

suits = ['Clubs', 'Diamonds', 'Hearts', 'Spades']

cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K','A']

deck = suits.product(cards)

deck.shuffle!

# Deal Cards

playercards = []

dealercards = []

playercards << deck.pop

dealercards << deck.pop

playercards << deck.pop

dealercards << deck.pop

def calculate_total(cards) 
    # [['clubs', '3'], ['spades', 'J'], ['hearts', 'A'], ... ]

    arr = cards.map{|e| e[1] }

    total = 0

    arr.each do |value|
        if value == 'A'
            total = total + 11
        elsif value.to_i == 0 # J, Q, or K
            total = total + 10
        else
            total = total + value.to_i
        end
    end

    # Correction for Aces
    arr.select{|e| e == 'A'}.count.times do
        if total > 21
        total = total - 10
        end

        if arr.include?('A') && total > 21
        total = total - 10
        end
    end
    total 
end

playertotal = calculate_total(playercards)

dealertotal = calculate_total(dealercards)

puts 'The player\'s cards are: ' + playercards.to_s + ', for a total of ' + playertotal.to_s + '.'

puts 'The dealer\'s cards are: ' + dealercards.to_s + ', for a total of ' + dealertotal.to_s + '.'

if playertotal == 21
	puts 'Blackjack! WINNER, WINNER! CHICKEN DINNER!!'
elsif playertotal > 21
	puts 'Player busts. Place your bets.'
else dealertotal > 21
	puts 'Dealer busts. You win!'
end

puts ''

while playertotal < 21
  puts 'What would you like to do?  1) Hit 2) Stand'
  action = gets.chomp
end
