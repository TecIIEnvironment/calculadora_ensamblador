org 100h 
begin:
MOV AX,0600H 
MOV BH,0FH 
MOV CX,0000H
MOV DX,184FH
INT 10H 
MOV AH,02H 
MOV BH,00
MOV DH,00
MOV DL,00
INT 10H 
mov ax,0
mov bx,0
mov cx,0
mov dx,0  
mov n1,0
mov n2,0  
mov num1[0],0
mov num1[1],0
mov num1[2],0
mov num1[3],0
mov num2[0],0
mov num2[1],0
mov num2[2],0
mov num2[3],0
;set all string value to zero 
mov string[0],0
mov string[1],0
mov string[2],0
mov string[3],0
mov string[4],0
mov string[5],0
mov string[6],0 
mov string[7],0
;set message to request the first number
MOV DX,offset m0
MOV AH,9   
INT 21H 
mov index,4
;get the first number between 0 and 9999
first:
mov cx,index
mov ch,0
Mov AH,1     
int 21h
cmp al,27
je endl
cmp al,13
je cont
cmp al,48
jb del1 
cmp al,57
jg del1
sub al,30h
mov ah,0
mov ah,num1[1]
mov num1[0],ah
mov ah,num1[2]
mov num1[1],ah 
mov ah,num1[3]
mov num1[2],ah              
mov num1[3],al
dec index
loop first
jmp cont  
del1:
MOV AX,0600H 
MOV BH,0fH 
MOV CX,0016H
add cl,4
sub cl,index
MOV DX,184FH
INT 10H
MOV AH,02H 
MOV BH,00
MOV DH,00
MOV DL,22
add dl,4
sub dl,index
INT 10H
jmp first

del2: 
MOV AX,0600H 
MOV BH,0fH 
MOV CX,0118H
add cl,4
sub cl,index
MOV DX,184FH
INT 10H
MOV AH,02H 
MOV BH,00
MOV DH,01
MOV DL,24
add dl,4
sub dl,index
INT 10H
jmp second

del3: 
MOV AX,0600H 
MOV BH,0fH 
MOV CX,0236H
MOV DX,184FH
INT 10H
MOV AH,02H 
MOV BH,00
MOV DH,02
MOV DL,54
INT 10H
jmp sign

   
cont:
MOV DX,offset jump_line
MOV AH,9   
INT 21H 
;set message to request the second number
MOV DX,offset m1
MOV AH,9   
INT 21H
mov index,4
;get the second number between 0 and 9999 

second:
mov cx,index
mov ch,0  
Mov AH,1     
int 21h
cmp al,27
je endl
cmp al,13
je cont2
cmp al,48
jb del2
cmp al,57 
jg del2 
sub al,30h
mov ah,0
mov ah,num2[1]
mov num2[0],ah
mov ah,num2[2]
mov num2[1],ah
mov ah,num2[3]
mov num2[2],ah
mov num2[3],al
dec index                
loop second
cont2:       
MOV DX,offset jump_line
MOV AH,9   
INT 21H 
;set message to request the operating
MOV DX,offset m2
MOV AH,9   
INT 21H
;get the operating

mov bl,10
mov cx,4
mov si,0
while:     
mov ax,n1
mul bx
mov n1,ax 
mov ax,0
mov ax,num1[si]
mov ah,0
add n1,ax
mov ax,n1 

mov ax,n2
mul bx
mov n2,ax 
mov ax,0
mov ax,num2[si]
mov ah,0
add n2,ax
mov ax,n2         
         
inc si
loop while
sign: 
mov cx,4
mov si,3 
mov di,7 
Mov AH,1     
int 21h 
cmp al,27
je endl
cmp al,'+'
je add_ 
cmp al,'-'
je subtract 
cmp al,'&'
je divid 
cmp al,'.'
je multiply 
cmp al,'+'
jne del3                                     
;add funtion
add_: 
mov ax,0
mov al,num1[si]   
add al,num2[si]
mov bl,10
div bl
add string[di],ah
add string[di-1],al  
dec si   
dec di
loop add_
jmp answer
;subtract funtion
subtract:
mov ax,n2
cmp n1,ax
jb negative  
mov ax,0
mov al,num1[si]   
sub al,num2[si]
mov bl,10
div bl
add string[di],ah
add string[di-1],al  
dec si   
dec di
loop subtract
jmp answer
;divid funtion
divid:
mov dx,0
mov ax,n1
cmp ax,n2
jb less
cmp n2,0
je div_by_zero
mov bl,10 
mov si,8 
mov cx,n2 
mov ax,n2
mov index,0
a:
mov n2,ax
mov ax,n2
mul bx
dec si    
cmp n1,ax
jg a 
b:     
mov ax,n1
sub ax,n2
inc index
cmp ax,n2
mov n1,ax
jg b 
mov ax,index
mov string[si],al 
mov ax,n1
cmp ax,n2
jg b     

mov n2,cx
cmp n1,cx
jg divid  
inc string[7]
jmp answer

;multiply funtion
multiply:   
mov bl,10
mov ax,0 
mov al,num1[3]   
mul num2[si]
mov bl,10
div bl 
add string[di],ah
add string[di-1],al
mov al,string[di]
mov ah,0 
div bl     
mov string[di],ah
add string[di-1],al
 
mov al,num1[2]   
mul num2[si]
div bl 
add string[di-1],ah
add string[di-2],al
mov al,string[di-1]
mov ah,0 
div bl     
mov string[di-1],ah
add string[di-2],al

mov al,num1[1]   
mul num2[si]
div bl 
add string[di-2],ah
add string[di-3],al
mov al,string[di-2]
mov ah,0 
div bl     
mov string[di-2],ah
add string[di-3],al 
 
mov al,num1[0]   
mul num2[si]
div bl 
add string[di-3],ah
add string[di-4],al
mov al,string[di-3]
mov ah,0 
div bl     
mov string[di-3],ah
add string[di-4],al 
  
dec si   
dec di
loop multiply
jmp answer
; if divid y zero
div_by_zero:
MOV DX,offset m4
MOV AH,9   
INT 21H
jmp endl
;if substrac a smaller number  
negative:  
MOV DX,offset jump_line
MOV AH,9   
INT 21H
MOV DX,offset m6
MOV AH,9   
INT 21H
jmp endl
;if divided by a smaller number  
less:  
MOV DX,offset jump_line
MOV AH,9   
INT 21H
MOV DX,offset m5
MOV AH,9   
INT 21H
jmp endl 
;set menssage to show the result numeber
answer:
MOV DX,offset jump_line
MOV AH,9   
INT 21H
MOV DX,offset m3
MOV AH,9   
INT 21H 
 
mov cx,8
mov si,0 
;print the char one by one
print: 
 mov  al,string[si]
 add al,30h
 mov dl,al
 mov ah,2
 int 21h  
 inc si
loop print
endl: 
MOV DX,offset jump_line
MOV AH,9   
INT 21H
MOV DX,offset m7
MOV AH,9   
INT 21H

Mov AH,1     
int 21h
cmp al,13  
je begin 
 
ret 
;Declare variable 
index db 0,'$'
n1 dw 0,'$' 
n2 dw 0,'$'
num1 db 4 dup(?),'$'
num2 db 4 dup(?),'$'   
string db 8 dup(?),'$'
m0 dw "type the first number :$" 
m1 dw "type the second number:$"
m2 dw "type + to add ,- to subtract, & divide or . multiply :$"
m3 dw "result : $"                            
m4 dw "divided by zero$"            
m5 dw "divided by a smaller number$" 
m6 dw "substrac by a smaller number$"
m7 dw "continue? ENTER=YES///ANY KEY=NO"
jump_line dw 10,13,'$'

 