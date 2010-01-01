# Collatz Beta 1

.text

# Main

# Read an integer
li   $v0, 5
syscall
move $a0, $v0
jal  collatz

# Output the steps needed
move $a0, $v0
li   $v0, 1
syscall

# Terminate
li   $v0, 10
syscall


# Collatz-Funktion - iterativ
# Eingabe: $a0 ein Ganzzahl
# Ausgabe: $v0 Anzahl der Rekursionsschritte, bis es 
#              auf das Ergebnis 1 zu kommen.
collatz:
li  $v0, 0						# initialize count to 0
collatz_loop:
ble $a0, 1, collatz_end			# if n < 1 goto end
	addi $v0, $v0, 1			# count++
	remu $t0, $a0, 2
	# collatz_if
	bnez $t0, collatz_else		# if n is even
		srl  $a0, $a0, 1		# n = n / 2
		j    collatz_loop
	collatz_else:				# else
		sll  $t0, $a0, 1
		add  $t0, $t0, $a0
		addi $a0, $t0, 1		# n = 3 * n + 1
	j collatz_loop

collatz_end:
	jr $ra
