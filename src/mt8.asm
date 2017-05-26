;Write 8086 ALP to Accept input from the user, store it in an array and find
;max and min numbers from given array
menu macro msg              ;Indicates a macro for displaying strings
    lea dx,msg
    mov ah,09h
    int 21h
endm
.model small
.data
    msg1 db 10,13,'Enter length of array: $'
    msg2 db 10,13,'Enter array elements: $'
    msg3 db 10,13,'Max of array elements: $'
    msg4 db 10,13,'Min of array elements: $'
    arr db 10,?,10 dup('$')     ;array
    c1 db ?
    n1 db ?
    n2 db ?
    len db ?
    sum db 00h
    ans db ?
    max db 00h
    min db ?
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

        ;finding max
        menu msg3
        lea si,arr+2
        mov ch,len

        maxl1:  mov al,[si]
                cmp al,max
                jc maxl2
                mov max,al

        maxl2:  inc si
                dec ch
                jnz maxl1
                mov al,max
                mov ans,al
                call disp


        ;finding min
        menu msg4
        lea si,arr+2
        mov ch,len
        mov bl,[si]
        mov min,bl      ;initializing min as first element

        minl1:  mov al,[si]
                cmp min,al
                jc minl2
                mov min,al

        minl2:  inc si
                dec ch
                jnz minl1
                mov al,min
                mov ans,al
                call disp

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

