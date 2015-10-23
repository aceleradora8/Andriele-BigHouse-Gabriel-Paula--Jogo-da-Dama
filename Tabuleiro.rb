require 'colorize'

class Tabuleiro

	attr_accessor:tabuleiro

	def initialize
		@tabuleiro = gera_campo(8,8)
		cria_time
		#mostra_campo
	end
	
	def gera_campo(x, y)
		linha = 1
		coluna = 1
		tabuleiro = []
		x.times { tabuleiro.push([]) }
		tabuleiro.each do |array|
			y.times do 
				if (linha + coluna) % 2 != 0
					array.push("■".black) 
				else
					array.push("■") 
				end
				coluna += 1
			end
			linha += 1
		end

		return tabuleiro
	end

	def mostra_campo()
			
			contador = 0
			@tabuleiro.each do |x|
				x.each do |y|
					contador +=1
					print y << " "
					if contador == x.length
						puts
						contador = 0
					end
				end
			end

	end

	def cria_time
	 		for linha in 0..7 do
	 			for coluna in 0..2 do
	 				if (linha+coluna) % 2 != 0 
	 					@tabuleiro[coluna][linha] = "●".blue
	 				end
	 			end
	 		end
	 		for linha in 0..7 do
	 			for coluna in 5..7 
	 				if (linha+coluna) % 2 != 0 
	 					@tabuleiro[coluna][linha] = "●".red
	 				end
	 			end
	 		end
	end
end


