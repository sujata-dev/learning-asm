;Menu driven program to
;   Enter the string
;   Calculate length of string by direct method
;   Reverse string
;   Exit
mess macro msg
    lea dx,msg
    mov ah,09h
    int 21h
endm
.model small
.stack 100h
.data
    msg0 db 'Menu$'
    msg1 db 10,13,'1) Enter string$'
    msg2 db 10,13,'2) Find length of string by direct method$'
    msg3 db 10,13,'3) Reverse string$'
    msg4 db 10,13,'4) Exit$'
    msg5 db 10,13,'Enter choice: $'
    msg6 db 10,13,'Enter string: $'
    msg7 db 10,13,'String length: $'
    msg8 db 10,13,'Reversed string: $'
    str1 db 10,?,10 dup('$')
    rstr db 10,?,10 dup('$')
    c1 db ?
    n1 db ?
    n2 db ?
    ans db ?
.code
    main proc
        mov ax,@data
        mov ds,ax
        mov es,ax
        mess msg0
        mess msg1
        mess msg2
        mess msg3
        mess msg4
        choice: mess msg5
                call acceptchoice
                cmp c1,31h
                je string1
                cmp c1,32h
                je len
                cmp c1,33h
                je rev
                cmp c1,34h
                je e1
                jmp e1      ;If choice is invalid, jump to e1 label, for exit


        string1:    mess msg6
                    lea dx,str1
                    mov ah,0Ah
                    int 21h
                    jmp choice


        len:    lea si,str1     ;Finding string length
                mov cl,[si+1]
                mess msg7
                mov n1,cl
                call disp
                jmp choice


        rev:    lea si,str1
                lea di,rstr
                mov al,[si]     ;copy first two locations of str1 to rstr
                mov [di],al
                inc si
                inc di

                mov al,[si]
                mov [di],al
                inc si
                inc di

                mov cl,str1+1   ;copy length in cl
                mov ch,00
                add si,cx   ;add length of str1 to si to move it to last location
                dec si      ;si at last location of string1
                revstr: mov al,[si] ;copying character one by one from str1
                        mov [di],al ;to di in reverse order as si moves
                        dec si
                        inc di
                        dec cl
                        jnz revstr
                mess msg8
                mess rstr+2 ;print reversed string, +2 to get past 1st 2 positions
                jmp choice

        e1: mov ah,4ch
            int 21h
    main endp


    acceptchoice Proc Near  ;Procedure for accepting choice
        mov ah,01h
        int 21h
        mov c1,al
        ret
    endp


    disp Proc Near          ;Procedure for displaying length of string
        mov al,n1
        and al,0F0h
        rol al,04h
        cmp al,0Ah
        jc down
        add al,07h
        down:add al,30h
        mov dl,al
        mov ah,02h
        int 21h

        mov al,n1
        and al,0Fh
        cmp al,0Ah
        jc down1
        add al,07h
        down1:add al,30h
        mov dl,al
        mov ah,02h
        int 21h
        ret
    endp

end main
