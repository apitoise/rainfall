#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

void		p(void) {
	char	buff[76];
	void	*return_addr;

	fflush(stdout);
	gets(buff);
	return_addr = __builtin_return_address(0);
	if ((unsigned int)return_addr & 0xb0000000  == 0xb0000000) {
		printf("(%p)\n", return_addr);
		exit(1);
	}
	puts(buff);
	strdup(buff);
}

int		main(void) {
	p();
	return (0);
}
