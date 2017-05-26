;Program to accept a 2 digit number from keyboard and display it
.model small        ;Indicates amount of memory to be kept aside for     programming
.data               ;Indicates the following lines as data
n1 db ?             ;Declares variable n1 of db (define byte) type
.code               ;Indicates the following lines as instructions
main proc
mov ax,@data        ;Initialize ds with address of data
mov ds,ax           ; segment, setting it up for the current executable
call accept         ;Transfers control to procedure accept
call disp           ;Transfers control to procedure disp
mov ah,4ch          ;For termination
int 21h             ; of the program
main endp

accept Proc Near    ;Declares procedure accept
mov ah,01h          ;Loads 01 to ah, for accepting input in ten's place
int 21h             ;DOS interrupt
cmp al,3Ah          ;Compares al with 3A
jc down             ;Jumps if carry flag is set to 1
sub al,07h          ;If CF=0, (A-F present), subtracts 07 from al
down:and al,0Fh     ;Performs and operation between al and 0Fh, masking done
mov cl,04h
ror al,cl           ;Rotates value of al, cl times right
mov n1,al           ;Loads al to n1

mov ah,01h          ;Loads 01 to ah, for accepting input in one's place
int 21h
cmp al,3Ah
jc down1
sub al,07h
down1:and al,0Fh
add al,n1           ;Adds al and n1 to get the 2-digit number
mov n1,al
ret                 ;Returns from procedure
endp                ;Indicates end of procedure

disp Proc Near      ;Declares procedure disp
mov al,n1
and al,0F0h         ;Extracts the ten's place digit
mov cl,04h
rol al,cl           ;Rotates value of al, cl times left
cmp al,0Ah          ;Compares al with 0A
jc down2            ;Jump if carry=1
add al,07h          ;Adds al to 07h
down2:add al,30h    ;Adds al to 30h
mov dl,al           ;Loads al to dl
mov ah,02h          ;Display the ten's place
int 21h             ; value in dl register

mov al,n1
and al,0Fh          ;Extracts the one's place digit
cmp al,0Ah          ;Compares al with Ah
jc down3
add al,07h
down3:add al,30h
mov dl,al
mov ah,02h          ;Displays the ten's place
int 21h             ; value in dl register
ret
endp

end main            ;Indicates end of code
