load 'Jogo.rb'
j = Jogo.new()

=begin
while true
	puts "digitae px py mx my time"
	var = gets.chomp.split('')
	j.valida_peca(var[0].to_i,var[1].to_i,var[2].to_i,var[3].to_i,var[4].to_i)
	j.jogo.mostra_campo
	puts 
end
=end
#peca = [2,1]
#movimento = [0,3]
#j.mover
#j.mover_dois(2,1,3,2)
#j.valida_peca(2,1,3,2,2)
#j.valida_peca(3,2,4,1,2)
#j.valida_peca(5,0,4,1,1)

##### testes ##### informar linha coluna linha coluna time (podendo ser 0 ou 1)
j.valida_peca(2,1,3,0,2)
j.valida_peca(5,0,4,1,1)
j.valida_peca(2,3,3,2,2)
j.valida_peca(4,1,3,2,1)
j.jogo.mostra_campo