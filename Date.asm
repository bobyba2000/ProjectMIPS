.data
	_day: .space 3
	_month: .space 3
	_year: .space 5
	_zero: .asciiz  "0"
	_slash: .asciiz "/"
	_comma: .asciiz ","
	_space: .asciiz " "
	_time: .asciiz "01/01/2000"
	_temp: .space 30
	_temp1: .space 256
	_AType: .byte 'A'
	_BType: .byte 'B'
	_CType: .byte 'C'
	
	_dayInput: .space 3
	_monthInput: .space 3
	_yearInput: .space 5
	_chooseNumInput: .space 2
	
	_weekday: .word _sun, _mon, _tue, _wed, _thu, _fri, _sat
	
	_mon: .asciiz "Mon"
	_tue: .asciiz "Tues"
	_wed: .asciiz "Wed"
	_thu: .asciiz "Thurs"
	_fri: .asciiz "Fri"
	_sat: .asciiz "Sat"
	_sun: .asciiz "Sun"
	
	_monthName: .word _jan, _feb, _mar, _apr, _may, _jun, _jul, _aug, _sep, _oct, _nov, _dec
	_jan: .asciiz "January"
	_feb: .asciiz "February"
	_mar: .asciiz "March"
	_apr: .asciiz "April"
	_may: .asciiz "May"
	_jun: .asciiz "June"
	_jul: .asciiz "July"
	_aug: .asciiz "August"
	_sep: .asciiz "September"
	_oct: .asciiz "October"
	_nov: .asciiz "November"
	_dec: .asciiz "December"
	
	_monthNum: .byte 0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5
	
	_newline: .asciiz "\n"
	_inputDayCommand: .asciiz "Nhap ngay Day: "
	_inputMonthCommand: .asciiz "Nhap thang Month: "
	_inputYearCommand: .asciiz "Nhap nam Year: "
	
	_commands: .word _startCommand, _command1, _command2, _command3, _command4, _command5, _command6, _endCommand
	
	_startCommand: .asciiz "----------Ban hay chon 1 tron cac thao tac duoi day ----------\n"
	_command1: .asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YY\n"
	_command2: .asciiz "2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n\tA. MM/DD/YYYY \n\tB. Month DD, YYYY\n\tC. DD Month, YYYY\n"
	_command3: .asciiz "3. Cho biet ngay vua nhap la ngay thu may trong tuan:\n"
	_command4: .asciiz "4. Kiem tra nam trong chuoi Time co phai la nam nhuan khong\n"
	_command5: .asciiz "5. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2\n"
	_command6: .asciiz "6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME\n"
	_endCommand: .asciiz "-----------------------------------------------------------------\n"
	_chooseNum: .asciiz "Lua chon: "
	_result: .asciiz "Ket qua: "
	
.text
	.globl main
main:
	la   $a0, _inputDayCommand
	jal  PrintString
	li   $a1, 3
	la   $a0, _dayInput
	li   $v0, 8
	syscall
	add  $t4, $a0, $0
	la   $a0, _newline
	jal  PrintString
	
	la   $a0, _inputMonthCommand
	jal  PrintString
	li   $a1, 3
	la   $a0, _monthInput
	li   $v0, 8
	syscall
	add  $t5, $a0, $0
	la   $a0, _newline
	jal  PrintString
	
	la   $a0, _inputYearCommand
	jal  PrintString
	li   $a1, 5
	la   $a0, _yearInput
	li   $v0, 8
	syscall
	add  $t6, $a0, $0
	la   $a0, _newline
	jal  PrintString
	
	add  $t0, $0, $0
	addi $t1, $0, 8
	la   $t2, _commands
	LoopPrintCommandIn:
		sll  $t3, $t0, 2
		add  $t3, $t3, $t2
		lw   $a0, 0($t3)
		jal  PrintString
		addi $t0, $t0, 1
		beq  $t0, $t1, LoopPrintCommandOut
		j LoopPrintCommandIn
	LoopPrintCommandOut:
	
	la   $a0, _chooseNum
	jal  PrintString
	li   $a1, 2
	la   $a0, _chooseNumInput
	li   $v0, 8
	syscall
	add  $t7, $a0, $0
	la   $a0, _newline
	jal  PrintString
	
	
	la   $a0, _result
	jal  PrintString
	j    end
	
PrintString: #In xau ra man hinh
	li   $v0, 4
	syscall
	jr   $ra
	
ConvertIntToString: #void ConvertIntToString(int num, char* str) #chuyen so num thanh chuoi str
	addi $sp, $sp, -20
	sw   $t0,  0($sp)
	sw   $t1,  4($sp)
	sw   $t2,  8($sp)
	sw   $t3, 12($sp)
	sw   $t4, 16($sp)
	
	addi $t1, $0, 10
	addi $t2, $0, 10
	LoopCountIn:
		div  $a0, $t1
		mflo $t3
		beq  $t3, $0, LoopCountOut
		mult $t1, $t2
		mflo $t1
		j LoopCountIn
	LoopCountOut:
		div $t1, $t2
		mflo $t1
	
	add $t0, $0, $0
	ExtractIntIn:
		sll  $t3, $t0, 0
		add  $t3, $a1, $t3
		
		#luu tung so
		div  $a0, $t1
		mflo $t4
		addi $t4, $t4, 48
		mfhi $a0
		sb   $t4, 0($t3)
		
		div  $t1, $t2
		mflo $t1
		addi $t0, $t0, 1
		beq  $t1, $0, ExtractIntOut
		j ExtractIntIn
	ExtractIntOut:
	
	lw   $t0,  0($sp)
	lw   $t1,  4($sp)
	lw   $t2,  8($sp)
	lw   $t3, 12($sp)
	lw   $t4, 16($sp)
	addi $sp, $sp, 20
	jr   $ra

GetStrLength: #int GetStrLength(char*str) #Xac dinh do dai cua chuoi
	addi $sp, $sp, -8
	sw   $t1, 0($sp)
	sw   $t2, 4($sp)
	
	addi $v0, $0, 0
	LoopCountLengthIn:
		sll  $t1, $v0, 0
		add  $t1, $a0, $t1
		lb   $t2, 0($t1)
		beq  $t2, $0, LoopCountLengthOut
		addi $v0, $v0, 1
		j    LoopCountLengthIn
	LoopCountLengthOut:
	
	lw   $t1, 0($sp)
	lw   $t2, 4($sp)
	addi $sp, $sp, 8
	jr   $ra

stradd: #char* stradd(char*a0, char*a1, char*a2) #Cong chuoi a0 va chuoi a1 va luu vao chuoi a2
	addi $sp, $sp, -20
	sw   $t1, 0($sp)
	sw   $t2, 4($sp)
	sw   $t3, 8($sp)
	sw   $t0, 12($sp)
	sw   $t4, 16($sp)
	
	la   $t4, _temp1
	
	addi $t0, $0, 0
	LoopAddString1In:
		sll  $t1, $t0, 0
		add  $t1, $a0, $t1
		lb   $t2, 0($t1)
		sll  $t1, $t0, 0
		add  $t1, $t4, $t1
		sb   $t2, 0($t1)
		beq  $t2, $0, LoopAddString1Out
		addi $t0, $t0, 1
		j    LoopAddString1In
	LoopAddString1Out:
	
	addi $t3, $0, 0
	LoopAddString2In:
		sll  $t1, $t3, 0
		add  $t1, $a1, $t1
		lb   $t2, 0($t1)
		sll  $t1, $t0, 0
		add  $t1, $t4, $t1
		sb   $t2, 0($t1)
		beq  $t2, $0, LoopAddString2Out
		addi $t0, $t0, 1
		addi $t3, $t3, 1
		j    LoopAddString2In
	LoopAddString2Out:
	
	add  $t3, $0, $0
	LoopAddStringIn:
		sll  $t1, $t3, 0
		add  $t1, $t4, $t1
		lb   $t2, 0($t1)
		sll  $t1, $t3, 0
		add  $t1, $a2, $t1
		sb   $t2, 0($t1)
		beq  $t2, $0, LoopAddStringOut
		addi $t3, $t3, 1
		j    LoopAddStringIn
	LoopAddStringOut:
		
	lw   $t1, 0($sp)
	lw   $t2, 4($sp)
	lw   $t3, 8($sp)
	lw   $t0, 12($sp)
	lw   $t4, 16($sp)
	addi $sp, $sp, 20
	jr   $ra

Padding: #void Padding(char*a0, int num) #Them cac ky tu 0 vao truoc chuoi a0 sao chu du num ky tu
	addi $sp, $sp, -20
	sw   $t0, 0($sp)
	sw   $t1, 4($sp)
	sw   $a1, 8($sp)
	sw   $a2, 12($sp)
	sw   $ra, 16($sp)

	jal  GetStrLength
	add  $t0, $0, $v0
	add  $t1, $a1, $0
	AddPaddingIn:
		beq  $t0, $t1, AddPaddingOut
		add  $a2, $a0, $0
		add  $a1, $a0, $0
		la   $a0, _zero
		jal  stradd
		addi $t0, $t0, 1
		add  $a0, $a2, $0
		j    AddPaddingIn
	AddPaddingOut:
	la   $t0, _temp1
	sb   $0, 0($t0)
	lw   $t0, 0($sp)
	lw   $t1, 4($sp)
	lw   $a1, 8($sp)
	lw   $a2, 12($sp)
	lw   $ra, 16($sp)
	addi $sp, $sp, 20
	jr   $ra
	
Reset:  #char*Reset(char*a0) #dua cac dia chi ve thanh ghi $0
	add  $sp, $sp, -12
	sw   $t0, 0($sp)
	sw   $t1, 4($sp)
	sw   $t2, 8($sp)
	
	add  $t0, $0, $0
	LoopFixStringIn:
		sll  $t1, $t0, 0
		add  $t1, $a0, $t1
		lb   $t2, 0($t1)
		beq  $t2, $0, LoopFixStringOut
		sb   $0, 0($t1)
		addi $t0, $t0, 1
		j    LoopFixStringIn
	LoopFixStringOut:
	add  $v0, $a0, $0
	lw   $t0, 0($sp)
	lw   $t1, 4($sp)
	lw   $t2, 8($sp)
	add  $sp, $sp, 12
	jr   $ra

Date: #char*Date (int day, int month, int year, char*Time)
	addi $sp, $sp, -20
	sw   $a0, 0($sp)
	sw   $a1, 4($sp)
	sw   $a2, 8($sp)
	sw   $a3, 12($sp)
	sw   $ra, 16($sp)
	
	add  $a0, $a3, 0
	jal  Reset
	#Ngay
	lw   $a0, 0($sp)
	la   $a1, _day
	sb   $0, ($a1)
	jal  ConvertIntToString
	add  $a0, $a1, $0
	addi $a1, $0, 2
	jal  Padding
	add  $a1, $a0, $0
	add  $a0, $a3, $0
	add  $a2, $a3, $0
	jal  stradd
	add  $a0, $a2, $0
	la   $a1, _slash
	jal  stradd
	#Thang
	lw   $a0, 4($sp)
	la   $a1, _month
	sb   $0, ($a1)
	jal  ConvertIntToString
	add  $a0, $a1, $0
	addi $a1, $0, 2
	jal  Padding
	add  $a1, $a0, $0
	add  $a0, $a3, $0
	add  $a2, $a3, $0
	jal  stradd
	add  $a0, $a2, $0
	la   $a1, _slash
	jal  stradd
	#Nam
	lw   $a0, 8($sp)
	la   $a1, _year
	sb   $0, ($a1)
	jal  ConvertIntToString
	add  $a0, $a1, $0
	addi $a1, $0, 4
	jal  Padding
	add  $a1, $a0, $0
	add  $a0, $a3, $0
	add  $a2, $a3, $0
	jal  stradd
	add  $t0, $a0, $0
	
	la   $a0, _day
	jal  Reset
	la   $a0, _month
	jal  Reset
	la   $a0, _year
	jal  Reset
		
	add  $a0, $t0, $0
	add  $v0, $t0, $0
	lw   $a0, 0($sp)
	lw   $a1, 4($sp)
	lw   $a2, 8($sp)
	lw   $a3, 12($sp)
	lw   $ra, 16($sp)
	add  $sp, $sp, 20
	jr   $ra
	
Day: 
	add  $v0, $0, 8
	jr   $ra
Month:
	add  $v0, $0, 7
	jr   $ra
Year:
	add  $v0, $0, 2003
	jr   $ra
	
GetMonthName: #char*GetMonthName(int month) #tra ve ten cua thang do
	addi $sp, $sp, -8
	sw   $t0, 0($sp)
	sw   $t1, 4($sp)
	la   $t0, _monthName
	addi $t1, $a0, -1
	sll  $t1, $t1, 2
	add  $t0, $t0, $t1
	lw   $t0, 0($t0)
	add  $v0, $t0, $0
	lw   $t0, 0($sp)
	lw   $t1, 4($sp)
	addi $sp, $sp, 8
	jr   $ra	

Convert: #char*Convert(char*Time, char Type)
	addi $sp, $sp, -36
	sw   $a0, 0($sp)
	sw   $a1, 4($sp)
	sw   $a2, 8($sp)
	sw   $a3, 12($sp)
	sw   $t0, 16($sp)
	sw   $t1, 20($sp)
	sw   $t2, 24($sp)
	sw   $t3, 28($sp)
	sw   $ra, 32($sp)
	#Lay ngay
	lw   $a0, 0($sp)
	jal  Day
	add  $t0, $v0, $0
	#Lay thang
	lw   $a0, 0($sp)
	jal  Month
	add  $t1, $v0, $0
	#Lay nam
	lw   $a0, 0($sp)
	jal  Year
	add  $t2, $v0, $0
	
	add  $a3, $a0, $0
	sb   $0, 0($a0)
	#Xac dinh kieu dinh dang muon chuyen
	la   $t3, _CType
	lb   $t3, 0($t3)
	beq  $a1, $t3, CType
	la   $t3, _BType
	lb   $t3, 0($t3)
	beq  $a1, $t3, BType
	AType:
		#Thang
		add  $a0, $t1, $0
		la   $a1, _month
		sb   $0, ($a1)
		jal  ConvertIntToString
		add  $a0, $a1, $0
		addi $a1, $0, 2
		jal  Padding
		add  $a1, $a0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $a0, $a2, $0
		la   $a1, _slash
		jal  stradd
		#Ngay
		add  $a0, $t0, $0
		la   $a1, _day
		sb   $0, ($a1)
		jal  ConvertIntToString
		add  $a0, $a1, $0
		addi $a1, $0, 2
		jal  Padding
		add  $a1, $a0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $a0, $a2, $0
		la   $a1, _slash
		jal  stradd
		#Nam
		add  $a0, $t2, $0
		la   $a1, _year
		sb   $0, ($a1)
		jal  ConvertIntToString
		add  $a0, $a1, $0
		addi $a1, $0, 4
		jal  Padding
		add  $a1, $a0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $v0, $a0, $0
		j    endConvert
	BType:
		#Thang
		add  $a0, $t1, $0
		jal  GetMonthName
		add  $a1, $v0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $a0, $a2, $0
		la   $a1, _space
		jal  stradd
		#Ngay
		add  $a0, $t0, $0
		la   $a1, _day
		sb   $0, ($a1)
		jal  ConvertIntToString
		add  $a0, $a1, $0
		addi $a1, $0, 2
		jal  Padding
		add  $a1, $a0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $a0, $a2, $0
		la   $a1, _comma
		jal  stradd
		la   $a1, _space
		jal  stradd
		#Nam
		add  $a0, $t2, $0
		la   $a1, _year
		sb   $0, ($a1)
		jal  ConvertIntToString
		add  $a0, $a1, $0
		addi $a1, $0, 4
		jal  Padding
		add  $a1, $a0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $v0, $a0, $0
		j    endConvert
	CType:	
		#Ngay
		add  $a0, $t0, $0
		la   $a1, _day
		sb   $0, ($a1)
		jal  ConvertIntToString
		add  $a0, $a1, $0
		addi $a1, $0, 2
		jal  Padding
		add  $a1, $a0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $a0, $a2, $0
		la   $a1, _space
		jal  stradd
		#Thang
		add  $a0, $t1, $0
		jal  GetMonthName
		add  $a1, $v0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $a0, $a2, $0
		la   $a1, _comma
		jal  stradd
		la   $a1, _space
		jal  stradd
		#Nam
		add  $a0, $t2, $0
		la   $a1, _year
		sb   $0, ($a1)
		jal  ConvertIntToString
		add  $a0, $a1, $0
		addi $a1, $0, 4
		jal  Padding
		add  $a1, $a0, $0
		add  $a0, $a3, $0
		add  $a2, $a3, $0
		jal  stradd
		add  $v0, $a0, $0
	endConvert:
		add  $t0, $a0, $0
	
		la   $a0, _day
		jal  Reset
		la   $a0, _month
		jal  Reset
		la   $a0, _year
		jal  Reset
		
		add  $a0, $t0, $0
		add  $v0, $t0, $0
		lw   $a1, 4($sp)
		lw   $a2, 8($sp)
		lw   $a3, 12($sp)
		lw   $t0, 16($sp)
		lw   $t1, 20($sp)
		lw   $t2, 24($sp)
		lw   $t3, 28($sp)
		lw   $ra, 32($sp)
		addi $sp, $sp, 36
		jr   $ra

LeapYear: #int LeapYear(char*TIME) #Kiem tra nam nhuan
	addi $v0, $0, 0
	jr   $ra
	
Weekday: #char*Weekday(char*Time) #Xac dinh thu trong tuan
	addi $sp, $sp, -24
	sw   $a0, 0($sp)
	sw   $t0, 4($sp)
	sw   $t1, 8($sp)
	sw   $t2, 12($sp)
	sw   $t3, 16($sp)
	sw   $ra, 20($sp)
	#Lay so hieu cua thang
	lw   $a0, 0($sp)
	jal  Month
	add  $t1, $v0, $0
	addi $t1, $t1, -1
	jal  LeapYear
	la   $t0, _monthNum
	beq  $v0, $0, DefineMonthNum
	addi $t2, $0, 6
	sb   $t2, 0($t0)
	addi $t2, $0, 2
	sb   $t2, 0($t0)
	DefineMonthNum:
		add  $t0, $t0, $t1
		lb   $t1, 0($t0)
	#Lay ngay
	lw   $a0, 0($sp)
	jal  Day
	add  $t0, $v0, $0
	#Lay the ky va 2 so cuoi cua nam
	lw   $a0, 0($sp)
	jal  Year
	add  $t2, $v0, $0
	addi $t3, $0, 100
	div  $t2, $t3
	mfhi $t2
	mflo $t3
	addi $t3, $t3, 1
	#Tinh toan
	add  $t0, $t0, $t1
	add  $t0, $t0, $t2
	add  $t0, $t0, $t3
	addi $t3, $0, 4
	div  $t2, $t3
	mflo $t2
	add  $t0, $t0, $t2
	addi $t3, $0, 7
	div  $t0, $t3
	mfhi $t0
	addi $t0, $t0, -1
	la   $t1, _weekday
	sll  $t0, $t0, 2
	add  $t1, $t1, $t0
	lw   $v0, 0($t1)
	
	lw   $a0, 0($sp)
	lw   $t0, 4($sp)
	lw   $t1, 8($sp)
	lw   $t2, 12($sp)
	lw   $t3, 16($sp)
	lw   $ra, 20($sp)
	addi $sp, $sp, 24
	jr   $ra
	
end:
