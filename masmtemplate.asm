TITLE Homework 6              (David Tu_Homework 6_Visual Studio 2013_ver2.asm)

; Program which uses INVOKE to pass multiple arguments for hashing
; Hashing prodecure uses bit shift for it's algorithm
; David Tu
; Creation Date: 4/17/2016
; Revisions: Version 2
; Date: 4/17/2016
; Modified By: 4/19/2016

INCLUDE Irvine32.inc
FindHash PROTO,						;PROTO is required for INVOKE
	ptrString: PTR DWORD,			;Offset of the given string
	stringLength: DWORD				;Size of the given string
table_size = 11						;Modify to update Hash Table size, if needed

.data
msg BYTE " Hash Value= ", 0
str1 BYTE "Herman Smith", 0
str2 BYTE "Louie Jones", 0
str3 BYTE "Robert Sherman", 0
str4 BYTE "Barbara Goldenstein", 0
str5 BYTE "Johnny Unitas", 0
str6 BYTE "Tyler Abrams", 0
str7 BYTE "April Perkins", 0
str8 BYTE "William Jones", 0
str9 BYTE "Steve Schockley", 0
str10 BYTE "Steve Williams", 0

.code
main PROC
	mov eax, 0						;Initialize eax, ebx and edx
	mov ebx, 0
	mov edx, 0						;Prepares for 16 bit div

	invoke FindHash, OFFSET str1, LENGTHOF str1
	invoke FindHash, OFFSET str2, LENGTHOF str2
	invoke FindHash, OFFSET str3, LENGTHOF str3
	invoke FindHash, OFFSET str4, LENGTHOF str4
	invoke FindHash, OFFSET str5, LENGTHOF str5
	invoke FindHash, OFFSET str6, LENGTHOF str6
	invoke FindHash, OFFSET str7, LENGTHOF str7
	invoke FindHash, OFFSET str8, LENGTHOF str8
	invoke FindHash, OFFSET str9, LENGTHOF str9
	invoke FindHash, OFFSET str10, LENGTHOF str10

	call DumpRegs
	call WaitMsg
	exit
main ENDP
;-----------------------------------------------------------------------------------
FindHash PROC ptrString: PTR DWORD, stringLength: DWORD
;
; Displays the string and hash index.
; Calculation of hash index: rotate sum left 23 bits, 
; then add the ASCII char to the sum. Repeat for every char
;-----------------------------------------------------------------------------------
	push eax						;Store initialization for future computation
	push ebx
	push edx
	mov esi, ptrString				;Points to the first element of the string
	mov ecx, stringLength			;Initialize the counter
L1:
	mov al, [esi]					;Display the char
	call WriteChar
	rol ebx, 23						;Bits will not be lost, 23 is a prime number
	add ebx, eax					;Add ASCII chars
	add esi, 1						;Go to next element
loop L1

	mov eax, ebx					;dividend
	mov bx, table_size				;divisor
	div bx							;remainder is in dx

	mov eax, edx					;WriteDec setup
	mov edx, OFFSET msg				;WriteString setup
	call WriteString
	call WriteDec
	call Crlf
	
	pop edx							;initializes all 3
	pop ebx
	pop eax
	ret
FindHash ENDP
END main