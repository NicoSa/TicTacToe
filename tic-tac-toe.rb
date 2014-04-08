
# Tic Tac Toe Ruby Project!

# Start out by defining the places on the game board:
@boardplaces = { 
            "a1"=>" ","a2"=>" ","a3"=>" ",
            "b1"=>" ","b2"=>" ","b3"=>" ",
            "c1"=>" ","c2"=>" ","c3"=>" ",
          }

@winningcolumns = [
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
	move = cpu_find_move
	@places[move] = @cpu
	put_line
	puts "#{cpu_name} marks #{move.upcase}"
	check_game(@user)
end	





