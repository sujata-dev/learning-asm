;Comparing 2 strings without using string instruction
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
mov es,ax               ;es is used while working with di

mess msg1
lea dx,str1
mov ah,0Ah
int 21h

mess msg2
lea dx,str2
mov ah,0Ah
int 21h

lea si,str1+2
lea di,str2+2

lea si,str1             ;Finding length
mov cl,[si+1]           ;of string1

lea di,str2             ;Finding length
mov bl,[si+1]           ;of string2
cmp cl,bl
jne label1

mess msg3
jmp e1

label1: mov bl,[si]
        cmp [di],bl
        jne label2
        inc si
        inc di
        mov al,[di]
        cmp al,0Dh      ;0Dh is ASCII code for carriage return/newline
        jne label1

label2: mess msg4
        jmp e1

e1: mov ah,4ch
    int 21h
main endp

end main
