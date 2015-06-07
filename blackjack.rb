#blackjack.rb

#makes a message
def say(msg)
  puts "------- #{msg} --------".center(75)
end

def calculate_total(card)
  arr = card.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
    total += 11
    elsif value.to_i == 0
    total += 10
    else
    total += value.to_i
    end
  end

  arr.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end
  total
end

#game introduction
say "Welcome to the table"
say "I'm sure you are aware that you are playing BlackJack"
say "but, if not let me define the rules for you."
say "Do you want me to tell you the rules? (Y/N)"

say_rules = gets.chomp.downcase
if say_rules == "y"
  say 'okay so we are playing to try and get a total of 21'
  say 'cards that have values are worth the value shown'
  say 'cards with faces have a value of 10 except'
  say 'A which can be 1 or 11. Your cards will be compared'
  say 'against the computers cards and the closest to 21 without'
  say 'going over wins. If you get a Jack(J) and a 10 you win'
  say 'automatically because you have Blackjack' 
else say_rules == 'n'
  say "okay so lets get to it"
end
  say 'Please what is your name?'
players_name = gets.chomp.downcase.capitalize!
  say "Welcome to the table #{players_name}!"


# making the deck
suits = ['Hearts', 'Clubs', 'Spades', 'Diamonds']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!
#dealing the cards

system 'clear'
mycards = []
dealercards = []  
mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop 
dealer_total = calculate_total(dealercards)
my_total = calculate_total(mycards) 
  
  case 
  when my_total == 21
    say "#{players_name} you have blackjack, you win!! your cards #{mycards}, dealer cards:#{dealercards}"
    exit #exits the program when blackjack is hit
  end

  
  case      
  when dealer_total == 21
    say "Sorry #{players_name} the dealer has blackjack you lose. Your cards: #{mycards}, Dealer cards: #{dealercards}"
    exit #exits the program when blackjack is hit
  end

  
  #saying your cards/total and asking to hit again or stay
  say "#{players_name} you have #{mycards[0]}, #{mycards[1]}! This comes to a total of #{my_total}"
  say "The dealer has #{dealercards[0]}, and #{dealercards[1]}! This comes to a total of #{dealer_total}" 
    
  #loop to decide if player wants to hit or stay  
  while my_total < 21
    say "#{players_name} would you like to 1) Hit or 2) Stay" 
    hit_or_stay = gets.chomp.downcase
    
    if !["1", "2"].include?(hit_or_stay)
      say "ERROR: input must be 1 or 2"
    elsif hit_or_stay == "2"
      say "#{players_name} you have #{mycards[0]}, #{mycards[1]} for a total of #{my_total}!"
      break
    else hit_or_stay == "1"
      mycards << deck.pop
      my_total = calculate_total(mycards)
      say "#{players_name} you have #{mycards} this is a total of #{my_total}!"
    end 
    
    if my_total > 21
    say "BUST"
    say "The dealer wins with #{dealer_total}"
    exit
    end 
  end
     
  while dealer_total < 17
    dealercards << deck.pop
    dealer_total = calculate_total(dealercards)
    say "The dealer has #{dealercards} and this is a total of #{dealer_total}!"

    if dealer_total > 21
      say "dealer Busts #{dealercards} total: #{dealer_total}"
    else 
      say "dealer has #{dealercards} total #{dealer_total}"
      break
    end 
  end
  
  my_total = calculate_total(mycards)
  dealer_total = calculate_total(dealercards) 
  #conditional statment to decide winner
  if my_total > dealer_total
    say "Congratulations #{players_name}, you won! you had #{my_total} and the dealer has #{dealer_total}!"
  elsif my_total < dealer_total 
    say "Sorry #{players_name} the dealer has won with a total of #{dealer_total}" 
  elsif my_total == dealer_total
    say "Its a push #{my_total} and #{dealer_total}"
  end 