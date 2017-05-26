;Menu driven program to
;   Enter two 8 bit numbers
;   Addition
;   Subtraction
;   Multiplication
menu macro msg              ;Indicates a macro for displaying strings
    lea dx,msg
    mov ah,09h
    int 21h
endm
.model small
.data
    msg0 db 'Menu$'
    msg1 db 10,13,'1) Enter 1st 8-bit number: $'
    msg2 db 10,13,'2) Enter 2nd 8-bit number: $'
    msg3 db 10,13,'3) Addition$'
    msg4 db 10,13,'4) Subtraction$'
    msg5 db 10,13,'5) Multiplication$'
    msg6 db 10,13,'6) Exit$'
    msg7 db 10,13,'Enter choice: $'
    msg8 db 10,13,'Enter 1st 8-bit number: $'
    msg9 db 10,13,'Enter 2nd 8-bit number: $'
    msg10 db 10,13,'Answer: $'
    c1 db ?
    n1 db ?
    n2 db ?
    num1 db ?
    num2 db ?
    ans db ?
.code
    main proc
        mov ax,@data
        mov ds,ax
        menu msg0
        menu msg1
        menu msg2
        menu msg3
        menu msg4
        menu msg5
        menu msg6
        choice: menu msg7
                call acceptchoice
                cmp c1,31h
                je acc1
                cmp c1,32h
                je acc2
                cmp c1,33h
                je a1
                cmp c1,34h
                je s1
                cmp c1,35h
                je m1
                cmp c1,36h
                je e1
                jmp e1

        acc1:   menu msg8
                call accept
                mov bl,n1
                mov num1,bl
                jmp choice

        acc2:   menu msg9
                call accept
                mov dl,n1
                mov num2,dl
                jmp choice

        a1: menu msg10
            ;adding
            call add1
            jmp choice

        s1: menu msg10
            ;subtracting
            call sub1
            jmp choice
        m1: menu msg10
            call mul1
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


    accept Proc Near    ;Procedure to accept operands
        mov ah,01h
        int 21h
        cmp al,3Ah
        jc down
        sub al,07h
        down:and al,0Fh
        mov cl,04h
        ror al,cl
        mov n1,al

        mov ah,01h
        int 21h
        cmp al,3Ah
        jc down1
        sub al,07h
        down1:  and al,0Fh
                add al,n1
                mov n1,al
                ret
    endp


    add1 Proc Near
        mov al,num1
        add al,num2
        mov ans,al

        jnc down6   ;for carry
        mov dl,31h
        mov ah,02h
        int 21h
        down6:  call disp
        ret
    endp


    sub1 Proc Near
        mov al,num1
        sub al,num2
        mov ans,al
        call disp
        ret
    endp


    mul1 Proc Near          ;Procedure for multiplying operands
        mov al,num1
        mov bl,num2
        mul bl
        mov bl,al
        mov ans,ah
        call disp
        mov ans,bl
        call disp
        ret
    endp


    disp Proc Near      ;Procedure for displaying
        mov al,ans
        and al,0F0h
        rol al,04h
        cmp al,0Ah
        jc down4
        add al,07h
        down4:add al,30h
        mov dl,al
        mov ah,02h
        int 21h

        mov al,ans
        and al,0Fh
        cmp al,0Ah
        jc down5
        add al,07h
        down5:  add al,30h
                mov dl,al
                mov ah,02h
                int 21h
                ret
        endp


end main

