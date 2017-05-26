;To add two 32-bit Hexa decimal numbers
menu macro msg              ;Indicates a macro for displaying strings
    lea dx,msg
    mov ah,09h
    int 21h
endm
.model small
.data
    msg0 db 'Menu$'
    msg1 db 10,13,'1) Enter 1st 32-bit number$'
    msg2 db 10,13,'2) Enter 2nd 32-bit number$'
    msg3 db 10,13,'3) Addition$'
    msg4 db 10,13,'4) Exit$'
    msg5 db 10,13,'Enter choice: $'
    msg6 db 10,13,'Enter 1st 32-bit number: $'
    msg7 db 10,13,'Enter 2nd 32-bit number: $'
    msg8 db 10,13,'Answer: $'
    c1 db ?
    n1 db ?
    n2 db ?
    num11 dw ?      ;num1
    num12 dw ?
    num21 dw ?      ;num2
    num22 dw ?
    num31 dw ?      ;num3
    num32 dw ?
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
        choice: menu msg5
                call acceptchoice
                cmp c1,31h
                je acc1
                cmp c1,32h
                je acc2
                cmp c1,33h
                je a1
                cmp c1,34h
                je e1
                jmp e1


        acc1:   menu msg6
                call accept         ;num11
                mov bh,n1
                call accept
                mov bl,n1
                mov num11,bx        ;higher

                call accept         ;num12
                mov dh,n1
                call accept
                mov dl,n1
                mov num12,dx        ;lower
                jmp choice


        acc2:   menu msg7
                call accept         ;num21
                mov bh,n1
                call accept
                mov bl,n1
                mov num21,bx        ;higher

                call accept         ;num22
                mov dh,n1
                call accept
                mov dl,n1
                mov num22,dx        ;lower
                jmp choice


        a1: menu msg8
            call add1
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
        mov cx,num12    ;adding lower order bits
        add cx,num22
        mov num32,cx

        mov bx,num11    ;adding higher order bits
        add bx,num21
        mov num31,bx

        jnc down6   ;for carry
        mov dl,31h
        mov ah,02h
        int 21h
        down6:  mov bx,num31
                mov ans,bh
                call disp
                mov ans,bl
                call disp

                mov cx,num32
                mov ans,ch
                call disp
                mov ans,cl
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

