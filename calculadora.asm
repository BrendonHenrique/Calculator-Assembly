 .data

	$menssagem1: .asciiz "\Informe o primeiro valor :\n"
	$menssagem2: .asciiz "\nInforme o segundo valor :\n"
	$menssagem3: .asciiz "\nSelecione uma operação dentre as possíveis :\n+ para somar \n- para subtrair\n* para multiplicar\n/ para dividir\n"
	$menssagem4: .asciiz "\Informe o proximo valor :\n" 
	$menssagem6: .asciiz "\nSe você quiser continuar a operacao digite $ para inserir um novo número\nPara calcular a operação com os números inseridos digite & \n"
	$final:    .asciiz "\nO resultado é : "
	
.text
	 
 	#Inserir primeiro valor
 	  
	getValor1: 
	
		#imprime a mensagem 1	
		li $v0,4 
		la $a0, $menssagem1
		syscall 
		
		#le o primeiro valor
		li $v0,5 
		syscall 
		
		#armazena o valor lido em $s0
		move $s0, $v0 
	
	getValor2: 
	
		#imprime mensagem 2
		li $v0,4  
		la $a0, $menssage2  
		syscall  
		
		#le o segundo valor 
		li $v0,5  
		syscall  
		
		#armazena o valor lido em $s1
		move $s1, $v0  
		
	
	showMenu:
		
		#imprime mensagem4
		li $v0,4  
		la $a0, $menssage3 
		syscall  
		
		#le 
		li $v0,12  
		syscall 
	
		move $s2, $v0 
	
		beq $s2,43,somaOp  
		beq $s2,45,subtracaoOp  
		beq $s2,42,multiplicacaoOp  
		beq $s2,47,divisaoOp  
		j termina  
	
	somaOp:
	
		add $s2, $s0, $s1 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar
	
	subtracaoOp: 
	
		sub $s2, $s0, $s1 #subtrai os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar
	
	multiplicacaoOp: 

		mul $s2, $s0, $s1 #multiplica os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar
	
	divisaoOp: 

		div $s2, $s0, $s1 #divide os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar
	 
	continuar:
		
		li $v0, 4 #comando para impressão de string na tela
		la $a0, $menssage6 #coloca o texto de continue para ser impresso
		syscall
	
		li $v0, 12 #comando para ler caracter
		syscall
	
		beq $v0,36,selecionaNum
		beq $v0,38,imprimirFinal
	
	selecionaNum:			
	
		li $v0,4 #comando de impressão de string na tela
		la $a0, $message4 #coloca o texto de proxima operacao para ser impresso
		syscall # efetua a chamada ao sistema
	
		li $v0,5 #le o proximo numero
		syscall
	
		move $s5, $v0
	
	selecionaOp:
	
		li $v0,4 #comando de impressão de string na tela
		la $a0, $menssage3 #coloca o texto de operacao para ser impresso
		syscall # efetua a chamada ao sistema
	
		li $v0,12 #le entrada do usuário para o simbolo desejado
		syscall # efetua a chamada ao sistema
	
		move $s4, $v0 # move conteúdo de $v0 para $s4 (simbolo para $s4)
		
		beq $s4,43,soma_Op
		beq $s4,45,subtracao_Op
		beq $s4,42,multiplicacao_Op
		beq $s4,47,divisao_Op
		j termina
	
	soma_Op:
	
		add $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar

	subtracao_Op:
	
		sub $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar
	
	multiplicacao_Op:
		
		mul $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar
	
	divisao_Op:	
		
		div $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
		j continuar #desvia para opcao de continuar
	
	imprimirFinal:
		
		li $v0,4 #comando de impressão de string na tela
		la $a0,$final
		syscall
	
		li $v0,1 #comando de impressão de inteiro na tela
		la $a0, ($s2) #coloca o registrador $s2 para ser impresso
		syscall # efetua a chamada ao sistema
	
		j termina #desvia para selecao do proximo numero
		
	termina:
		
		li $v0, 10 # comando de exit
		syscall # efetua a chamada ao sistema