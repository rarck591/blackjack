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
puts ''
puts 'The dealer\'s cards are: ' + dealercards.to_s + ', for a total of ' + dealertotal.to_s + '.'
puts ''

# Player's turn

if playertotal == 21
    puts 'Blackjack! WINNER, WINNER! CHICKEN DINNER!!'
    puts ''
    exit
end

while playertotal < 21
  puts 'What would you like to do?  1) Hit 2) Stand'
  action = gets.chomp
  puts ''

  if !['1', '2'].include?(action)
    puts 'Let\'s try this again.'
    puts ''
    puts 'Please type the number "1" or "2;" then hit Enter.'
    puts ''
    next
  end

  if action == '2'
    puts 'Player stands.'
    puts ''
    break
  end

  # Player chooses to hit

  hit_card = deck.pop
  playercards.push(hit_card)
  playertotal = calculate_total(playercards)
  puts ''
  puts 'Player receives a ' + hit_card.to_s + '.'
  puts 'Your current total is ' + playertotal.to_s + '.'
  puts ''

  if playertotal == 21
    puts playertotal.to_s + 'Charlie Sheen up in here. WINNING!!'
    puts ''
    puts 'Sorry. That was terrible...'
    puts ''
    puts '...I need new material.'
    puts ''
  elsif playertotal > 21
    puts 'Sorry, Player. Shakedown. Breakdown. You\'re busted!'
    puts ''
    puts 'Wow. I just referenced a song from the late 80s...'
    puts ''
    puts '...I need new material.'
    puts ''
    exit
  end
end

# Dealer's turn

if dealertotal == 21
  puts 'BLACKJACK! Dealer wins!'
  puts ''
  exit
end

while dealertotal < 17
  # Dealer has to hit
  puts 'Dealer hits.'
  hit_card = deck.pop
  dealercards.push(hit_card)
  dealertotal = calculate_total(dealercards)
  puts ''
  puts 'Dealer receives a ' + hit_card.to_s + ' and now has ' + dealertotal.to_s + '.'
  puts ''

  if dealertotal == 21
    puts 'Dealer has 21. Dealer wins!'
    puts ''
    exit
  elsif dealertotal > 21
    puts 'The dealer\'s just like these BALCO athletes - BUSTED! You win!'
    puts ''
    exit
    
    
  end
end

# Showdown - Comparing hands

puts 'Dealer has ' + dealertotal.to_s + ', and you have ' + playertotal.to_s + '.'
puts ''

if dealertotal > playertotal
  puts 'Like Pablo Escobar, the dealer wins!'
  puts ''
elsif dealertotal < playertotal
  puts 'You win! Make that money, Player!'
  puts ''
else 
  puts 'Push.' 
  puts ''
end
