# Fernando M de Bittencourt 
# ---- August 20, 2009 ---
 
# Definições de variavéis
 
 
require 'narray'
 
class Calcula_modelo 
 
	def initialize
			@ferro = {'modulo_criterio_estabilidade' => 4, 'difusividade_termica' => 5.87e-6, 'condutividade_termica' => 30, 'calor_especifico' => 700, 'densidade' => 7300}			
#			puts "tempo de simulação em segundos"
			@t_simulacao = 2#gets.to_i
#			puts "Insira a temperatura ambiente"
			t_ambiente =  30 #gets.to_i
#			puts "Insira a temperatura do molde"
			t_molde =   30 #gets.to_i
#			puts "insira a temperatura do metal"
			t_metal = 1700 #gets.to_i
 #			puts "insira a largura do molde"
			@l_molde = 0.01 #gets.to_f
	#		puts "insira a largura do metal"
			@l_metal = 0.1 #gets.to_f
	#		puts "inisira o numero de nós"
			@n_nos = 100 #gets.to_f
	# dividir nos por metal e molde(metade)
			@delta_z = 0.01
			@delta_y = 0.01
			inicia_vetor(t_ambiente,t_molde,t_metal)
			calcula_delta_tempo
			
	end
 
 
 
	def cria_matriz(width,height)
		a = Array.new(width)
		a.map! { Array.new(height) }
	return a
	end
  
	def inicia_vetor(ta,tm,tM)
		n = 0
		i = 0
		j = 0
		k = 0
		l = 0
		@vet_temp = cria_matriz(@t_simulacao,@n_nos)		
		@vet_temp[0][0] = ta.to_i

		# inicializa primeiro vetor do comeco ate a metade com a temperatura do molde, e considerado que metade dos nos estao na area do molde
		for i in 1..((@n_nos/2) - 1)
					@vet_temp[0][i] = tm.to_i
		end
		# inicializa primeiro vetor da metade ao fim com a temperatura do metal, e considerado que metade dos nos estao na area do metal
		for k in (@n_nos/2)..@n_nos			
			@vet_temp[0][k] = tM.to_i
		end
		# inicializa primeiro posição do vetor da matriz com a temperatura ambiente	
		for j in 1..@t_simulacao - 1
			@vet_temp[j][0] = ta
		end				
	end
 
	def mostra
		@vet_temp[0].each {|i| puts i}
	end
 

	
	def calcula_area(d_z,d_y)
		@area = d_z * d_y
	end
		
	def calcula_delta_tempo
		calcula_delta_x(@l_molde,@l_metal,@n_nos)		
		delta_x_quadrado = @delta_x * @delta_x
		@delta_tempo = delta_x_quadrado /(@ferro['modulo_criterio_estabilidade'] * @ferro['difusividade_termica'])
		puts "delta tempo:  " + @delta_tempo.to_s

	end
	
	def calcula_delta_x(l_molde,l_metal,n_nos)
		@delta_x = (l_metal + l_molde) / (n_nos)
		puts "Delta x: " + @delta_x.to_s
	end

	def calcula_cap_termica_no(c_e,de)
		calcula_area(@delta_z,@delta_y)
		cap = c_e * de * @delta_x * @area
		return cap
	end

	def calcula_R_anterior
		r_ant = @delta_x / (2 * @ferro['condutividade_termica'] * @area)
#		puts "R anterior:  "  + r_ant.to_s
		return r_ant
	end
	
	def calcula_R_atual
		r_atual = @delta_x / (2 * @ferro['condutividade_termica'] * @area)		
#		puts "R atual:  "  + r_atual.to_s
		return r_atual
	end
	
	def calcula_R_proximo
		r_pro = @delta_x / (2 * @ferro['condutividade_termica'] * @area)
#		puts "R proximo:  "  + r_pro.to_s
		return r_pro
	end
	

	
	def calcula_tal_anterior
		capacidade = calcula_cap_termica_no(@ferro['calor_especifico'],@ferro['densidade'])		
		r_ant = calcula_R_anterior
		r_atual = calcula_R_atual
		tal_ant = capacidade * r_ant * r_atual
#		puts capacidade.to_s + ":    Capacidade"
#		puts @area.to_s + ":   Area"
#		puts r_ant.to_s + ":   R ant" 
#		puts tal_ant.to_s  + ":   Tal alnt"
		return tal_ant
	end

		def calcula_tal_atual
			capacidade = calcula_cap_termica_no(@ferro['calor_especifico'],@ferro['densidade'])
			r_atual = calcula_R_atual
			r_proximo = calcula_R_proximo
			tal_atual = capacidade * r_atual * r_proximo
			return tal_atual
		end
		
			
		def calcula_tal_proximo
			t_ant = calcula_tal_atual
			t_atual  = calcula_tal_atual
			tal_pro = (t_ant + t_atual) / t_ant * t_atual
			return tal_pro
		end
			
	
	
	def calc_temp
		i = 0
		n = 0
		t = @t_simulacao
		@vet_temp[n+1][i]=@vet_temp[n][i]
		for n in 0..(t - 1)
			puts n
			for i in 1..(@n_nos)
				if i< @n_nos
					@vet_temp[n+1][i] = (@vet_temp[n][i-1] * @delta_tempo*0.75/calcula_tal_anterior) + (@vet_temp[n][i]*(1 - @delta_tempo/calcula_tal_atual)) + (@vet_temp[n][i+1]*@delta_tempo/calcula_tal_proximo)
					puts i.to_s + "   " 	+ @vet_temp[n+1][i].to_s 
				elsif i == @n_nos
					@vet_temp[n+1][i] = (@vet_temp[n][i-1] * @delta_tempo*0.75/calcula_tal_anterior) + 2*(@vet_temp[n][i]*(1 - @delta_tempo/calcula_tal_atual)) 
					puts i.to_s + "   " 	+ @vet_temp[n+1][i].to_s
				end
			end
		end
	end
	
	def calc_temp_old
		# vet_temp[vetor][no]

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
					@vet_temp[n+1][i] = ((@vet_temp[n][i-1] - (2 * @vet_temp[n][i]) + @vet_temp[n][i+1])*(@delta_tempo*0.75))/(@ferro['calor_especifico']*@ferro['densidade']*@delta_x)*@ferro['condutividade_termica'] + @vet_temp[n][i]
					puts  (i).to_s + " " + @vet_temp[n+1][i].to_s
				elsif i == @n_nos 
					@vet_temp[n+1][i] = ((@vet_temp[n][i-1] - (2 * @vet_temp[n][i]) + @vet_temp[n][i])*@delta_tempo*0.75)/(@ferro['calor_especifico']*@ferro['densidade']*@delta_x)*@ferro['condutividade_termica'] + @vet_temp[n][i]
					puts  (i).to_s + " " + @vet_temp[n+1][i].to_s
				end
			end
		end
	end		
 
 
end
 
 
 
 
modelo = Calcula_modelo.new
modelo.calc_temp

