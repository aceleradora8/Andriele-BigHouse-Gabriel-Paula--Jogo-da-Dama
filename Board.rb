load 'Piece.rb'

class Board

	x = 0
	#a = Piece.new(1)
	#puts a.team

	board = Array.new(8) { Array.new(8) }

	while x < board.length do
		y = 0
		print "["
		while y < board[x].length do
			print " , " if y > 0
			print y
			y +=1
		end
		puts "]"
		x +=1	
	end
end