load 'Tabuleiro.rb'
require 'colorize'

class Jogo

	#♛

	attr_accessor :dama1, :dama2, :jogo, :pecas1, :pecas2
	attr_reader :jog1,	:jog2, :preto

	def initialize
		@jogo = Tabuleiro.new()
		@jog1 = "●".red
		@jog2 = "●".blue

		@preto = "■".black
		@pecas1 = @pecas2 = 12

		#@dama1 = "♛".red
		#@dama2 = "♛".blue
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

	def mover_dama1(p_linha,p_coluna,m_linha,m_coluna)
		if (@jogo.tabuleiro[p_linha][p_coluna] != @preto)
			@jogo.tabuleiro[m_linha][m_coluna] = "♛".red
			@jogo.tabuleiro[p_linha][p_coluna] = @preto
		end	
	end

	def mover_dama2(p_linha,p_coluna,m_linha,m_coluna)
		if (@jogo.tabuleiro[p_linha][p_coluna] != @preto)
			@jogo.tabuleiro[m_linha][m_coluna] = "♛".blue
			@jogo.tabuleiro[p_linha][p_coluna] = @preto
		end	
	end

	def mover_peca(p_linha,p_coluna,m_linha,m_coluna,time)

		aux = false

		if time == 1
			#verificar se peca eh do time
			#verificar se movimento eh valido (se a diagonal ta certa...)
			if valida_peca(p_linha,p_coluna,m_linha,m_coluna,time)  #se true, valida e movimenta
				aux = valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
			end
		else
			#verificar se peca eh do time
			#verificar se movimento eh valido
			if valida_peca(p_linha,p_coluna,m_linha,m_coluna,time) 
				aux = valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
			end
		end
		verifica_dama(m_linha, m_coluna, time)
		return aux
	end

	def valida_peca(p_linha,p_coluna,m_linha,m_coluna,time)
		if time == 1
			if @jogo.tabuleiro[p_linha][p_coluna] == @jog1 || @jogo.tabuleiro[p_linha][p_coluna] == "♛".red
				return true
			else 
				erro(1) 
				return false
			end
		else
			if @jogo.tabuleiro[p_linha][p_coluna] == @jog2 || @jogo.tabuleiro[p_linha][p_coluna] == "♛".blue
				return true
			else 
				erro(1) 
				return false
			end
		end
	end

	def valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
		if time ==1
			diff = p_linha-m_linha
			if (@jogo.tabuleiro[m_linha][m_coluna] == "■".black) && (m_linha >= 0) && (m_linha <= @jogo.tabuleiro.length-1) && (diff == 1) && @jogo.tabuleiro[p_linha][p_coluna] == @jog1  
				mover_jog1(p_linha, p_coluna, m_linha, m_coluna)
				return true
			elsif (@jogo.tabuleiro[m_linha][m_coluna] == "■".black) && (m_linha >= 0) && (m_linha <= @jogo.tabuleiro.length-1) && @jogo.tabuleiro[p_linha][p_coluna] == "♛".red 
				mover_dama1(p_linha, p_coluna, m_linha, m_coluna)
			else 
				if @jogo.tabuleiro[m_linha][m_coluna] == @jog2 && diff == 1
					return comer(p_linha, p_coluna, m_linha, m_coluna, time)
					
				else
					erro(2)
					return false
				end
			end

		else
			diff = m_linha-p_linha
			if (@jogo.tabuleiro[m_linha][m_coluna] == "■".black) && (m_linha >= 0) && (m_linha <= @jogo.tabuleiro.length-1)	&& (diff == 1) && @jogo.tabuleiro[p_linha][p_coluna] == @jog2  
				mover_jog2(p_linha, p_coluna, m_linha, m_coluna)
				return true
			elsif (@jogo.tabuleiro[m_linha][m_coluna] == "■".black) && (m_linha >= 0) && (m_linha <= @jogo.tabuleiro.length-1) && @jogo.tabuleiro[p_linha][p_coluna] == "♛".blue 
				mover_dama2(p_linha, p_coluna, m_linha, m_coluna)
			else  
				if @jogo.tabuleiro[m_linha][m_coluna] == @jog1 && diff == 1
					return comer(p_linha, p_coluna, m_linha, m_coluna, time)
				else
					erro(2)
					return false
				end
			end
		end	
 	end


 	def limpa_campo(p_linha,p_coluna,m_linha,m_coluna)
		@jogo.tabuleiro[m_linha][m_coluna] = "■".black      ##jogador adversario foi atacado
 		@jogo.tabuleiro[p_linha][p_coluna] = "■".black      ##limpo ultima posicao do jogador que atacou
 	end

 	def insere_peca(m_linha,m_coluna,char)
 		@jogo.tabuleiro[m_linha][m_coluna] = char   	##jogada efetuada
 	end


 	def comer(p_linha, p_coluna, m_linha, m_coluna, time) # p = posição atual / m = onde inimigo esta
 		sentido = define_sentido(p_coluna,m_coluna,time)
 		aux = true

 		if time == 1
 			if sentido == "esquerda" && @jogo.tabuleiro[p_linha][p_coluna] == "♛".red && (@jogo.tabuleiro[m_linha-1][m_coluna-1] == "■".black || @jogo.tabuleiro[m_linha+1][m_coluna-1] == "■".black)
 				insere_peca(m_linha-1,m_coluna-1,"♛".red)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna)
 				
 			elsif sentido == "direita" && @jogo.tabuleiro[p_linha][p_coluna] == "♛".red && (@jogo.tabuleiro[m_linha-1][m_coluna+1] == "■".black || @jogo.tabuleiro[m_linha+1][m_coluna+1] == "■".black)
 				insere_peca(m_linha-1,m_coluna+1,"♛".red)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna)

 			elsif sentido == "esquerda" && @jogo.tabuleiro[m_linha][m_coluna] == @jog2 && @jogo.tabuleiro[m_linha-1][m_coluna-1] == "■".black	#comer para a esquerda
 				insere_peca(m_linha-1,m_coluna-1,@jog1)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna)

 			elsif sentido == "direita" && @jogo.tabuleiro[m_linha][m_coluna] == @jog2 && @jogo.tabuleiro[m_linha-1][m_coluna+1] == "■".black 	#comer para a direita
 				insere_peca(m_linha-1,m_coluna+1,@jog1)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna)
 			else
 				aux = false
 			end 			

 		else
 			if sentido == "esquerda" && @jogo.tabuleiro[p_linha][p_coluna] == "♛".blue && (@jogo.tabuleiro[m_linha+1][m_coluna+1] == "■".black || @jogo.tabuleiro[m_linha-1][m_coluna+1] == "■".black)
 				insere_peca(m_linha+1,m_coluna+1,"♛".blue)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna)

			elsif sentido == "direita" && @jogo.tabuleiro[p_linha][p_coluna] == "♛".blue && (@jogo.tabuleiro[m_linha+1][m_coluna-1] == "■".black || @jogo.tabuleiro[m_linha-1][m_coluna-1] == "■".black)
 				insere_peca(m_linha+1,m_coluna-1,"♛".blue)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna)

 			elsif sentido == "esquerda" && @jogo.tabuleiro[m_linha][m_coluna] == @jog1 && @jogo.tabuleiro[m_linha+1][m_coluna+1] == "■".black 	#comer para a esquerda
 				insere_peca(m_linha+1,m_coluna+1,@jog2)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna)

 			elsif sentido == "direita" && @jogo.tabuleiro[m_linha][m_coluna] == @jog1 && @jogo.tabuleiro[m_linha+1][m_coluna-1] == "■".black 	#comer para a direita
 				insere_peca(m_linha+1,m_coluna-1,@jog2)
 				limpa_campo(p_linha,p_coluna,m_linha,m_coluna) 				
 			else
 				aux = false
 			end
 			
 		end
 		if aux 
 			decrementa_pecas(time)
 		end
 		return aux
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

 	##ehrainha(mlinha,time)
 	###m == 0

 	def dama_caminhando_esquerda1(p_coluna,p_linha,m_coluna,m_linha) #time vermelho
 		coluna = p_coluna-1
 		(p_linha-1..m_linha).each do |linha|
 			if @jogo.tabuleiro[linha][coluna] != "■".black #se diferente de preto, nao rola caminhar p/ posicao desejada
 				return false
 			end
 			linha-=1
 		end
 		mover_dama1(p_linha,p_coluna,m_linha,m_coluna)
 		return true 

 	end

 	def dama_caminhando_direita1(p_coluna,p_linha,m_coluna,m_linha) #time vermelho
 		coluna = p_coluna+1
 		(p_linha+1..m_linha).each do |linha|
 			if @jogo.tabuleiro[linha][coluna] != "■".black #se diferente de preto, nao rola caminhar p/ posicao desejada
 				return false
 			end
 			linha+=1
 		end
 		mover_dama1(p_linha,p_coluna,m_linha,m_coluna)
 		return true 

 	end

	def dama_caminhando_esquerda2(p_coluna,p_linha,m_coluna,m_linha) #time azul
 		coluna = p_coluna+1
 		(p_linha+1..m_linha).each do |linha|
 			if @jogo.tabuleiro[linha][coluna] != "■".black #se diferente de preto, nao rola caminhar p/ posicao desejada
 				return false
 			end
 			linha+=1
 		end
 		mover_dama2(p_linha,p_coluna,m_linha,m_coluna)
 		return true 
 	end


	def dama_caminhando_direita2(p_coluna,p_linha,m_coluna,m_linha) #time azul
 		coluna = p_coluna-1
 		(p_linha+1..m_linha).each do |linha|
 			if @jogo.tabuleiro[linha][coluna] != "■".black #se diferente de preto, nao rola caminhar p/ posicao desejada
 				return false
 			end
 			linha-=1
 		end
 		mover_dama2(p_linha,p_coluna,m_linha,m_coluna)
 		return true 
 	end


 	def verifica_dama(linha,coluna,time)
 		if time == 1
 			if linha == 0
 				@jogo.tabuleiro[linha][coluna] = "♛".red
 			end
 		else
 			if linha == @jogo.tabuleiro.length-1
 				@jogo.tabuleiro[linha][coluna] = "♛".blue
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
