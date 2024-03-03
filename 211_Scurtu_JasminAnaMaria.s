.data
matrix: .space 1600
matrix2: .space 1600
columnIndex: .space 4
lineIndex: .space 4
indexk: .space 4
n: .space 4
m: .space 4
n1: .space 4
m1: .space 4
p: .space 4
index: .space 4
left: .space 4
right: .space 4
k: .space 4
x: .space 4
formatScanf: .asciz "%ld"
formatPrintf: .asciz "%ld "
newLine: .asciz "\n"
.text

copie_matrice:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	
	movl	12(%ebp), %edi
	movl	16(%ebp), %esi

	movl	8(%ebp), %eax

	xorl	%ecx, %ecx
for_copie:

	cmp %ecx, %eax	
	je et_golire
	movl	(%esi, %ecx, 4), %edx
	movl	%edx, (%edi, %ecx, 4)

	incl	%ecx
	jmp for_copie

et_golire:

	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	ret
.global main
main:

	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $m
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $p
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	addl $2, m
	addl $2, n

movl $0, index
et_for:
	movl index, %ecx
	cmp %ecx, p
	je et_read_evo

	pushl $left
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	incl left

	pushl $right
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	incl right

	movl left, %eax
	movl $0, %edx
	mull m
	addl right, %eax
	lea matrix, %edi
	movl $1, (%edi, %eax, 4)


	incl index
	jmp et_for

et_read_evo:

	pushl $k
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
/////////////////////////////////////////////////////////////////////

movl $1,lineIndex
movl $1,columnIndex
movl $0,indexk
for_k:
	movl indexk,%ecx
	cmp %ecx, k
	je et_afis_matr
	
	pushl	$matrix 
	pushl	$matrix2
	pushl	$400    
	call copie_matrice
	popl	%ebx
	popl	%ebx
	popl	%ebx
	
	movl $1, lineIndex
for_lines1:
	movl lineIndex, %ecx
	incl %ecx # to not update border
	cmp %ecx, n
	je cont2
	movl $1, columnIndex 
for_columns1:
	movl columnIndex, %ecx
	incl %ecx # to not update border
	cmp %ecx, m
	je cont1
	
	movl $0, x 
	jmp et_v1

	
et_v1:
	decl lineIndex
	decl columnIndex
	
	movl lineIndex,%eax   
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	incl lineIndex
	incl columnIndex
	
	lea matrix2,%edi    
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	
	jmp et_v2
et_v2:
	decl lineIndex
	
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	incl lineIndex
	
	lea matrix2,%edi
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	jmp et_v3
et_v3:
	decl lineIndex
	incl columnIndex
	
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	incl lineIndex
	decl columnIndex
	
	lea matrix2,%edi
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	jmp et_v4
et_v4:
	incl columnIndex
	
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	decl columnIndex
	
	lea matrix2,%edi
	
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	jmp et_v5
et_v5:
	incl lineIndex
	incl columnIndex
	
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	decl lineIndex
	decl columnIndex
	
	lea matrix2,%edi
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	jmp et_v6
et_v6:
	incl lineIndex
	
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	decl lineIndex
	
	lea matrix2,%edi
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	jmp et_v7
et_v7:
	incl lineIndex
	decl columnIndex
	
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	decl lineIndex
	incl columnIndex
	
	lea matrix2,%edi
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	jmp et_v8
et_v8:
	decl columnIndex
	
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	incl columnIndex
	
	lea matrix2,%edi
	movl (%edi,%eax,4),%ebx
	addl %ebx,x
	jmp et_celula_curenta
	
et_celula_curenta:

	movl lineIndex,%eax  # si aici swap
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	lea matrix,%edi
	cmpl $0,(%edi,%eax,4) 
	je et_x
	jmp et_x1 
et_x1:
	movl x,%ebx
	movl $2,%eax
	movl $3,%edx
	
	cmp %eax,%ebx
	jl et_moarta
	
	cmp %eax,%ebx
	je et_vie
	
	cmp %edx,%ebx
	je et_vie
	
	cmp %edx,%ebx
	jg et_moarta
	
et_x:
	movl x,%ebx 
	movl $3, %edx 
	cmp %edx,%ebx
	je et_vie
	
	cmp %edx,%ebx
	jne et_moarta	
	
et_moarta:
	movl lineIndex,%eax
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	lea matrix,%edi
	movl $0, (%edi, %eax, 4)
	
	incl columnIndex
	jmp for_columns1 
	
et_vie:
	movl lineIndex,%eax 
	movl $0,%edx
	mull m
	addl columnIndex,%eax
	
	lea matrix,%edi
	movl $1, (%edi, %eax, 4)
	
	incl columnIndex
	jmp for_columns1 

cont1:
	
	incl lineIndex
	jmp for_lines1
	
cont2:
	
	incl indexk
	jmp for_k

////////////////////////////////////////////////////////////////////////////
et_afis_matr:
	movl	n, %eax
	decl	%eax
	movl	%eax, n1

	movl	m, %eax
	decl	%eax
	movl	%eax, m1
movl 	$1, lineIndex
	for_lines:
		movl 	lineIndex, %ecx
		cmp 	%ecx, n1
		je exit
			
		movl 	$1, columnIndex
	for_columns:
		movl 	columnIndex, %ecx
		cmp 	%ecx, m1
		je cont
				
		movl 	lineIndex, %eax
		movl 	$0, %edx
		mull 	m
		addl 	columnIndex, %eax
				
		lea	matrix, %edi
				
		movl 	(%edi, %eax, 4), %ebx
				
		pushl 	%ebx
		pushl 	$formatPrintf
		call printf
		popl 	%ebx
		popl 	%ebx

		pushl 	$0
		call fflush
		popl 	%ebx
				
		incl 	columnIndex
		jmp for_columns

	cont:		
		movl 	$4, %eax
		movl 	$1, %ebx
		movl 	$newLine, %ecx
		movl 	$2, %edx
		int 	$0x80
		
		incl 	lineIndex
		jmp for_lines


exit:
	movl 	$1, %eax
	movl 	$0, %ebx
	int 	$0x80
	
