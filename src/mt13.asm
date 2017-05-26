;32 by 16 bit division
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
n1 db ?             ;for accepting
n2 db ?             ;for displaying
nq1 db ?
nq2 db ?
nr1 db ?
nr2 db ?
num1 db ?
num2 db ?
num3 db ?
num4 db ?
.code
main proc
mov ax,@data
mov ds,ax
menu msg0
call accept     ;Accepting 32-bit numerator
mov dh,n1
mov num1,dh
call accept     ;Accepting 32-bit numerator
mov dl,n1
mov num2,dl
call accept     ;Accepting 32-bit numerator
mov ah,n1
mov num3,ah
call accept     ;Accepting 32-bit numerator
mov al,n1
mov num4,al

menu msg1
call accept     ;Accepting 16-bit denominator
mov ch,n1
call accept     ;Accepting 16-bit denominator
mov cl,n1

mov dh,num1
mov dl,num2
mov ah,num3
mov al,num4
div cx

mov nq1,ah      ;Quotient
mov nq2,al      ;Quotient
mov nr1,dh      ;Remainder
mov nr2,dl      ;Remainder

menu msg2
mov ch,nq1      ;displaying Quotient
mov n2,ch
call disp
mov ch,nq2      ;displaying Quotient
mov n2,ch
call disp

menu msg3
mov ch,nr1      ;displaying Remainder
mov n2,ch
call disp
mov ch,nr2      ;displaying Remainder
mov n2,ch
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
down1:and al,0Fh
add al,n1
mov n1,al
ret
endp


disp Proc Near      ;Procedure for displaying solution
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
