

main:
		push			ebp
		mov				esp,				ebp
		push			edi
		push			esi

		and				$0xfffffff0,		esp
		sub				$0xa0,				esp					;	Allocation de 160 sur la stack
		jmp				.x11
.x10:															;	Debut de loop 
		nop
.x11:
		mov				0x8049ab0,			ecx					;	set esp+0x8 (3eme arg) = var <service>
		mov				0x8049aac,			edx					;	set esp+0x4 (2eme arg) = var <auth>
		mov				$0x8048810,			eax					;	set esp (1er arg) = "%p, %p \n"
		mov				ecx,				dword[esp+0x8]		;|
		mov				edx,				dword[esp+0x4]		;--	set args
		mov				eax,				dword[esp]			;|
		call			8048410	<printf@plt>					;	printf("%p, %p \n", auth, service);

		mov				0x8049a80,			eax					;	set esp+0x8 (3eme arg) = stdin
		mov				eax,				dword[esp+0x8]		;|
		movl			$0x80,				dword[esp+0x4]		;	set esp+0x4 (2eme arg) = 128
		lea				dword[esp+0x20]		eax					;	set esp (1er arg) = *buff
		mov				eax,				dword[esp]			;|
		call			8048440	<fgets@plt>						;	fgets(buff, 128, stdin);

		test			eax,				eax					;	if buff == NULL)
		je				.x1c8									;		jump .x1c8
																;	else {
		lea				dword[esp+0x20],	eax					;	eax = *buff
		mov				eax,				edx					;	edx = eax (*buff)
		mov				$0x8048819,			eax					;	eax = "auth "
		mov				$0x5,				ecx					;	ecx = 5
		mov				edx,				esi					;	esi = edx (*buff)
		mov				eax,				edi					;	edi	= eax ("auth ")
		repz cmpsb		byte[edi],			byte[esi]			;	strncmp("auth ", *buff, 5)
		seta			dl										;	if (strncmp > 0) => dl = 1 else dl = 0
		setb			al										;	if (strncmp < 0) => al = 1 else dl = 0
		
		mov				edx,				ecx					;	ecx = edx(*buff)
		sub				al,					cl					;	al -= cl
		mov				ecx,				eax					;	eax = ecx
		movsbl			al,					eax					;	eax = al
		test			eax,				eax					;	if (eax != 0)
		jne				.xde									;		jump .xde
																;	else
		movl			$0x4,				dword[esp]			;	set esp (1er arg) = 4
		call			8048470	<malloc@plt>					;	<auth> = malloc(4)		
		mov				eax,				0x8049aac			;|

		mov				0x8049aac,			eax					;	*auth = 0
		movl			$0x0,				dword[eax]			;|
		lea				dword[esp+0x20],	eax					;	eax = buff + 5
		add				$0x5,				eax					;|
		movl			$0xffffffff,		dword[esp+0x1c]		;	esp+0x1c = 0xffffffff 
	
		mov				eax,				edx					;	edx = eax (buff + 5)
		mov				$0x0,				eax					;	eax = 0
		mov				dword[esp+0x1c],	ecx					;	ecx = esp+0x1c (0xffffffff) <- max int
		mov				edx,				edi					;	edi = edx (buff + 5)
		repnz scas		byte[edi],			al					;	strlen(buff + 5);

		mov				ecx,				eax					;	eax = ecx (0xffffffff - len)
		not				eax										;	reverse eax to get len
		sub				$0x1,				eax					;	eax -= 1
		cmp				$0x1e,				eax					;	if (strlen(buff + 5) > 30)
		ja				.xde									;		jump .xde
																;	else
		lea				dword[esp+0x20],	eax					;	set esp+0x4 (2eme arg) = buff + 5
		lea				dword[eax+0x5],		edx					;|
		mov				0x8049aac,			eax					;	set esp (1er arg) = <auth>
		mov				edx,				dword[esp+0x4]		;|
		mov				eax,				dword[esp]			;|
		call			8048460	<strcpy@plt>					;	strcpy(auth, buff+5);
.xde:
		lea				dword[esp+0x20],	eax					;	
		mov				eax,				edx					;
		mov				$0x804881f,			eax					;
		mov				$0x5,				ecx					;
		mov				edx,				esi					;
		mov				eax,				edi					;
		repz cmpsb		byte[edi],			byte[esi]			;	strncmp("reset", buff, 5)
		seta			dl										;	if (strncmp > 0) => dl = 1 else dl = 0
		setb			al										;	if (strncmp < 0) => al = 1 else dl = 0
		
		mov				edx,				ecx					;
		sub				al,					cl					;
		mov				ecx,				eax					;
		movsbl			al,					eax					;
		test			eax,				eax					;	if (strncmp)
		jne				.x114									;		jump .x114
																;	else
		mov				0x8049aac,			eax					;
		mov				eax,				dword[esp]			;
		call			8048420	<free@plt>						;	free(auth)
.x114:
		lea				dword[esp+0x20],	eax					;
		mov				eax,				edx					;
		mov				$0x8048825,			eax					;
		mov				$0x6,				ecx					;
		mov				edx,				esi					;
		mov				eax,				edi					;
		repz cmpsb		byte[edi],			byte[esi]			;	strncmp("service", buff, 6)
		seta			dl										;	if (strncmp > 0) => dl = 1 else dl = 0
		setb			al										;	if (strncmp < 0) => al = 1 else dl = 0

		mov				edx,				ecx					;
		sub				al,					cl					;
		mov				ecx,				eax					;
		movsbl			al,					eax					;
		test			eax,				eax					;	if (strncmp)
		jne				.x151									;		jump .x151
																;	else
		lea				dword[esp+0x20],	eax					;
		add				$0x7,				eax					;
		mov				eax,				dword[esp]			;
		call			8048430	<strdup@plt>					;
		mov				eax,				0x8049ab0			;	service = strdup(buff+7)
.x151:
		lea				dword[esp+0x20],	eax					;
		mov				eax,				edx					;
		mov				$0x804882d,			eax					;
		mov				$0x5,				ecx					;
		mov				edx,				esi					;
		mov				eax,				edi					;
		repz cmpsb		byte[edi],			byte[esi]			;	strncmp("login", buff, 5)
		seta			dl										;	if (strncmp > 0) => dl = 1 else dl = 0
		setb			al										;	if (strncmp < 0) => al = 1 else dl = 0

		mov				edx,				ecx					;
		sub				al,					cl					;
		mov				ecx,				eax					;
		movsbl			al,					eax					;
		test			eax,				eax					;	if (strncmp)
		jne				.x10									;		jump .x10
																;	else
		mov				0x8049aac,			eax					;	
		mov				dword[eax+0x20],	eax					;	auth = buff
		test			eax,				eax					;	if (auth[32] == 0)
		je				.x19b									;		jump .x19b
																;	else
		movl			$0x8048833,			dword[esp]			;
		call			8048480	<system@plt>					;	system("/bin/sh")
		jmp				8048574	.x10							;	jump .x10
.x19b:
		mov				0x8049aa0,			eax					;
		mov				eax,				edx					;
		mov				$0x804883b,			eax					;
		mov				edx,				dword[esp+0xc]		;
		movl			$0xa,				dword[esp+0x8]		;
		movl			$0x1,				dword[esp+0x4]		;
		mov				eax,				dword[esp]			;
		call			8048450	<fwrite@plt>					;	fwrite("Password:\n", 1, 10, stdout)

		jmp				.x10									;	jump .x10
.x1c8:
		nop														;
		mov				$0x0,				eax					;
		lea				dword[ebp-0x8],		esp					;
		pop				esi										;
		pop				edi										;
		pop				ebp										;
		ret														;	return 0
