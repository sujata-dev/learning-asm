;To concatenate two strings
mess macro msg
    lea dx,msg
    mov ah,09h
    int 21h
endm
.model small
.stack 100h
.data
    msg0 db 'Menu$'
    msg1 db 10,13,'1) Enter string1$'
    msg2 db 10,13,'2) Enter string2$'
    msg3 db 10,13,'3) Concatenate string: $'
    msg4 db 10,13,'4) Exit$'
    msg5 db 10,13,'Enter choice: $'
    msg6 db 10,13,'Enter string1: $'
    msg7 db 10,13,'Enter string2: $'
    msg8 db 10,13,'Concatenated string1 and string2: $'
    str1 db 10,?,10 dup('$')
    str2 db 10,?,10 dup('$')
    str3 db 10,?,10 dup('$')
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
                je string2
                cmp c1,33h
                je con
                cmp c1,34h
                je e1
                jmp e1      ;If choice is invalid, jump to e1 label, for exit


        string1:    mess msg6
                    lea dx,str1
                    mov ah,0Ah
                    int 21h
                    jmp choice


        string2:    mess msg7
                    lea dx,str2
                    mov ah,0Ah
                    int 21h
                    jmp choice


        con:    mess msg8
                mov cl,str1+1   ;length of str1
                mov ch,0h
                lea si,str1+2
                lea di,str3
                ;copying entire str1 string to str3
                loop1:  mov al,[si]
                        mov [di],al
                        inc si
                        inc di
                        dec cl
                        jnz loop1
                        lea si, str2+2
                        mov cl,str2+1   ;length of str1
                ;copying entire str2 string to str3
                loop2:  mov al,[si]
                        mov [di],al
                        inc si
                        inc di
                        dec cl
                        jnz loop2
                ;'$'=24h, putting $ at end of string str3
                mov al,24h
                mov [di],al
                mess str3           ;printing reversed string
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


end main
