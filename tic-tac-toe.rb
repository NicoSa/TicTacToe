
# Tic Tac Toe Ruby Project!

# Start out by defining the places on the game board:

def game_init
@boardplaces = { 
            "a1"=>" ","a2"=>" ","a3"=>" ",
            "b1"=>" ","b2"=>" ","b3"=>" ",
            "c1"=>" ","c2"=>" ","c3"=>" ",
          }

@winningrows = [
        [ 'a1', 'a2', 'a3'],
        [ 'b1', 'b2', 'b3'],
        [ 'c1', 'c2', 'c3'],
        [ 'a1', 'b1', 'c1'],
        [ 'a2', 'b2', 'c2'],
        [ 'a3', 'b3', 'c3'],
        [ 'a1', 'b2', 'c3'],
        [ 'c1', 'b2', 'a3']
    ]         

    @cpu = rand() > 0.5 ? 'X' : 'O'
    @user = @cpu == 'X' ? 'O' : 'X'

    @cpu_name = "Ruby"
    put_line
    puts " TIC TAC TOE - Ruby Edition! "
    puts "Welcome challenger, what is your name?"
    STDOUT.flush
    @user_name = gets.chomp
    put_bar

    if(@user == 'X')
    	user_turn
    else
    	cpu_turn
    end


def put_line
	puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
end

def put_bar
	puts "#####################################################"
	puts "#####################################################"
end	

def game_render
	puts ""
	puts "#{cpu_name}: #{@cpu}"
	puts "#{user_name}: #{@user}"
	puts ""
	puts "   a b c"
	puts ""
	puts " 1 #{@boardplaces["a1"]}|#{@boardplaces["b1"]}|#{@boardplaces["c1"]}"
	puts "   -----"
	puts " 2 #{@boardplaces["a2"]}|#{@boardplaces["b2"]}|#{@boardplaces["c2"]}"
	puts "   -----"
	puts " 3 #{@boardplaces["a3"]}|#{@boardplaces["b3"]}|#{@boardplaces["c3"]}"
end

def cpu_turn
	move = cpu_decide_move
	@boardplaces[move] = @cpu
	put_line
	puts "#{cpu_name} marks #{move.upcase}"
	check_game(@user)
end	

def pieces_on_board(pieces)
	appears = 0
	arr.each do |ele|
		appears += 1 if @places[ele] == pieces
		unless @places[ele] == item || @places[ele] == " "
			return 0
		end	
	end	
end
    appears
end

def empty_board_space arr
    arr.each do |i|
       if @places[i] == " "
       	return i
       end
    end   
end

def cpu_decide_move
	@winningrows.each do |row|
		if pieces_on_board(row, @cpu) == 2
			return empty_board_space row
		end
	end

	@winningrows.each do |row|
		if pieces_on_board(row, @user) == 2
			return empty_board_space row
		end
	end

	@winningrows.each do |row|
		if pieces_on_board(row, @cpu) == 1
			return empty_board_space row
		end
	end


k = @boardplaces.keys;
i = rand(k.length)
if @boardplaces[k[i]] == " "
	return k[i]
	else
		@boardplaces.each { |k,v| return k if v == " " }
	end
end

def user_turn
put_line
puts "Tic Tac Toe, GO!"
puts game_render
puts "#{@user_name}, please make a move or type 'exit' to quit"	
STDOUT.flush
input = gets.chomp.downcase
put_bar
if input.length == 2
	a = input.split("")
	if(['a','b','c'].include? a[0])
		if (['1','2','3'].include? a[1])
			if @boardplaces[input] == " "
				@boardplaces[input] = @user
				put_line
				puts "#{user_name} marks #{input.upcase}"
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
	wrong_input unless input == 'exit'
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
    @places.values.select{ |v| v == " " }.length
  end
  
  def check_game(next_turn)
  
    game_over = nil
    
    @rows.each do |row|
      # see if cpu has won
      if pieces_on_board(row, @cpu) == 3
        put_line
        game_render
        put_line
        puts ""
        puts " Game Over -- #{@cpu_name} WINS!!!\n".blue
        game_over = true
        @cpu_score += 1
        ask_to_play_again(false)
      end
      # see if user has won
      if pieces_on_board(row, @user) == 3
        put_line
        game_render
        put_line
        puts ""
        puts " Game Over -- #{@user_name} WINS!!!\n".blue
        game_over = true
        @user_score += 1
        ask_to_play_again(true)
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
        game_render
        put_line
        puts ""
        puts " Game Over -- DRAW!\n".blue
        ask_to_play_again(rand() > 0.5)
      end
    end
  end

  def ask_to_play_again(user_goes_first)
    print " Play again? (Yn): "
    STDOUT.flush
    response = gets.chomp.downcase
    case response
    when "y"   then restart_game(user_goes_first)
    when "yes" then restart_game(user_goes_first)
    when "n"   then #do nothing
    when "no"  then #do nothing
    else ask_to_play_again(user_goes_first)
    end
  end
  







