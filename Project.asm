.386
.model flat, stdcall
.stack 4096
INCLUDE Irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD

.data
; Define variables to store train information
trainName BYTE 50 DUP(?)
departure BYTE 50 DUP(?)
destination BYTE 50 DUP(?)
fare DWORD ?
seats DWORD ?

; Msg declarations
msgWelcome BYTE "WELCOME TO Railways", 0
msgPin BYTE "Enter your pin to continue: ", 0
msgMainMenu BYTE "PRESS 1 for User and 2 for ADMIN: ", 0
msgTrainName BYTE "Enter train name: ", 0
msgDeparture BYTE "Enter departure: ", 0
msgDestination BYTE "Enter destination: ", 0
msgFare BYTE "Enter fare: ", 0
msgSeats BYTE "Enter seats: ", 0
msgInvalidChoice BYTE "Invalid choice. Please try again.", 0
msgPinInvalid BYTE "Invalid pin. Access denied.", 0
msgRunAgain BYTE "Do you want to run the program again? (1 for yes, 0 for no): ", 0
msgBookSeats BYTE "Enter the number of seats you want to book: ", 0
msgBookingSuccess BYTE "Booking successful!", 0
msgBookingFail BYTE "Booking failed. Not enough seats available.", 0
msgfare1 Byte "Fare :",0
msgSeat1 Byte "Seats :",0
msgDis Byte "Distination :",0
msgDep Byte "Departure :",0
msgName Byte "Name :",0
.code
main PROC
again:
call clrscr
     mov edx, offset msgWelcome
    call WriteString
    call Crlf
    mov edx, offset msgPin
    call WriteString
    call Crlf
    call ReadInt
    cmp eax, 5
    jne pin_error

    mov edx, offset msgMainMenu
    call WriteString 
    call Crlf
    call ReadInt
    cmp eax, 1
    je user
    cmp eax, 2
    je admin
    jmp invalid_choice

user:
    ; Display available train data
    call crlf
    mov edx,offset msgname
        call WriteString
    mov edx, offset trainName
    call WriteString
    call Crlf

    mov edx, offset msgdep
    call WriteString
    mov edx, offset departure
    call WriteString
    call Crlf

    mov edx, offset msgdis
    call WriteString
    mov edx, offset destination
    call WriteString
    call Crlf


    mov edx, offset msgfare1
    call WriteString
    mov eax, fare
    call WriteDec

        call Crlf
    mov edx, offset msgseat1
    call WriteString
    mov eax, seats
    call WriteDec
    call Crlf

    ; Ask the user which train they want to book
    call crlf
    mov edx, offset msgBookSeats
    call WriteString
    call Crlf
    call ReadInt

    ; Check if enough seats are available and update the train data
    mov ebx, seats
    cmp eax, ebx
    jg booking_failed

    sub seats, eax

    ; Display booking success message
    call crlf
    mov edx, offset msgBookingSuccess
    call WriteString
    call Crlf
    jmp done

booking_failed:
    ; Display booking failed message
    mov edx, offset msgBookingFail
    call WriteString
    call Crlf
    jmp done

admin:
    mov edx, offset msgTrainName
    call WriteString
    call Crlf
    mov edx,offset trainName
      mov edx,offset trainName
    mov ecx,sizeof trainName
    call ReadString
    call crlf
    mov edx, offset msgFare
    call WriteString
    call Crlf
    call ReadInt
    mov fare, eax
    call crlf
    mov edx, offset msgDeparture
    call WriteString
      call Crlf
    mov edx,offset departure
    mov ecx,sizeof departure
    call readString
    call crlf

    mov edx, offset msgSeats
    call WriteString
    call Crlf
    call ReadInt
    mov seats, eax
    call crlf
    mov edx, offset msgDestination
    call WriteString
    call Crlf
    mov edx,offset destination
    mov ecx,sizeof destination
    call ReadString

    call crlf



    jmp done

pin_error:
    mov edx, offset msgPinInvalid
    call WriteString
    call Crlf
    jmp done

invalid_choice:
    mov edx, offset msgInvalidChoice
    call WriteString
    call Crlf
    jmp again

done:
    call Crlf
    mov edx, offset msgRunAgain
    call WriteString
    call Crlf
    call ReadInt
    cmp eax, 1
    je again

    INVOKE ExitProcess, 0
main ENDP

END main
