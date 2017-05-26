;Write 8086 ALP to Accept input from the user, store it in an array and
;arrange array in ascending and descending order
menu macro msg              ;Indicates a macro for displaying strings
    lea dx,msg
    mov ah,09h
    int 21h
endm
.model small
.data
    msg1 db 10,13,'Enter length of array: $'
    msg2 db 10,13,'Enter array elements: $'
    msg3 db 10,13,'Array elements in ascending order: $'
    msg4 db 10,13,'Array elements in descending order: $'
    arr db 10,?,10 dup('$')     ;array
    c1 db ?
    n1 db ?
    n2 db ?
    len db ?
    ans db ?
.code
    main proc
        mov ax,@data
        mov ds,ax
        menu msg1
        call accept
        mov ch,n1
        mov len,ch

        ;inputting
        menu msg2
        lea si,arr+2
        arr_input:  call accept
                    mov al,n1
                    mov [si],al
                    inc si
                    dec ch
                    jnz arr_input

        ;ascending
        menu msg3
        mov ch,len

        asc3:   mov cl,len
                lea si,arr+2

        asc1:   mov al,[si]
                mov bl,[si+1]
                cmp al,bl
                jc asc2
                mov dl,[si+1]
                xchg [si],dl
                mov [si+1],dl

        asc2:   inc si
                dec cl
                jnz asc1
                dec ch
                jnz asc3

        lea si,arr+2
        mov ch,len

        disp_arr:   mov al,[si]
                    mov ans,al
                    call disp
                    inc si
                    dec ch
                    jnz disp_arr


        ;descending
        menu msg4
        mov ch,len
        desc3:  mov cl,len
                lea si,arr+2

        desc1:  mov al,[si]
                mov bl,[si+1]
                cmp al,24h
                je done
                cmp al,bl
                jnc desc2
                mov dl,[si+1]
                xchg [si],dl
                mov [si+1],dl

        desc2:  inc si
                dec cl
                cmp cl,00h
                jnz desc1
                dec ch
                jnz desc3

        done:   lea si,arr+3
                mov ch,len

        disp_arr1:  mov al,[si]
                    mov ans,al
                    call disp
                    inc si
                    dec ch
                    jnz disp_arr

        mov ah,4ch
        int 21h
    main endp


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

