require "color_text"

# Tic Tac Toe Ruby Project!
# Start out by defining the places on the game board:

class Tic

  def initialize
    #map of all places that are possible wins
    @rows = [      
      [:a1,:a2,:a3],
      [:b1,:b2,:b3],
      [:c1,:c2,:c3],
      
      [:a1,:b1,:c1],
      [:a2,:b2,:c2],
      [:a3,:b3,:c3],
      
      [:a1,:b2,:c3],
      [:c1,:b2,:a3]
    ]
    
    @cpu = rand() > 0.5 ? 'X' : 'O'
    @user = @cpu == 'X' ? 'O' : 'X'
    
    @cpu_name = "HAL"
    put_line
    puts "\n  RUBY TIC TAC TOE".purple
    print "\n Welcome Challenger! What is your name?".neon
    STDOUT.flush
    @user_name = gets.chomp
    put_bar

    @user_score = 0
    @cpu_score = 0
    
    start_game(@user == 'X')
  end

  def start_game(user_goes_first)
    #the tic tac toe slots
    @boardplaces = {
      a1:" ",a2:" ",a3:" ",
      b1:" ",b2:" ",b3:" ",
      c1:" ",c2:" ",c3:" "
    }

    if user_goes_first
      user_turn
    else
      cpu_turn
    end
  end

  def restart_game(user_goes_first)
    (1...20).each { |i| put_line }
    start_game(user_goes_first)
  end
  
  def put_line
    puts ("-" * 80).gray
  end
  
  def put_bar
    puts ("#" * 80).gray
    puts ("#" * 80).gray
  end
  
  def render_game
    puts ""
    puts " Wins: #{@cpu_name}:#{@cpu_score} #{@user_name}:#{@user_score}".gray
    puts ""
    puts " #{@cpu_name}: #{@cpu.green}"
    puts " #{@user_name}: #{@user.green}"
    puts ""
    puts "     a   b   c".gray
    puts ""
    puts " 1   #{@boardplaces[:a1].green} | #{@boardplaces[:b1].green} | #{@boardplaces[:c1].green} ".gray
    puts "    --- --- ---"
    puts " 2   #{@boardplaces[:a2].green} | #{@boardplaces[:b2].green} | #{@boardplaces[:c2].green} ".gray
    puts "    --- --- ---"
    puts " 3   #{@boardplaces[:a3].green} | #{@boardplaces[:b3].green} | #{@boardplaces[:c3].green} ".gray
  end
  
  def cpu_turn
    move = cpu_find_move
    @boardplaces[move] = @cpu
    put_line
    puts " #{@cpu_name} marks #{move.to_s.upcase.green}".neon
    check_game(@user)
  end
  
  def cpu_find_move

    # see if cpu can win
    #see if any rows already have 2 (cpu)
    @rows.each do |row|
      if pieces_in_row(row, @cpu) == 2
        return empty_in_row row
      end
    end
    
    # see if user can win
    #see if any rows already have 2 (user)
    @rows.each do |row|
      if pieces_in_row(row, @user) == 2
        return empty_in_row row
      end
    end
    
    #see if any rows aready have 1 (cpu)
    @rows.each do |row|
      if pieces_in_row(row, @cpu) == 1
        return empty_in_row row
      end
    end
    
    #no strategic spot found so just find a random empty
    k = @boardplaces.keys;
    i = rand(k.length)
    if @boardplaces[k[i]] == " "
      return k[i]
    else
      #random selection is taken so just find the first empty slot
      @boardplaces.each { |k,v| return k if v == " " }
    end
  end
  
  def pieces_in_row arr, item
    times = 0
    arr.each do |i| 
      times += 1 if @boardplaces[i] == item
      unless @boardplaces[i] == item || @boardplaces[i] == " "
        #oppisite piece is in row so row cannot be used for win.
        #therefore, the strategic thing to do is choose a dif row so return 0.
        return 0
      end
    end
    times
  end
  
  def empty_in_row arr
    arr.each do |i| 
      if @boardplaces[i] == " "
        return i
      end
    end
  end
  
  def user_turn
    put_line
    puts "\n  RUBY TIC TAC TOE".purple
    render_game
    print "\n #{@user_name}, please make a move or type 'exit' to quit: ".neon
    STDOUT.flush
    input = gets.chomp.downcase.to_sym
    put_bar
    if input.length == 2
      a = input.to_s.split("")
      if(['a','b','c'].include? a[0])
        if(['1','2','3'].include? a[1])
          if @boardplaces[input] == " "
            @boardplaces[input] = @user
            put_line
            puts " #{@user_name} marks #{input.to_s.upcase.green}".neon
            check_game(@cpu)
          else
            wrong_move
          end
        else
          wrong_input
        end
      else
        wrong_input
      end
    else
      wrong_input unless input == :exit
    end
  end
  
  def wrong_input
    put_line
    puts " Please specify a move with the format 'A1' , 'B3' , 'C2' etc.".red
    user_turn
  end
  
  def wrong_move
    put_line
    puts " You must choose an empty slot".red
    user_turn
  end
  
  def moves_left
    @boardplaces.values.select{ |v| v == " " }.length
  end
  
  def check_game(next_turn)
  
    game_over = nil
    
    @rows.each do |row|
      # see if cpu has won
      if pieces_in_row(row, @cpu) == 3
        put_line
        render_game
        put_line
        puts ""
        puts " Game Over -- #{@cpu_name} WINS!!!\n".blue
        game_over = true
        @cpu_score += 1
        play_again_request(false)
      end
      # see if user has won
      if pieces_in_row(row, @user) == 3
        put_line
        render_game
        put_line
        puts ""
        puts " Game Over -- #{@user_name} WINS!!!\n".blue
        game_over = true
        @user_score += 1
        play_again_request(true)
      end
    end
    
    unless game_over
      if(moves_left > 0)
        if(next_turn == @user)
          user_turn
        else
          cpu_turn
        end
      else
        put_line
        render_game
        put_line
        puts ""
        puts " Game Over -- DRAW!\n".blue
        play_again_request(rand() > 0.5)
      end
    end
  end

  def play_again_request(user_goes_first)
    print " Play again? (Yn): "
    STDOUT.flush
    response = gets.chomp.downcase
    case response
    when "y"   then restart_game(user_goes_first)
    when "yes" then restart_game(user_goes_first)
    when "n"   then #do nothing
    when "no"  then #do nothing
    else play_again_request(user_goes_first)
    end
  end
  
end
