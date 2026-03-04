
INCLUDE Irvine32.inc

.data
    databaseName    BYTE "brainrot_database.txt", 0
    filename_copy   BYTE 256 DUP(0)          ; stored filename for LoadFileLine
    line_buffer     BYTE 1024 DUP(0)         ; holds one line (null‑terminated)
    file_buffer     BYTE 4096 DUP(0)         ; temporary read buffer

    ; variables used by LoadFileLine
    target_line     DWORD ?                   ; requested line number
    current_line    DWORD ?                   ; line counter while reading
    is_copying      BYTE ?                     ; flag: 1 = copying target line

    fileHandle       DWORD ?
    bytesRead        DWORD ?

.code

; returns: EAX = random line index (0-based)
GetRandomFileLine PROC
    ; 1. Open the file to count total lines
    INVOKE CreateFile, ADDR databaseName, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0
    mov fileHandle, eax
    cmp eax, INVALID_HANDLE_VALUE
    je  Fail

    mov current_line, 0

    CountLoop:
        INVOKE ReadFile, fileHandle, ADDR file_buffer, 4096, ADDR bytesRead, 0
        cmp bytesRead, 0
        je  EndCount
        mov ecx, bytesRead
        mov esi, OFFSET file_buffer
    
GetRandomFileLine ENDP

main PROC

	mov	eax,val1			; start with 10000h
	add	eax,val2			; add 40000h
	sub	eax,val3			; subtract 20000h
	mov	finalVal,eax		; store the result (30000h)
	call	DumpRegs			; display the registers

	exit
main ENDP

END main