;Write 8086 ALP to add array of 5 hexadecimal numbers stored in the memory.
menu macro msg              ;Indicates a macro for displaying strings
    lea dx,msg
    mov ah,09h
    int 21h
endm
.model small
.data
    msg1 db 10,13,'Enter length of array: $'
    msg2 db 10,13,'Enter array elements: $'
    msg3 db 10,13,'Sum of array elements: $'
    arr db 10,?,10 dup('$')     ;array
    c1 db ?
    n1 db ?
    n2 db ?
    len db ?
    sum db 00h
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

        ;finding sum
        menu msg3
        lea si,arr+2
        mov ch,len
        mov al,[si]
        dec ch

        sum_arr:    inc si
                    mov bl,[si]
                    add al,bl
                    ;add sum,al
                    ;add al,arr[si+1]
                    ;add sum,al
                    ;inc di
                    dec ch
                    ;cmp cl,0
                    jnz sum_arr


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

