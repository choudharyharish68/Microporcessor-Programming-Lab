;NAME-Harish choudhary
;roll no-SECOA121
; OVERLAPPED BLOCK TRANSFER WITHOUT STRING
;ASSIGNMENT 2C
;______________________________________________________

%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro
;___________________________
%macro exit 0
	mov rax,60
	mov rbx,0
	syscall
%endmacro
;______________________________
section .data
	ano db 10,"                    ASSIGNMENT 2C-        "
	    db 10,"                   ................"
	    db 10,"          -OVERLAP BLOCK TRANSFER WITHOUT STRING"
	    db 10,"          ...........................................",10
	ano_len equ $ -ano
	bmsg db 10,"            BEFORE TRANSFER    	",10
        bmsgl equ $ -bmsg	
	amsg db 10,"             AFTER TRANFER  	",10
        amsgl equ $ -amsg
        sb db	   "   		  Source Block:		",9
        sbl equ $ -sb
        dbk db 10, "		destination Block:	",9
        dbkl equ $ -dbk
	sblock db 10h,20h,30h,40h,50h
        sblockl equ $ -sblock
        dblock  times 5 db 0h
	dblockl equ $ -dblock
	space db " "
	
 ;..............................
section .bss
  char_ans resb 2
;_______________________________

section .text
        global _start
_start:
     	print ano,ano_len

        print bmsg,bmsgl

        print sb,sbl
        mov rsi,sblock
 	call disp_block

   	print dbk,dbkl
	mov rsi,dblock-2;OVERLAPPING OF 2BLOCKS DBLOCK ON SBLOCK
	call disp_block

	call Bt_OV
	print amsg,amsgl

	  print sb,sbl
	 mov rsi,sblock
 	call disp_block

	print dbk,dbkl
	mov rsi,dblock-2;OVERLAPPING OF 2BLOCKS DBLOCK ON SBLOCK
	call disp_block
	
        exit
;_______________________________
disp_block:
         mov rbp,5
next_num:
	mov al,[rsi]
	push rsi
	call display 
	print space,1
	pop rsi
	inc rsi
	dec rbp
	jnz next_num
	ret
;.............................
display:		;converting hex to ascii
	mov rbx,16
	mov rcx,2
	mov rsi,char_ans+1
cnt:
	mov rdx,0
	div rbx ;rdx(remainder)=rax(qoutient)/rbx(value)
	cmp dl,09h 
	jbe add30
	add dl,07h
add30:
	add dl,30h
	mov [rsi],dl
	dec rsi 
	dec rcx ;decrement count
	jnz cnt ;till count isnot equal to 0
	print char_ans,2
ret
;-------------------------------------------------------------
Bt_OV:
	mov rsi,sblock+4
	mov rdi,dblock+2
	mov rcx,5
back:
	mov al,[rsi]
	mov [rdi],al
	
	dec rsi
	dec rdi	
	dec rcx
	jnz back
ret

;_____________________________________________________________________________________________
;_____________________________________________________________________________________________
;______________________________________________________________________________________________


;		OUTPUT:
;
;                    ASSIGNMENT 2C-        
 ;                  ................
 ;         -OVERLAP BLOCK TRANSFER WITHOUT STRING
;          ...........................................
;
;            BEFORE TRANSFER    	
;   		  Source Block:			10 20 30 40 50 
;		destination Block:		40 50 00 00 00 
;             AFTER TRANFER  	
;   		  Source Block:			10 20 30 10 20 
;		destination Block:		10 20 30 40 50 

;_______________________________________________________________________________________
