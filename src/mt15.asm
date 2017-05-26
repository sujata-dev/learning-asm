;Comparing 2 strings using string instruction
mess macro msg
lea dx,msg
mov ah,09h
int 21h
endm

.model small
.stack 100h
.data
msg1 db 10,13,'Enter string1: $'
msg2 db 10,13,'Enter string2: $'
msg3 db 10,13,'Strings are equal $'
msg4 db 10,13,'Strings are not equal $'
str1 db 10,?,10 dup('$')
str2 db 10,?,10 dup('$')

.code
main proc
mov ax,@data
mov ds,ax
mov es,ax

mess msg1
lea dx,str1
mov ah,0Ah
int 21h

mess msg2
lea dx,str2
mov ah,0Ah
int 21h

lea si,str1             ;Finding length
mov cl,[si+1]           ;of string1

lea di,str2             ;Finding length
mov bl,[si+1]           ;of string2
cmp cl,bl
jne label2              ;jump if not equal

mov ch,00h
lea si,str1+2
lea di,str2+2
cld                     ;clear direction
repe cmpsb
je label1
mess msg4
jmp e1
label1: mess msg3
        jmp e1
label2: mess msg4
        jmp e1
e1: mov ah,4ch
    int 21h
main endp


end main
