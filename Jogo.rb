load 'Tabuleiro.rb'
require 'colorize'

class Jogo

	attr_accessor :dama1, :dama2, :jogo, :pecas1, :pecas2
	attr_reader :jog1,	:jog2, :preto

	def initialize
		@jogo = Tabuleiro.new()
		@jog1 = "●".red
		@jog2 = "●".blue
		@dama_vermelha = "♛".red 
		@dama_azul = "♛".blue
		@campo_vazio = "■".black
		@pecas1 = @pecas2 = 12
	end


	def mover(p_linha,p_coluna,m_linha,m_coluna)
		peca = @jogo.tabuleiro[p_linha][p_coluna]
		if (peca != @campo_vazio)
			insere_peca(m_linha,m_coluna,peca)
			insere_peca(p_linha,p_coluna,@campo_vazio)
		end
	end

	def efetua_jogada(p_linha,p_coluna,m_linha,m_coluna,time)
		valido = false

		if valida_peca(p_linha,p_coluna,m_linha,m_coluna,time) 
			valido = valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
		end
		transforma_em_dama(m_linha, m_coluna, time)
		return valido
	end

	def valida_peca(p_linha,p_coluna,m_linha,m_coluna,time)
		peca_atual = @jogo.tabuleiro[p_linha][p_coluna]
		if time == 1
			if peca_atual == @jog1 || peca_atual == @dama_vermelha
				return true
			else 
				erro(1) 
				return false
			end
		else
			if peca_atual == @jog2 || peca_atual == @dama_azul
				return true
			else 
				erro(1) 
				return false
			end
		end
	end

	def valida_movimento(p_linha, p_coluna, m_linha, m_coluna,time)
		posicao_origem = @jogo.tabuleiro[p_linha][p_coluna]
		posicao_destino = @jogo.tabuleiro[m_linha][m_coluna]
		if time ==1
			distancia = p_linha-m_linha
			if posicao_destino == @campo_vazio && m_linha >= 0 && m_linha <= @jogo.tabuleiro.length-1
				if distancia == 1 && posicao_origem == @jog1  
					mover(p_linha, p_coluna, m_linha, m_coluna)
					return true
				elsif posicao_origem == @dama_vermelha 
					mover(p_linha, p_coluna, m_linha, m_coluna)
				end
			else
			 	if posicao_destino == @jog2 || posicao_destino == @dama_azul
					if posicao_origem == @dama_vermelha
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
			if posicao_destino == @campo_vazio && m_linha >= 0 && m_linha <= @jogo.tabuleiro.length-1
				if distancia == 1 && posicao_origem == @jog2  
					mover(p_linha, p_coluna, m_linha, m_coluna)
					return true
				elsif posicao_origem == @dama_azul 
					mover(p_linha, p_coluna, m_linha, m_coluna)
				end
			else
			 	if posicao_destino == @jog1 || posicao_destino == @dama_vermelha
					if posicao_origem == @dama_azul
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
		@jogo.tabuleiro[m_linha][m_coluna] = @campo_vazio      
 		@jogo.tabuleiro[p_linha][p_coluna] = @campo_vazio      
 	end

 	def insere_peca(m_linha,m_coluna,char)
 		@jogo.tabuleiro[m_linha][m_coluna] = char   	
 	end

 	def dama_comer(p_linha, p_coluna, m_linha, m_coluna, time)
 		diagonal_esquerda_cima = @jogo.tabuleiro[m_linha-1][m_coluna-1]
 		diagonal_esquerda_baixo = @jogo.tabuleiro[m_linha+1][m_coluna-1]
 		diagonal_direita_cima = @jogo.tabuleiro[m_linha-1][m_coluna+1]
 		diagonal_direita_baixo = @jogo.tabuleiro[m_linha+1][m_coluna+1]

 		sentido_horizontal = define_sentido(p_coluna,m_coluna,time)
 		sentido_vertical =  dama_sentido_vertical(p_linha, m_linha)
 		comeu = true
 		if time == 1
 			if sentido_horizontal == "esquerda" 
 				if sentido_vertical == "cima" && diagonal_esquerda_cima == @campo_vazio
 					insere_peca(m_linha-1,m_coluna-1,@dama_vermelha)
 				elsif sentido_vertical == "baixo" && diagonal_esquerda_baixo == @campo_vazio
 					insere_peca(m_linha+1,m_coluna-1,@dama_vermelha)
 				else
 					comeu = false
 				end
 			elsif sentido_horizontal == "direita" 
 				if sentido_vertical == "cima" && diagonal_direita_cima == @campo_vazio
 					insere_peca(m_linha-1,m_coluna+1,@dama_vermelha)
 				elsif sentido_vertical == "baixo" && diagonal_direita_baixo == @campo_vazio
 					insere_peca(m_linha+1,m_coluna+1,@dama_vermelha)
 				else 
 					comeu = false
 				end
 			end
 		else
 		 	if sentido_horizontal == "esquerda" 
 				if sentido_vertical == "cima" && diagonal_direita_baixo == @campo_vazio
 					insere_peca(m_linha+1,m_coluna+1,@dama_azul)
 				elsif sentido_vertical == "baixo" && diagonal_direita_cima == @campo_vazio
 					insere_peca(m_linha-1,m_coluna+1,@dama_azul)
 				else
 					comeu = false
 				end
 			elsif sentido_horizontal == "direita" 
 				if sentido_vertical == "cima" && diagonal_esquerda_baixo == @campo_vazio
 					insere_peca(m_linha+1,m_coluna-1,@dama_azul)
 				elsif sentido_vertical == "baixo" && diagonal_esquerda_cima == @campo_vazio
 					insere_peca(m_linha-1,m_coluna-1,@dama_azul)
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

 	def comer(p_linha, p_coluna, m_linha, m_coluna, time) 
 		diagonal_esquerda_cima = @jogo.tabuleiro[m_linha-1][m_coluna-1]
 		diagonal_esquerda_baixo = @jogo.tabuleiro[m_linha+1][m_coluna-1]
 		diagonal_direita_cima = @jogo.tabuleiro[m_linha-1][m_coluna+1]
 		diagonal_direita_baixo = @jogo.tabuleiro[m_linha+1][m_coluna+1]



 		sentido = define_sentido(p_coluna,m_coluna,time)
 		comeu = true

 		if time == 1
			if sentido == "esquerda" && diagonal_esquerda_cima == @campo_vazio	
 				insere_peca(m_linha-1,m_coluna-1,@jog1)
 				

 			elsif sentido == "direita" && diagonal_direita_cima == @campo_vazio 	
 				insere_peca(m_linha-1,m_coluna+1,@jog1)
 				
 			else
 				comeu = false
 			end 			
 		else
 			if sentido == "esquerda" && diagonal_direita_baixo == @campo_vazio 	
 				insere_peca(m_linha+1,m_coluna+1,@jog2)
 				

 			elsif sentido == "direita" && diagonal_esquerda_baixo == @campo_vazio 
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
 				@jogo.tabuleiro[linha][coluna] = @dama_vermelha
 			end
 		else
 			if linha == @jogo.tabuleiro.length-1
 				@jogo.tabuleiro[linha][coluna] = @dama_azul
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
