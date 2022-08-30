#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

void	run(void) {
	fwrite("Good... Wait what?\n", 1, 19, stdout);
	system("/bin/sh");
}

int		main(void) {
	char	buff[76];

	gets(buff);
	return(0);
}
