.syntax unified
/*
回傳數值時,是把數字放到r0
*/
.global	read_sp
read_sp:
	mov	r0,sp  //回傳sp
	bx lr

.global	read_msp
read_msp:
	mrs r0,msp //回傳msp
	bx lr
	
.global	read_psp
read_psp:
	mrs r0,psp //回傳psp
	bx lr

.global	read_ctrl
read_ctrl:
	mrs r0,control //回傳control
	bx lr

.global	start_user
start_user:
	mov lr,r0	//把要轉跳的地址（傳入值）存到lr
	msr psp,r1  //存入psp_ini(傳入值)

	mov r0,0b11    //spse(control[1])設1 選擇sp=psp
	msr control,r0 //nPRIV(control[0])設為1 unpriviliged
	//注意,要先msr psp再改control,否則變成unprivilige後,權限不夠使用msr
	isb
	blx lr


	

.global	sw_priv
sw_priv:
	mov r0,0b10
	msr control,r0
	/*
	嘗試在unpriviliged的狀態下 改成priviliged,應該會失敗
	*/
	isb
	bx lr