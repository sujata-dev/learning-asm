;16 by 8 bit division
menu macro msg
lea dx,msg
mov ah,09h
int 21h
endm
.model small
.data
msg0 db 10,13,'Enter numerator: $'
msg1 db 10,13,'Enter denominator: $'
msg2 db 10,13,'Quotient: $'
msg3 db 10,13,'Remainder: $'
n1 db ?
n2 db ?
n3 db ?
n4 db ?
num1 db ?
num2 db ?
.code
main proc
mov ax,@data
mov ds,ax
menu msg0
call accept
mov dh,n1
mov num1,dh
call accept
mov dl,n1
mov num2,dl

menu msg1
call accept
mov ch,n1
mov ah,num1
mov al,num2
div ch
mov n3,al ;Q
mov n4,ah ;R
mov ch,n3
mov n2,ch
menu msg2
call disp
mov ch,n4
mov n2,ch
menu msg3
call disp
mov ah,4ch
int 21h
main endp

accept Proc Near
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
down1:and al,0Fh
add al,n1
mov n1,al
ret
endp

disp Proc Near
mov al,n2
and al,0F0h
rol al,04h
cmp al,0Ah
jc down4
add al,07h
down4:add al,30h
mov dl,al
mov ah,02h
int 21h

mov al,n2
and al,0Fh
cmp al,0Ah
jc down5
add al,07h
down5:add al,30h
mov dl,al
mov ah,02h
int 21h
ret
endp

end main
