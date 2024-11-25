BITS 64
DEFAULT REL

section .text
global _start

_start:
   call get_k32
   mov rbx, rax                    
   lea rdx, [rel ll]
   call get_proc
   mov r12, rax                    

   lea rcx, [rel u32]
   sub rsp, 32
   call r12
   add rsp, 32

   mov rbx, rax                    
   lea rdx, [rel mb]
   call get_proc
   
   sub rsp, 40
   xor ecx, ecx                    
   lea rdx, [rel msg]
   lea r8, [rel cap]
   xor r9d, r9d                    
   call rax
   add rsp, 40
   ret

get_k32:
   mov rax, [gs:60h]         
   mov rax, [rax + 18h]      
   mov rax, [rax + 20h]      
   mov rax, [rax]            
   mov rax, [rax]            
   mov rax, [rax + 20h]      
   ret

get_proc:
   push rbp
   mov rbp, rsp
   push rsi
   push rdi
   
   mov eax, [rbx + 3Ch]            
   mov eax, [rbx + rax + 88h]      
   add rax, rbx                    
   push rax
   mov ecx, [rax + 18h]            
   mov r8d, [rax + 20h]            
   add r8, rbx                     

find:
   dec rcx
   mov esi, [r8 + rcx*4]           
   add rsi, rbx                    
   mov rdi, rdx                    
   push rcx
   mov rcx, 12                     
   repe cmpsb
   pop rcx
   jne find

   pop rax                         
   mov r8d, [rax + 24h]           
   add r8, rbx
   mov cx, [r8 + rcx*2]           
   mov r8d, [rax + 1Ch]           
   add r8, rbx
   mov eax, [r8 + rcx*4]          
   add rax, rbx                    

   pop rdi
   pop rsi
   leave
   ret

section .data
   ll db 'LoadLibraryA',0
   mb db 'MessageBoxA',0
   u32 db 'user32.dll',0
   msg db 'Neo, are you there..?',0
   cap db 'Success',0