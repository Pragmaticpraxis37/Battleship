class Messages
  def welcome_message
    puts "Welcome to BATTLESHIP Enter p to play. Enter q to quit."
  end

  def main_menu_invalid
    puts "Come on. Use p or q"
  end

  def player_ship_cruiser_message
    sleep(1)
    puts "My ships are hiddin in the mists!"
    sleep(2)
    puts "You now need to lay out your two ships."
    puts "Your Cruiser be three units long and your Submarine be two units long."
    puts "... Do no place ships backwards."
    sleep(2)
  puts "  1 2 3 4"
  puts "A . . . ."
  puts "B . . . ."
  puts "C . . . ."
  puts "D . . . ."
  puts "Place your cruiser already so I can sink it! (3 spaces):"
  puts ">"
  end

  def submarine_place_message
    puts "Where be you hiding your submarine? (2 spaces):\n>"
  end

  def player_boarder
    puts "==============PLAYER BOARD=============="
  end

  def computer_boarder
    puts "=============COMPUTER BOARD============="
  end

  def invalid_placement_message
    puts "I'll give ya another chance at this, Try Again"
  end

  def invalid_shot_message
    puts "You can't shoot there you no good cheater! Try again"
  end

  def player_shoot_message
    puts 'Where are you aiming your cannons?'
  end

  def computer_shot_miss(shoot)
    puts "ARGGGH I missed ya at #{shoot}."
  end

  def computer_shot_hit(shoot)
    puts "Looks like I hit ya at #{shoot}. Where is the rest of that boat?"
  end

  def player_shot_miss(user_coordinate)
    puts "Not even close! Your shot at #{user_coordinate} was a miss."
  end

  def player_shot_hit(user_coordinate)
    puts "AHHH patch that leak at #{user_coordinate} sailer!"
  end

  def cpu_win_message
    puts "I win..I shoot randomly. Are you even playing?"
  end

  def player_win_message
    puts "You win..I dare ya to play again!!"
  end
end
