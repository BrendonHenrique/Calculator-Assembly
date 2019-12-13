 .data

	$mensagem1: .asciiz "Informe o primeiro valor : "
	$mensagem2: .asciiz "\nInforme o segundo valor : "
	$mensagem3: .asciiz "\nSelecione uma opera��o dentre as poss�veis :\n+ somar \n- subtrair\n* multiplicar\n/ dividir\n"
	$mensagem4: .asciiz "\n Selecionado continuar , ent�o informe o proximo valor : " 
	$mensagem6: .asciiz "\nSe voc� quiser continuar a operacao digite $ para inserir um novo n�mero\nPara calcular a opera��o com os n�meros inseridos at� agora digite & \n"
	$final:    .asciiz "\nO resultado � : "
	
.text
	 
 	#Inserir primeiro valor
 	  
	getValor1: 
	
		#imprime a mensagem 1	
		li $v0, 4 
		la $a0, $mensagem1
		syscall 
		
		#le o primeiro valor
		li $v0, 5 
		syscall 
		
		#armazena o valor lido em $s0
		move $s0, $v0 
	
	getValor2: 
	
		#imprime mensagem 2
		li $v0, 4  
		la $a0, $mensagem2  
		syscall  
		
		#le o segundo valor 
		li $v0, 5  
		syscall  
		
		#armazena o valor lido em $s1
		move $s1, $v0  
		
	
	showMenu:
		
		#imprime mensagem3
		li $v0, 4  
		la $a0, $mensagem3 
		syscall  
		
		#le a op��o escolhida pelo usu�rio, essa opera��o ser� executada apartir do primeiro e do segundo valor lido at� aqui
		li $v0,12  
		syscall 
		
		#armazena a op��o selecionada 
		move $s2, $v0 	
		
		#faz branch de acordo com a op��o do usu�rio
		#O caracter inserido � comparado ao hexadecimal da tabela ascii
		#Tabela de correspond�ncia caracter x hexadecimal 
		# + == 43 hex
		# - == 45 hex
		# * == 42 hex
		# / == 47 hex
		
		beq $s2,43,somaFn 
		beq $s2,45,subtracaoFn
		beq $s2,42,multiplicacaoFn  
		beq $s2,47,divisaoFn  
		j termina  
	
	somaFn:
		
		#soma os valores inseridos at� o momento e armazena em $s2 
		add $s2, $s0, $s1  
		j continuar  
	
	subtracaoFn: 
		
		#soma os valores inseridos at� o momento e armazena em $s2 
		sub $s2, $s0, $s1  
		j continuar  
	
	multiplicacaoFn: 
		
		#multiplica os valores inseridos at� o momento e armazena em $s2
		mul $s2, $s0, $s1  
		j continuar  
	divisaoFn: 
		
		#divide os valores inseridos at� o momento e armazena em $s2
		div $s2, $s0, $s1  
		j continuar  
	 
	#Continuar faz o loop para o usu�rio continuar calculando
	#Recebe a resposta do usu�rio , se ele deseja finalizar a conta ou continuar fazendo opera��es e faz o branch 
	continuar:
		
		li $v0, 4  
		la $a0, $mensagem6  
		syscall
	
		li $v0, 12  
		syscall
	
		beq $v0,36,selecionaNum
		beq $v0,38,imprimirFinal
	
	#Se o usu�rio optar por continuar ap�s ter inserido o caracter $ recebe o valor do pr�ximo n�mero 
	selecionaNum:			
	
		li $v0,4  
		la $a0, $mensagem4  
		syscall 
	
		li $v0,5  
		syscall
	
		move $s5, $v0
	
	#Ap�s selecionar o n�mero ele seleciona a opera��o que ser� empregada ao valor resultante at� o momento
	selecionaOp:
	
		li $v0,4  
		la $a0, $mensagem3  
		syscall  
		
		
		li $v0,12  
		syscall  
	
		move $s4, $v0  
		
		beq $s4,43,soma_Op
		beq $s4,45,subtracao_Op
		beq $s4,42,multiplicacao_Op
		beq $s4,47,divisao_Op
		j termina
	
	#As fun��es abaixo, realizam as opera��es e depois voltam pra o label 'continuar' pra verificar 
	#se o usu�rio quer continuar ou quer ver o resultado final 
	
	soma_Op:
	
		add $s2, $s2, $s5  
		j continuar 

	subtracao_Op:
	
		sub $s2, $s2, $s5  
		j continuar  
	
	multiplicacao_Op:
		
		mul $s2, $s2, $s5  
		j continuar  
	
	divisao_Op:	
		
		div $s2, $s2, $s5  
		j continuar  
	
	#Imprime final informa ao usu�rio pelo terminal qual � o resultado da opera��o feita  
	imprimirFinal:
		
		li $v0,4  
		la $a0,$final
		syscall
	
		li $v0,1  
		la $a0, ($s2)  
		syscall  
	
		j termina  
		
	#finaliza o programa com syscall 10 => exit (terminate execution)
	termina:
		
		li $v0, 10 
		syscall  