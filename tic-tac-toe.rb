
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
    @user = @cpu == .X. ? 'O' : 'X'

    @cpu_name = "Ruby"
    put_line
    puts " TIC TAC TOE - Ruby Edition! "
    puts "Welcome challenger, what is your name?"
    STDOUT.flush
    @user_name = gets.chomp
    put_bar

    