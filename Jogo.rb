load 'Tabuleiro.rb'
require 'colorize'

class Jogo

	attr_accessor :queen1, :queen2, :jogo, :pecas1, :pecas2
	attr_reader :jog1,	:jog2, :preto

	def initialize
		@jogo = Tabuleiro.new()
		@jog1 = "●".red
		@jog2 = "●".blue
		@preto = "■".black
		@pecas1 = @pecas2 = 12
	end

	def mover_jog1(p_linha,p_coluna,m_linha,m_coluna)
		if (@jogo.tabuleiro[p_linha][p_coluna] != @preto)
			@jogo.tabuleiro[m_linha][m_coluna] = @jog1
			@jogo.tabuleiro[p_linha][p_coluna] = @preto
		end	
	end

	def mover_jog2(p_linha,p_coluna,m_linha,m_coluna)
		if (@jogo.tabuleiro[p_linha][p_coluna] != @preto)
			@jogo.tabuleiro[m_linha][m_coluna] = @jog2
			@jogo.tabuleiro[p_linha][p_coluna] = @preto
		end	
	end

	def mover_peca(p_linha,p_coluna,m_linha,m_coluna,time)
		if time == 1
			#verificar se peca eh do time
			#verificar se movimento eh valido (se a diagonal ta certa...)
			if valida_peca(p_linha,p_coluna,m_linha,m_coluna,time)  #se true, valida e movimenta
				valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
			end
		else
			#verificar se peca eh do time
			#verificar se movimento eh valido
			if valida_peca(p_linha,p_coluna,m_linha,m_coluna,time) 
				valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
			end
		end
	end

	def valida_peca(p_linha,p_coluna,m_linha,m_coluna,time)
		if time == 1
			if @jogo.tabuleiro[p_linha][p_coluna] == @jog1
				return true
			else 
				erro(1) 
				return false
			end
		else
			if @jogo.tabuleiro[p_linha][p_coluna] == @jog2
				return true
			else 
				erro(1) 
				return false
			end
		end
	end

	def valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
		if time ==1
			if (@jogo.tabuleiro[m_linha][m_coluna] == @preto) && (m_linha > 0) && (m_linha < @jogo.tabuleiro.length-1)
				mover_jog1(p_linha, p_coluna, m_linha, m_coluna)
			else 
				if @jogo.tabuleiro[m_linha][m_coluna] == @jog2
					comer(p_linha, p_coluna, m_linha, m_coluna, time)
				else
					erro(2)
				end
			end
		else
			if (@jogo.tabuleiro[m_linha][m_coluna] == @preto) && (m_linha > 0) && (m_linha < @jogo.tabuleiro.length-1)
				mover_jog2(p_linha, p_coluna, m_linha, m_coluna)
			else  
				if @jogo.tabuleiro[m_linha][m_coluna] == @jog1
					comer(p_linha, p_coluna, m_linha, m_coluna, time)
				else
					erro(2)
				end
			end
		end	
 	end

 	def comer(p_linha, p_coluna, m_linha, m_coluna, time) # p = posição atual / m = onde inimigo esta
 		sentido = define_sentido(p_coluna,m_coluna,time)

 		if time == 1
 			decrementa_pecas(time)
 			if sentido == "esquerda" && @jogo.tabuleiro[m_linha-1][m_coluna-1] == @preto 	#comer para a esquerda
 				@jogo.tabuleiro[m_linha-1][m_coluna-1] = @jog1   ##jogada efetuada
 				@jogo.tabuleiro[m_linha][m_coluna] = "■".black     ##jogador adversario foi atacado
 				@jogo.tabuleiro[p_linha][p_coluna] = "■".black      ##limpo ultima posicao do jogador que atacou
 			else
 				sentido == "direita" && @jogo.tabuleiro[m_linha-1][m_coluna+1] == @preto 	#comer para a direita
 				@jogo.tabuleiro[m_linha-1][m_coluna+1] = @jog1
 				@jogo.tabuleiro[m_linha][m_coluna] = "■".black
 				@jogo.tabuleiro[p_linha][p_coluna] = "■".black
 			end
 		else
 			decrementa_pecas(time)
 			if sentido == "esquerda" && @jogo.tabuleiro[m_linha+1][m_coluna+1] == @preto 	#comer para a esquerda
 				@jogo.tabuleiro[m_linha+1][m_coluna+1] = @jog2   ##jogada efetuada
 				@jogo.tabuleiro[m_linha][m_coluna] = "■".black
 				@jogo.tabuleiro[p_linha][p_coluna] = "■".black
 			else
 				sentido == "direita" && @jogo.tabuleiro[m_linha+1][m_coluna-1] == @preto 	#comer para a direita
 				@jogo.tabuleiro[m_linha+1][m_coluna-1] = @jog2
 				@jogo.tabuleiro[m_linha][m_coluna] = "■".black
 				@jogo.tabuleiro[p_linha][p_coluna] = "■".black
 			end
 		end
 	end
 	
 	def define_sentido(p_coluna,m_coluna,time)
 		if time == 1
 		 	if p_coluna < m_coluna
 		 		return "direita"
 			else 
 				return "esquerda"
 			end
 		else
 			if p_coluna < m_coluna 
 				return "esquerda"
 			else 
 				return "direita"
 			end
 		end
 	end

 	def decrementa_pecas(time)
 		if time == 1
 			@pecas2 -= 1
 		else
 			@pecas1 -= 1
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
