load 'Tabuleiro.rb'
require 'colorize'

class Jogo

	attr_accessor :queen1
	attr_accessor :queen2
	attr_accessor :jogo
	attr_reader :jog1
	attr_reader :jog2
	attr_reader :preto

	def initialize()
		@jogo = Tabuleiro.new()
		@jog1 = "●".red
		@jog2 = "●".blue
		@preto = "■".black
	end

	def mover_jog1(px,py,mx,my)
		if (@jogo.tabuleiro[px][py] != @preto)
			@jogo.tabuleiro[mx][my] = @jog1
			@jogo.tabuleiro[px][py] = @preto
		end	
	end

	def mover_jog2(px,py,mx,my)
		if (@jogo.tabuleiro[px][py] != @preto)
			@jogo.tabuleiro[mx][my] = @jog2
			@jogo.tabuleiro[px][py] = @preto
		end	
	end

	def mover_time(px,py,mx,my,time)
		if time == 1
			#verificar se peca eh do time
			#verificar se movimento eh valido (se a diagonal ta certa...)
			if valida_movimento(px,py,mx,my,time) 
				mover_um(px,py,mx,my)  
			else 
				erro(2)
			end
		else
			#verificar se peca eh do time
			#verificar se movimento eh valido
			if valida_movimento(px,py,mx,my,time) 
				mover_dois(px,py,mx,my)  
			else 
				erro(2)
			end
		end
	end

	def valida_peca(px,py,mx,my,time)
		if time == 1
			if @jogo.tabuleiro[px][py] == @jog1
				valida_movimento(px, py, mx, my,time)
			else 
				erro(1) 
			end
		else
			if @jogo.tabuleiro[px][py] == @jog2
				valida_movimento(px, py, mx, my,time)
			else 
				erro(1) 
			end
		end
	end

	def valida_movimento(px, py, mx, my,time)
		if time ==1
			if (@jogo.tabuleiro[mx][my] == @preto) && (mx > 0) && (mx < @jogo.tabuleiro.length-1)
				mover_jog1(px, py, mx, my)
			else 
				if @jogo.tabuleiro[mx][my] == @jog2
					comer(px, py, mx, my, time)
				else
					erro(2)
				end
			end
		else
			if (@jogo.tabuleiro[mx][my] == @preto) && (mx > 0) && (mx < @jogo.tabuleiro.length-1)
				mover_jog2(px, py, mx, my)
			else  
				if @jogo.tabuleiro[mx][my] == @jog1
					comer(px, py, mx, my, time)
				else
					erro(2)
				end
			end
		end	
 	end

 	def comer(px, py, mx, my, time) # p = posição atual / m = onde inimigo esta
 		sentido = define_sentido(px,mx,time)

 		if time == 1
 			if sentido == "esquerda" && @jogo.tabuleiro[mx+1][my-1] == @preto 	#comer para a esquerda
 				@jogo.tabuleiro[mx+1][my-1] = @jog1   ##jogada efetuada
 				@jogo.tabuleiro[mx][my] = "■".black     ##jogador adversario foi atacado
 				@jogo.tabuleiro[px][py] = "■".black      ##limpo ultima posicao do jogador que atacou
 			else
 				sentido == "direita" && @jogo.tabuleiro[mx-1][my+1] == @preto 	#comer para a direita
 				@jogo.tabuleiro[mx-1][my+1] = @jog1
 				@jogo.tabuleiro[mx][my] = "■".black
 				@jogo.tabuleiro[px][py] = "■".black
 			end
 		else
 			if sentido == "esquerda" && @jogo.tabuleiro[mx-1][my+1] == @preto 	#comer para a esquerda
 				@jogo.tabuleiro[mx-1][my+1] = @jog1   ##jogada efetuada
 				@jogo.tabuleiro[mx][my] = "■".black
 				@jogo.tabuleiro[px][py] = "■".black
 			else
 				sentido == "direita" && @jogo.tabuleiro[mx+1][my-1] == @preto 	#comer para a direita
 				@jogo.tabuleiro[mx+1][my-1] = @jog1
 				@jogo.tabuleiro[mx][my] = "■".black
 				@jogo.tabuleiro[px][py] = "■".black
 			end
 		end
 	end

 	def define_sentido(px,mx,time)
 		if time == 1
 		 	if px < mx 
 		 		return "direita"
 			else 
 				return "esquerda"
 			end
 		else
 			if px < mx 
 				return "esquerda"
 			else 
 				return "direita"
 			end
 		end
 	end

 	def erro(op)
 		case op
 		when 1
 			puts "Não há peça na posição informada"
 		when 2
 			puts "Não é possível mover para a posição informada"
 		end
 	end
end
