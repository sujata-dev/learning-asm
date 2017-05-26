;Finding string length with and without using string instructions
mess macro msg
lea dx,msg
mov ah,09h
int 21h
endm
.model small
.stack 100h
.data
msg1 db 10,13,'Enter string: $'
msg2 db 10,13,'String length without using string instructions: $'
msg3 db 10,13,'String length using string instructions: $'
str1 db 10,?,10 dup('$')
n1 db ?
n2 db 0h
.code
main proc
mov ax,@data
mov ds,ax
mess msg1
call accept
lea si,str1             ;Finding length
mov cl,[si+1]           ;of string without string instructions
mov n1,cl
mess msg2
call disp


lea si,str1+2            ;Finding string length using string instructions
jmp label2
label1: inc si
        mov bh,[si]
        cmp bh,24h      ;24h is ASCII value of '$'
        jne label2
        je label3

label2: inc n2
        jmp label1

label3: dec n2
        mov dh,n2
        mov n1,dh
        mess msg3
        call disp
        jmp e1

e1: mov ah,4ch
    int 21h
main endp


accept Proc Near        ;Procedure for accepting a string
lea dx,str1
mov ah,0Ah
int 21h
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
