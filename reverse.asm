;Napisati proceduru reverse FAR (NEAR ovdje) koja preuredjuje niz ASCII karaktera tako da se oni pojavljuju u
;obrnutom redoslijedu u odnosu na polazni oblik (bez koristenja steka). Niz karaktera se proceduri proslijedjuje pojavljuje
;po referenci. Pretpostaviti da se niz karaktera zavrsava nulom.


.model small
.stack
.data
    string  db   'Nikola',0
.code
.startup
    mov	ax,offset string
    push	ax  
    call	reverse  
 
reverse	proc	near        
    push ax
    push cx       
    push si
    push di
    push bp
  
    mov bp,sp
    mov si,[bp+12]
    mov cx,0
	
    calculate_lenght:
        cmp [si],0
        je continue
        inc si
        inc cx
    jmp calculate_lenght
    continue:
        mov si,[bp+12]
        mov di,cx
        dec di
        shr cx,1    ;polovina duzine
        iterate:
                mov al,[si]
                xchg al,[di]
                mov [si],al                
                inc si
                dec di           
        loop iterate 
    
    mov si,offset string   
    print:   ;ispisi izmijenjen string
          cmp [si],0
          je end
          mov dl,[si]
          mov ah,2h
          int 21h 
          inc si
    jmp print
     
    end:     
		pop bp
		pop di
		pop si
		pop cx
		pop ax
		ret 2
		
end
