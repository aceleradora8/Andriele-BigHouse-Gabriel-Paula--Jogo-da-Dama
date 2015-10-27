load 'Tabuleiro.rb'
require 'colorize'

class Jogo

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


	def mover(p_linha,p_coluna,m_linha,m_coluna)
		peca = @jogo.tabuleiro[p_linha][p_coluna]
		if (peca != @preto)
			insere_peca(m_linha,m_coluna,peca)
			insere_peca(p_linha,p_coluna,@preto)
		end
	end

#mover* -> mover
#mover_peca -> efetua_jogada
#verifica_dama -> transforma_em_dama


	def efetua_jogada(p_linha,p_coluna,m_linha,m_coluna,time)

		valido = false

		if valida_peca(p_linha,p_coluna,m_linha,m_coluna,time) 
			valido = valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
		end
		transforma_em_dama(m_linha, m_coluna, time)
		return valido
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
			distancia = p_linha-m_linha
			if @jogo.tabuleiro[m_linha][m_coluna] == "■".black && m_linha >= 0 && m_linha <= @jogo.tabuleiro.length-1
				if distancia == 1 && @jogo.tabuleiro[p_linha][p_coluna] == @jog1  
					mover(p_linha, p_coluna, m_linha, m_coluna)
					return true
				elsif @jogo.tabuleiro[p_linha][p_coluna] == "♛".red 
					mover(p_linha, p_coluna, m_linha, m_coluna)
				end
			else
			 	if @jogo.tabuleiro[m_linha][m_coluna] == @jog2 || @jogo.tabuleiro[m_linha][m_coluna] == "♛".blue
					if @jogo.tabuleiro[p_linha][p_coluna] == "♛".red
						return dama_comer(p_linha, p_coluna, m_linha, m_coluna, time)
					elsif distancia == 1
						return comer(p_linha, p_coluna, m_linha, m_coluna, time)
					end
				else
					erro(2)
					return false
				end
			end
		else
			distancia = m_linha-p_linha
			if @jogo.tabuleiro[m_linha][m_coluna] == "■".black && m_linha >= 0 && m_linha <= @jogo.tabuleiro.length-1
				if distancia == 1 && @jogo.tabuleiro[p_linha][p_coluna] == @jog2  
					mover(p_linha, p_coluna, m_linha, m_coluna)
					return true
				elsif @jogo.tabuleiro[p_linha][p_coluna] == "♛".blue 
					mover(p_linha, p_coluna, m_linha, m_coluna)
				end
			else
			 	if @jogo.tabuleiro[m_linha][m_coluna] == @jog1 || @jogo.tabuleiro[m_linha][m_coluna] == "♛".red
					if @jogo.tabuleiro[p_linha][p_coluna] == "♛".blue
						return dama_comer(p_linha, p_coluna, m_linha, m_coluna, time)
					elsif distancia == 1
						return comer(p_linha, p_coluna, m_linha, m_coluna, time)
					end
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

 	def dama_comer(p_linha, p_coluna, m_linha, m_coluna, time)
 		sentido_horizontal = define_sentido(p_coluna,m_coluna,time)
 		sentido_vertical =  dama_sentido_vertical(p_linha, m_linha)
 		comeu = true
 		if time == 1
 			if sentido_horizontal == "esquerda" 
 				if sentido_vertical == "cima" && @jogo.tabuleiro[m_linha-1][m_coluna-1] == "■".black
 					insere_peca(m_linha-1,m_coluna-1,"♛".red)
 				elsif sentido_vertical == "baixo" && @jogo.tabuleiro[m_linha+1][m_coluna-1] == "■".black
 					insere_peca(m_linha+1,m_coluna-1,"♛".red)
 				else
 					comeu = false
 				end
 			elsif sentido_horizontal == "direita" 
 				if sentido_vertical == "cima" && @jogo.tabuleiro[m_linha-1][m_coluna+1] == "■".black
 					insere_peca(m_linha-1,m_coluna+1,"♛".red)
 				elsif sentido_vertical == "baixo" && @jogo.tabuleiro[m_linha+1][m_coluna+1] == "■".black
 					insere_peca(m_linha+1,m_coluna+1,"♛".red)
 				else 
 					comeu = false
 				end
 			end
 		else
 		 	if sentido_horizontal == "esquerda" 
 				if sentido_vertical == "cima" && @jogo.tabuleiro[m_linha+1][m_coluna+1] == "■".black
 					insere_peca(m_linha+1,m_coluna+1,"♛".blue)
 				elsif sentido_vertical == "baixo" && @jogo.tabuleiro[m_linha-1][m_coluna+1] == "■".black
 					insere_peca(m_linha-1,m_coluna+1,"♛".blue)
 				else
 					comeu = false
 				end
 			elsif sentido_horizontal == "direita" 
 				if sentido_vertical == "cima" && @jogo.tabuleiro[m_linha+1][m_coluna-1] == "■".black
 					insere_peca(m_linha+1,m_coluna-1,"♛".blue)
 				elsif sentido_vertical == "baixo" && @jogo.tabuleiro[m_linha-1][m_coluna-1] == "■".black
 					insere_peca(m_linha-1,m_coluna-1,"♛".blue)
 				else
 					comeu = false
 				end
 			end
 		end
 		if comeu
 			limpa_campo(p_linha,p_coluna,m_linha,m_coluna)
 		end
 		return comeu
 	end

 	def comer(p_linha, p_coluna, m_linha, m_coluna, time) # p = posição atual / m = onde inimigo esta
 		sentido = define_sentido(p_coluna,m_coluna,time)
 		comeu = true

 		if time == 1
			if sentido == "esquerda" && @jogo.tabuleiro[m_linha-1][m_coluna-1] == "■".black	#comer para a esquerda
 				insere_peca(m_linha-1,m_coluna-1,@jog1)
 				

 			elsif sentido == "direita" && @jogo.tabuleiro[m_linha-1][m_coluna+1] == "■".black 	#comer para a direita
 				insere_peca(m_linha-1,m_coluna+1,@jog1)
 				
 			else
 				comeu = false
 			end 			
 		else
 			if sentido == "esquerda" && @jogo.tabuleiro[m_linha+1][m_coluna+1] == "■".black 	#comer para a esquerda
 				insere_peca(m_linha+1,m_coluna+1,@jog2)
 				

 			elsif sentido == "direita" && @jogo.tabuleiro[m_linha+1][m_coluna-1] == "■".black 	#comer para a direita
 				insere_peca(m_linha+1,m_coluna-1,@jog2)
 							
 			else
 				comeu = false
 			end
 			
 		end
 		if comeu 
 			limpa_campo(p_linha,p_coluna,m_linha,m_coluna)
 			decrementa_pecas(time)
 		end
 		return comeu
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

 	def dama_sentido_vertical(p_linha, m_linha)
 		 if p_linha < m_linha
 		 	return "baixo"
 		else 
 			return "cima"
 		end
 	end

 	def transforma_em_dama(linha,coluna,time)
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
