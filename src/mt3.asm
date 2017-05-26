;To find number of occurrences of 'a' in string, and print the first and last
;character of string
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
    msg2 db 10,13,'2) Find number of occurrences of a in string $'
    msg3 db 10,13,'3) Find the first and last character of string $'
    msg4 db 10,13,'4) Exit$'
    msg5 db 10,13,'Enter choice: $'
    msg6 db 10,13,'Enter string: $'
    msg7 db 10,13,'Number of occurrences of a in string: $'
    msg8 db 10,13,'First character of string: $'
    msg9 db 10,13,'Last character of string: $'
    str1 db 10,?,10 dup('$')
    str2 db 10,?,10 dup('$')
    n1 db ?
    c1 db ?
    len db ?
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
                je string
                cmp c1,32h
                je a_occ
                cmp c1,33h
                je firstlast
                cmp c1,34h
                je e1
                jmp e1      ;If choice is invalid, jump to e1 label, for exit


        string: mess msg6
                lea dx,str1
                mov ah,0Ah
                int 21h
                jmp choice


        a_occ:  mess msg7
                lea si,str1
                inc si
                mov cl,0h
                loop1:  inc si
                        mov al,[si]
                        cmp al,61h
                        je count
                        cmp al,24h
                        jne loop1
                        je done
                count:  inc cl
                        jmp loop1
                done:   mov n1,cl
                        call disp
                        jmp choice


        firstlast:  mess msg8
                    lea si,str1+2
                    mov dl,[si]
                    mov ah,02h      ;02h to display char, char should be in dl
                    int 21h

                    mess msg9
                    lea si,str1+1
                    loop2:  inc si
                            inc di
                            mov dl,[si]
                            cmp dl,24h
                            jne loop2
                    over:   mov al,[si-2h]
                            mov dl,al
                            mov ah,02h  ;02h to display char, char should be in dl
                            int 21h
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


    disp Proc Near          ;Procedure for displaying
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
