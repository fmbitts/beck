# Fernando M de Bittencourt 
# ---- August 20, 2009 ---
 
# Definições de variavéis
 
 
require 'narray'
 
class Calcula_modelo 
 
	def initialize
#			@ferro = {'modulo_criterio_estabilidade' => 4, 'difusividade_termica' => 5.87e-6, 'condutividade_termica' => 30, 'calor_especifico' => 700, 'densidade' => 7300}			
			@aluminio = {'condutividade_termica_solido' => 213.0,'condutividade_termica_liquido' => 91.0, 'calor_especifico_solido' => 1181.0,'calor_especifico_liquido' => 1086.0, 'densidade_solido' => 2550.0,'densidade_liquido' => 2368.0}
#			puts "tempo de simulação em segundos"
			@t_simulacao = 2 #gets.to_i
#			puts "Insira a temperatura ambiente"
			t_ambiente =  30 #gets.to_i
#			puts "Insira a temperatura do molde"
			t_molde =   30 #gets.to_i
#			puts "insira a temperatura do metal"
			t_metal = 700 #gets.to_i
 #			puts "insira a largura do molde"
			@l_molde = 0.05 #gets.to_f
	#		puts "insira a largura do metal"
			@l_metal = 0.05 #gets.to_f
	#		puts "inisira o numero de nós"
			@n_nos_molde = 5
			@n_nos_metal = 5
			@n_nos =  @n_nos_molde + @n_nos_metal
			puts "N nos:  " + @n_nos.to_s
	# dividir nos por metal e molde(metade)
			@hi = 0.001
			@delta_z = 0.001
			@delta_y = 0.001
			@delta_x = 0.001
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
 
	def calcula_difusividade(estado)
		if estado == 'l'
			difusividade = @aluminio['condutividade_termica_liquido'] / (@aluminio['calor_especifico_liquido'] * @aluminio['densidade_liquido'])
		elsif estado == 's'
			difusividade = @aluminio['condutividade_termica_solido'] / (@aluminio['calor_especifico_solido'] * @aluminio['densidade_solido'])
		end	
		puts "Difusividade:   "  + difusividade.to_s
		return difusividade
	end
	
	def calcula_area(d_z,d_y)
		@area = d_z * d_y
	end
		
	def calcula_delta_tempo
#		calcula_delta_x(@l_molde,@l_metal,@n_nos)
		alfa = calcula_difusividade('s')
		delta_tempo = (@delta_x * @delta_x) / (2 * alfa)
		@delta_tempo = delta_tempo * 0.01
		puts "delta tempo:  " +  @delta_tempo.to_s
		
	return 	

	end
	
#	def calcula_delta_x(l_molde,l_metal,n_nos)
#		@delta_x = (l_metal + l_molde) / (n_nos)
#		puts "Delta x: " + @delta_x.to_s
#	end

	def calcula_cap_termica_no(estado)
		calcula_area(@delta_z,@delta_y)
		if estado == 'l'
			cap = @aluminio['calor_especifico_liquido'] * @aluminio['densidade_liquido'] * @delta_x * @area
		elsif estado == 's'
			cap = @aluminio['calor_especifico_solido'] * @aluminio['densidade_solido'] * @delta_x * @area
		end
		return cap
	end

	def calcula_R_anterior(estado)
		if estado == 'l'
			r_ant = (@delta_x) / (2 * @aluminio['condutividade_termica_liquido'] * @area)
		elsif estado == 's'
			r_ant = (@delta_x) / (2 * @aluminio['condutividade_termica_solido'] * @area)
		end
		return r_ant
	end
	
	def calcula_R_atual(estado)
		if estado == 'l'
			r_atual = (@delta_x) / (2 * @aluminio['condutividade_termica_liquido'] * @area)
		elsif estado == 's'
			r_atual = (@delta_x) / (2 * @aluminio['condutividade_termica_solido'] * @area)
		end
		return r_atual
	end
	
	def calcula_R_proximo(estado)
		if estado == 'l'
			r_pro = (@delta_x) / (2 * @aluminio['condutividade_termica_liquido'] * @area)
		elsif estado == 's'
			r_pro = (@delta_x) / (2 * @aluminio['condutividade_termica_solido'] * @area)
		end
		return r_pro
	end
	
	def calcula_R_hi
		r_hi = 1 / (@hi * @area)
	end
	

	def calcula_tal_carga(estado)
		if estado == 'l'
			capacitancia = calcula_cap_termica_no('l')
			r_ant = calcula_R_anterior('l')
			r_proximo = calcula_R_proximo('l')
			r_atual = calcula_R_atual('l')
		elsif estado == 's'	
			capacitancia = calcula_cap_termica_no('s')
			r_ant = calcula_R_anterior('s')
			r_proximo = calcula_R_proximo('s')
			r_atual = calcula_R_atual('s')
		end
		tal_carga = capacitancia * (r_ant + (2 * r_atual) + r_proximo)
		return tal_carga
	end

		def calcula_tal_descarga(estado)
			if estado == 'l'
				capacidade = calcula_cap_termica_no('l')
				r_ant = calcula_R_anterior('l')
				r_proximo = calcula_R_proximo('l')
				r_atual = calcula_R_atual('l')
			elsif estado == 's'	
				capacidade = calcula_cap_termica_no('s')
				r_ant = calcula_R_anterior('s')
				r_proximo = calcula_R_proximo('s')
				r_atual = calcula_R_atual('s')
			end
			tal_descarga = capacidade * (r_ant + (2 * r_atual) + r_proximo)
			return tal_descarga
		end
		
			
		def calcula_tal_resultante(estado)
			if estado == 'l'
				t_carga = calcula_tal_carga('l')
				t_descarga  = calcula_tal_descarga('l')
			elsif estado == 's'
				t_carga = calcula_tal_carga('l')
				t_descarga  = calcula_tal_descarga('l')
			end		
			tal_resul = (t_carga + t_descarga) / (t_carga * t_descarga)
			return tal_resul
		end
			
	
	def calcula_temp(ciclo,no,pos,estado)
		if pos == -1
			temp = (@vet_temp[ciclo][no-1] * @delta_tempo) / (calcula_tal_descarga(estado))
		elsif pos == 0
			temp =  (1 - (@delta_tempo / calcula_tal_resultante(estado))) * @vet_temp[ciclo][no]
		elsif pos == 1
			temp = ((@vet_temp[ciclo][no+1] * (@delta_tempo)) / (calcula_tal_carga(estado))) 
		end
		return temp
	end
		

	
	def temp_final
		i = 0
		n = 0
		t = @t_simulacao
		@vet_temp[n+1][i]=@vet_temp[n][i]
		for n in 0..(t - 1)
			#puts n
			for i in 1..(@n_nos)
				if (i< (@n_nos_molde - 1 ) || i > (@n_nos_molde)) && i < @n_nos #calculo da temperatua para posição 2 até a interface e depois da interface ate o penultimo no
					if i <= @n_nos_molde #calculo da temperatura para estado solido MOLDE
						@vet_temp[n+1][i] = calcula_temp(n,i,(-1),'s') + calcula_temp(n,i,0,'s') + calcula_temp(n,i,1,'s')
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura :  "  + @vet_temp[n+1][i].to_s						
					elsif i > @n_nos_molde # calculo da temperatura para estado liquido METAL
						@vet_temp[n+1][i] = calcula_temp(n,i,-1,'l') + calcula_temp(n,i,0,'l') + calcula_temp(n,i,1,'l')
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura :  " + @vet_temp[n+1][i].to_s
					end
				elsif i == (@n_nos_molde - 1) # calculo da temperatura interface
						@vet_temp[n+1][i] = calcula_temp(n,i,-1,'s') + calcula_temp(n,i,0,'s') + calcula_temp(n,i,1,'s')
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura ultimo no MOLDE :  " +  @vet_temp[n+1][i].to_s
				elsif i == @n_nos_molde # calculo da temperatura interface
						@vet_temp[n+1][i] = calcula_temp(n,i,-1,'s') + calcula_temp(n,i,0,'s') + calcula_temp(n,i,1,'s')
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura primeiro no METAL :  " + @vet_temp[n+1][i].to_s
				elsif i == @n_nos # calculo temperatura loptall
						@vet_temp[n+1][i] = 2 * calcula_temp(n,i,-1,'l') + calcula_temp(n,i,0,'l') 
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura ultimo no METAL :  "  + @vet_temp[n+1][i].to_s
				end
			end
		end
	end

end						

 
 

 
 
 
modelo = Calcula_modelo.new
modelo.mostra
modelo.temp_final