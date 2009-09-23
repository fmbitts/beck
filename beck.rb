# Fernando M de Bittencourt 
# ---- August 20, 2009 ---
 
# Definições de variavéis
 
 
require 'narray'
 require 'benchmark' 
include Benchmark


class Calcula_modelo 
 
	def initialize
#			@ferro = {'modulo_criterio_estabilidade' => 4, 'difusividade_termica' => 5.87e-6, 'condutividade_termica' => 30, 'calor_especifico' => 700, 'densidade' => 7300}			
			@aluminio = {'condutividade_termica_solido' => 213.0,'condutividade_termica_liquido' => 91.0, 'calor_especifico_solido' => 1181.0,\
				'calor_especifico_liquido' => 1086.0, 'densidade_solido' => 2550.0,'densidade_liquido' => 2368.0, 'temperatura_solidus' => 548.0, 'temperatura_liquidus' => 645.0, \
				'coeficiente_particao' => 0.17, 'temperatura_fusao' => 660.0}
#			puts "tempo de simulação em segundos"
			@t_simulacao = 6000 #gets.to_i
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
			@n_nos_molde = 20
			@n_nos_metal = 50
			@n_nos =  @n_nos_molde + @n_nos_metal
			puts "N nos:  " + @n_nos.to_s
	# dividir nos por metal e molde(metade)
			@hi = 0.001
			@delta_z = 0.001
			@delta_y = 0.001
			@delta_x = 0.001
			inicia_vetor(t_ambiente,t_molde,t_metal)
			calcula_delta_tempo
			calculos
			
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
		for i in 1..((@n_nos_molde))
					@vet_temp[0][i] = tm.to_i
		end
		# inicializa primeiro vetor da metade ao fim com a temperatura do metal, e considerado que metade dos nos estao na area do metal
		for k in (@n_nos_molde)..@n_nos			
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
			@difusividade = @aluminio['condutividade_termica_liquido'] / (@aluminio['calor_especifico_liquido'] * @aluminio['densidade_liquido'])
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
		@delta_tempo = delta_tempo * 0.001
		puts "delta tempo:  " +  @delta_tempo.to_s
		
	return 	

	end
	
#	def calcula_delta_x(l_molde,l_metal,n_nos)
#		@delta_x = (l_metal + l_molde) / (n_nos)
#		puts "Delta x: " + @delta_x.to_s
#	end

	def calcula_cap_termica_no(estado,*temperatura)
		calcula_area(@delta_z,@delta_y)
		if estado == 'l'
			cap = @aluminio['calor_especifico_liquido'] * @aluminio['densidade_liquido'] * @delta_x * @area
		elsif estado == 's'
			cap = @aluminio['calor_especifico_solido'] * @aluminio['densidade_solido'] * @delta_x * @area
#			puts cap.to_s + "   capacitanica"
		end
		return cap
	end

	def calcula_R(estado, *temperatura)
		puts "Estado :  " + estado.to_s + "  temperatura:  " + temperatura.to_s
		if estado == 'l'
			r = (@delta_x) / (2 * @aluminio['condutividade_termica_liquido'] * @area)
		elsif estado == 's'
			r = (@delta_x) / (2 * @aluminio['condutividade_termica_solido'] * @area)
#			puts "R:  " + r.to_s
		elsif estado == 'p'
			puts "chegou ao R"
			c_propriedades(temperatura)
			puts @k_pastoso
			r = (@delta_x) / (2 * @k_pastoso * @area)						
		end
		return r
	end
	
	def calculos
		@tal_carga_solido = calcula_tal('carga','s',1,1,1)
		puts "tal_carga_solido:  " + @tal_carga_solido.to_s 
		@tal_descarga_solido = calcula_tal('descarga','s',1,1,1)
		puts "tal_descarga_solido:  " + @tal_descarga_solido.to_s 
		@tal_resultante_solido = calcula_tal('resultante','s',1,1,1)
		puts "tal_resultante_solido:  " + @tal_resultante_solido.to_s 
		@tal_carga_liquido = calcula_tal('carga','l',1,1,1)
		puts "tal_carga_liquido:  " + @tal_carga_liquido.to_s 
		@tal_descarga_liquido = calcula_tal('descarga','l',1,1,1)
		puts "tal_carga_solido:  " + @tal_descarga_liquido.to_s 
		@tal_resultante_liquido = calcula_tal('resultante','l',1,1,1)
		puts "tal_resultante_liquido:  " + @tal_resultante_liquido.to_s 
	end
		
	def calcula_R_hi
		r_hi = 1 / (@hi * @area)
	end
	
	def calcula_frac_solido(temp)
		puts "Chegou ao calcula frac_solido"
		puts "temp" + temp.to_s
		temp_fus= @aluminio['temperatura_fusao']
		a = (temp_fus  - temp)  / (@aluminio['temperatura_fusao'].to_f - @aluminio['temperatura_liquidus'].to_f)
		puts "Valor de a:" + a.to_s
		b = 1 / (@aluminio['coeficiente_particao'] - 1)
		c = 1 / (@aluminio['temperatura_fusao'] - @aluminio['temperatura_liquidus'])
		@fs = 1 - (a ** b) 
		puts "@fs:  " + @fs.to_s
		@dfs = a * @fs * c
		puts "@dfs:  " + @dfs.to_s
	end

	 
	def c_propriedades(temp)
		puts "chegou ao calcula peorpriedades"  
		puts "temperatura: " + temp.to_s
		calcula_frac_solido(temp)
		@k_pastoso = (@aluminio['condutividade_termica_solido'] - @aluminio['condutividade_termica_liquido'])*@fs + @aluminio['condutividade_termica_liquido']
		@d_pastoso = (@aluminio['densidade_solido'] - @aluminio['densidade_liquido'])*@fs + @aluminio['densidade_liquido']
		@c_pastoso = (@aluminio['calor_especifico_solido'] - @aluminio['calor_especifico_liquido'])*@fs + @aluminio['calor_especifico_liquido'] + @aluminio['calor_latente']*@dfs
	end

	def calcula_tal(tipo,estado, t_ant, t_atual, t_post)
		puts "Tipo:  " + tipo + "ta:  " + t_ant.to_s + "  t atual:  " + t_atual.to_s + " t post:  " + t_post.to_s
		capacitancia = calcula_cap_termica_no(estado)
		r_ant = calcula_R(estado,t_ant)
		puts "R ant:  " + r_ant.to_s
		r_proximo = calcula_R(estado,t_post)
		puts "R proximo:  " + r_proximo.to_s
		r_atual = calcula_R(estado,t_atual)
		puts "R atual:  " + r_atual.to_s
		if estado == 'p'
			puts "Entrou do estado"
			if tipo == 'carga'
				tal = capacitancia * (r_ant +  r_atual)
 				puts "tal:  " + tal.to_s + "calculou"
			elsif tipo == 'descarga' 
				tal = capacitancia * (r_atual + r_proximo)			
			elsif tipo == 'resultante'
				t_carga = calcula_tal('carga','p',1,1,1)
				t_descarga  = calcula_tal('descarga','p',1,1,1)
				tal = 1 / ((1 / t_carga) + (1 / t_descarga)) 
			end
		end
		if tipo == 'carga'
			tal = capacitancia * (r_ant +  r_atual)
		elsif tipo == 'descarga' 
			tal = capacitancia * (r_atual + r_proximo)			
		elsif tipo == 'resultante'
			t_carga = calcula_tal('carga',estado,1,1,1)
			t_descarga  = calcula_tal('descarga',estado,1,1,1)
			tal = 1 / ((1 / t_carga) + (1 / t_descarga)) 
		end		
		return tal
	end

	# Este metodo calcula a temperatura de cada no. Parametros :ciclo - ciclo de tempo :no em qual no :estados estado fisico do metal => liquido, solido ou mush
	def calcula_temp(ciclo,no,pos,estado)
		if pos == -1
			if estado == 's'
				temp = (@vet_temp[ciclo][no-1] * @delta_tempo) / (@tal_descarga_solido)
			elsif estado =='l'
				temp = (@vet_temp[ciclo][no-1] * @delta_tempo) / (@tal_descarga_liquido)
			elsif estado == 'p'
				puts "--------------------------------------------------------"
				puts "Método calcula_temp"
				puts "ciclo:  " + ciclo.to_s + "  nos:  " + no.to_s + "  pos:  " + pos.to_s + "  estado:  " + estado.to_s
				puts "--------------------------------------------------------"
				a = (calcula_tal('descarga','p',@vet_temp[ciclo][no - 1],@vet_temp[ciclo][no],@vet_temp[ciclo][no + 1]))
				puts "valor de a :"  + a.to_s
				temp = (@vet_temp[ciclo][no-1] * @delta_tempo) / (calcula_tal('descarga','p',@vet_temp[ciclo][no - 1],@vet_temp[ciclo][no],@vet_temp[ciclo][no + 1]))
			end
		elsif pos == 0
			if estado == 's'
				temp =  (1 - (@delta_tempo / @tal_resultante_solido)) * (@vet_temp[ciclo][no])
			elsif estado == 'l'
				temp =  (1 - (@delta_tempo / @tal_resultante_liquido)) * (@vet_temp[ciclo][no])
			elsif estado == 'p'
				puts "--------------------------------------------------------"
				puts "Método calcula_temp"
				puts "ciclo:  " + ciclo.to_s + "  nos:  " + no.to_s + "  pos:  " + pos.to_s + "estado" + estado.to_s
				puts "--------------------------------------------------------"
				a =  calcula_tal('resultante','p',@vet_temp[ciclo][no - 1],@vet_temp[ciclo][no],@vet_temp[ciclo][no + 1])
				puts "valor de a :"  + a.to_s
				temp =  (1 - (@delta_tempo / calcula_tal('resultante','p',@vet_temp[ciclo][no - 1],@vet_temp[ciclo][no],@vet_temp[ciclo][no + 1])) * (@vet_temp[ciclo][no]))
			end
		elsif pos == 1
			if estado == 's'
				temp = (@vet_temp[ciclo][no+1] * (@delta_tempo)) / (@tal_carga_solido)
			elsif estado == 'l'
				temp = (@vet_temp[ciclo][no+1] * (@delta_tempo)) / (@tal_carga_liquido)
			elsif estado == 'p'
				puts "--------------------------------------------------------"
				puts "Método calcula_temp"
				puts "ciclo:  " + ciclo.to_s + "  nos:  " + no.to_s + "  pos:  " + pos.to_s + "estado" + estado.to_s
				puts "--------------------------------------------------------"
				a = (calcula_tal('carga','p',@vet_temp[ciclo][no - 1],@vet_temp[ciclo][no],@vet_temp[ciclo][no + 1]))
				puts "valor de a :"  + a.to_s
				temp = (@vet_temp[ciclo][no+1] * (@delta_tempo)) / (calcula_tal('carga','p',@vet_temp[ciclo][no - 1],@vet_temp[ciclo][no],@vet_temp[ciclo][no + 1]))
			end
		end
		return temp
	end
		

	# Este metodo calcula a temperatura final de cada no somando as parcelas dos nos anterior, autal e posterior
	def temp_final
		i = 0
		n = 0
		t = @t_simulacao - 2
		puts t
		@vet_temp[n+1][i]=@vet_temp[n][i]
		for n in 0..t
			#puts n
			for i in 1..(@n_nos)
				if (i< (@n_nos_molde - 1 ) || i > (@n_nos_molde)) && i < @n_nos #calculo da temperatua para posição 2 até a interface e depois da interface ate o penultimo no
					if i <= @n_nos_molde #calculo da temperatura para estado solido MOLDE
						@vet_temp[n+1][i] = calcula_temp(n,i,-1,'s') + calcula_temp(n,i,0,'s') + calcula_temp(n,i,1,'s')
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura :  "  + @vet_temp[n+1][i].to_s					
					elsif i > @n_nos_molde # calculo da temperatura para estado liquido METAL
						if @vet_temp[n][i] <= @aluminio['temperatura_solidus'] # <= 548
							@vet_temp[n+1][i] = calcula_temp(n,i,-1,'s') + calcula_temp(n,i,0,'s') + calcula_temp(n,i,1,'s')
							puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura :  " + @vet_temp[n+1][i].to_s + "a"
						elsif @vet_temp[n][i] >=  @aluminio['temperatura_liquidus'] # >= 645
							@vet_temp[n+1][i] = calcula_temp(n,i,-1,'l') + calcula_temp(n,i,0,'l') + calcula_temp(n,i,1,'l')
							puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura :  " + @vet_temp[n+1][i].to_s + "b"
	
						elsif @vet_temp[n][i] > @aluminio['temperatura_solidus'] && @vet_temp[n][i] < @aluminio['temperatura_liquidus'] #  645 > t > 548 
							a = calcula_temp(n,i,-1,'p')
							b = calcula_temp(n,i,0,'p')
							c = calcula_temp(n,i,1,'p')
							@vet_temp[n+1][i] = calcula_temp(n,i,-1,'p') + calcula_temp(n,i,0,'p') + calcula_temp(n,i,1,'p')
							puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura :  " + @vet_temp[n+1][i].to_s + "c"
														
						end
					end
				elsif i == (@n_nos_molde - 1) # calculo da temperatura interface
						@vet_temp[n+1][i] = calcula_temp(n,i,-1,'s') + calcula_temp(n,i,0,'s') + calcula_temp(n,i,1,'s')
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura ultimo no MOLDE :  " +  @vet_temp[n+1][i].to_s
				elsif i == @n_nos_molde # calculo da temperatura interface
						@vet_temp[n+1][i] = calcula_temp(n,i,-1,'l') + calcula_temp(n,i,0,'l') + calcula_temp(n,i,1,'l')
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura primeiro no METAL :  " + @vet_temp[n+1][i].to_s
				elsif i == @n_nos # calculo temperatura loptall
						@vet_temp[n+1][i] = 2 * calcula_temp(n,i,-1,'l') + calcula_temp(n,i,0,'l') 
						puts "Ciclo: " + (n+1).to_s + "  Nos:  " + i.to_s + "  Temperatura ultimo no METAL :  "  + @vet_temp[n+1][i].to_s
				end
			end
		end
	end

	def escreve
		f = File.new("teste.txt","r+")
		1.step(@t_simulacao,100) {|j| f.write j.to_s + " " + @vet_temp[j][1].to_s + "\s " + @vet_temp[j][@n_nos_molde/2].to_s + "\s " + @vet_temp[j][@n_nos_molde].to_s + "\s " + @vet_temp[j][@n_nos_molde + @n_nos_metal/2].to_s + "\n "}
		f.close 
	end


	def teste
		bm(6) do |x| 
		x.report("teste") {temp_final } 
		end
	end 
		

end						

 
 

 
 
 
modelo = Calcula_modelo.new
modelo.mostra
modelo.temp_final
modelo.calcula_frac_solido(641.444444)


