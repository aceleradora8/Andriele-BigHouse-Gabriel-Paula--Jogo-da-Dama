load 'Jogo.rb'
=begin
	falta implementar:
		- controle para poder comer mais de uma peca (quando possivel)
		- a dama ta louca, caminhando errado
		- não da pra comer a dama
		- obrigar a comer
		- mensagens de erro
		- placar
=end
class Main

	attr_accessor :jogo, :jogador_atual, :troca

	def initialize
		@main = Jogo.new
		@jogador_atual = 1
		@troca = true
		tela_inicial
		tela_de_jogo
	end

	def tela_inicial
		system "clear"
		puts '--- Jogo de Damas ---'
		puts
		puts "pressione ENTER para continuar"
		gets.chomp
		instrucoes_de_jogo
		puts
	end

	def tela_de_jogo

		jogando = true
		while jogando
			jogada = valida_dados_inseridos
			@troca = @main.efetua_jogada(jogada[0].to_i,jogada[1].to_i,jogada[2].to_i, jogada[3].to_i, @jogador_atual)
			jogando = verifica_estado_do_jogo #se deu certo, trocar turno e dai eh outro jogador
			system "clear"
			desenha_tabuleiro
			puts
			muda_turno()
		end

		fim_de_jogo
	end

	def valida_dados_inseridos

		puts "jogador #{@jogador_atual}"		
		entrada = []
		while entrada.size != 4	
			entrada = gets.chomp.split("")
			if entrada.size != 4
				erro(1)
			end
		end
			return entrada
	end

	def erro(op) #erros relativos aos parametros passados pelo terminal
		case op
		when 1
			puts "entrada invalida!"
		end
	end

	def muda_turno()
		if @troca
			if @jogador_atual == 1 
				@jogador_atual = 2
			else 
				@jogador_atual = 1
			end
		end
	end

	def desenha_tabuleiro
		@main.jogo.mostra_campo
	end

	def instrucoes_de_jogo
		system "clear"
		puts "--- instrucoes ---"
		puts "insira a posicao da peca (linha/coluna) e a posicao destino (linha/coluna)"
		puts "exemplo de jogada: 5241"
		puts
		desenha_tabuleiro
	end

	def verifica_estado_do_jogo
		if @main.pecas1 == 0 || @main.pecas2 == 0 #se acabou as pecas de algum jogador, fim de jogo
			return false
		else
			return true
		end
	end

	def fim_de_jogo
		if @main.pecas1 == 0
			vencedor = 2
		else
			vencedor = 1
		end
		puts "fim de jogo!!!"
		puts "o vencedor foi o jogador #{vencedor}."
		puts
	end

end

main = Main.new()