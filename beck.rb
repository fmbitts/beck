# Fernando M de Bittencourt 
# ---- August 20, 2009 ---

# Definições de variavéis


require 'narray'

class Calcula_modelo 
	
	def initialize
			@ferro = {'modulo_criterio_estabilidade' => 4, 'difusividade_termica' => 5.87e-6, 'condutividade_termica' => 30, 'calor_espeficico' => 7300, 'densidade' => 700}			
#			puts "tempo de simulação em segundos"
			@t_simulacao = 1500 #gets.to_i
#			puts "Insira a temperatura ambiente"
			t_ambiente =  30 #gets.to_i
#			puts "Insira a temperatura do molde"
			t_molde =   30 #gets.to_i
#			puts "insira a temperatura do metal"
			t_metal = 1700 #gets.to_i
 #			puts "insira a largura do molde"
			@l_molde = 0.01 #gets.to_f
	#		puts "insira a largura do metal"
			@l_metal = 0.01 #gets.to_f
	#		puts "inisira o numero de nós"
			@n_nos = 100 #gets.to_f
	# dividir nos por metal e molde(metade)
			inicia_vetor(t_ambiente,t_molde,t_metal)
	end

		
	
	def cria_matriz(width,height)
		a = Array.new(width)
		a.map! { Array.new(height) }
	return a
	end

	def calcula_delta_tempo
		calcula_delta_x(@l_molde,@l_metal,@n_nos)		
		@delta_x *= @delta_x
		@delta_tempo = @delta_x /(@ferro['modulo_criterio_estabilidade'] * @ferro['difusividade_termica'])
	end
	
	def calcula_delta_x(l_molde,l_metal,n_nos)
		l_molde = l_molde
		l_metal = l_metal
		n_nos = n_nos
		@delta_x = (l_metal + l_molde) / (n_nos)
	end
	
	
	def inicia_vetor(ta,tm,tM)
		n=0
		i=0
		@t_ambiente = ta
		@vet_temp = cria_matriz(@t_simulacao,@n_nos)		
		@vet_temp[0][0] = ta.to_i
		@vet_temp[0][1] = tm.to_i
		@vet_temp[0][2] = tm.to_i
		@vet_temp[0][3] = tm.to_i
		@vet_temp[0][4] = tM.to_i
		@vet_temp[0][5] = tM.to_i
		@vet_temp[0][6] = tM.to_i
		@vet_temp[0][7] = tM.to_i
		@vet_temp[0][8] = tM.to_i
		@vet_temp[0][9] = tM.to_i
		k = 0
		for k in 3..@n_nos
			@vet_temp[0][k] = tM.to_i
			puts k.to_s+ "valor:  " + @vet_temp[0][k].to_s 
		end
		
		
		j = 0
		for j in 1..@t_simulacao - 1
			@vet_temp[j][0] = ta
		end				
	end

	def mostra
		@vet_temp[0].each {|i| puts i}
	end
	
	def calc_temp
		# vet_temp[vetor][no]
		calcula_delta_tempo
		# mostra
		puts "Delta tempo: " + @delta_tempo.to_s 
		puts "Delta x:  "  + @delta_x.to_s
		t = @t_simulacao
		puts "tempo simulação   :" + t.to_s
		i = 0
		n = 0
		@vet_temp[n+1][i]=@vet_temp[n][i]
		q = 	(@delta_tempo/@delta_x)
		for n in 0..(t - 1)
			puts n.to_s
			for i in 1..(@n_nos)
				if i< @n_nos
					@vet_temp[n+1][i] = ((@vet_temp[n][i-1] - (2 * @vet_temp[n][i]) + @vet_temp[n][i+1])*(@delta_tempo*0.75))/(@ferro['calor_espeficico']*@ferro['densidade']*@delta_x)*@ferro['condutividade_termica'] + @vet_temp[n][i]
					puts  (i).to_s + " " + @vet_temp[n+1][i].to_s
				elsif i == @n_nos 
					@vet_temp[n+1][i] = ((@vet_temp[n][i-1] - (2 * @vet_temp[n][i]) + @vet_temp[n][i])*@delta_tempo*0.75)/(@ferro['calor_espeficico']*@ferro['densidade']*@delta_x)*@ferro['condutividade_termica'] + @vet_temp[n][i]
					puts  (i).to_s + " " + @vet_temp[n+1][i].to_s
				end
			end
		end
	end		


end
		
	
	
	
modelo = Calcula_modelo.new
modelo.calc_temp