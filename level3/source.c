#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int	m = 0;

void	v(void) {
	char	buff[520];
	int		val;

	fgets(buff, 512, stdin);
	printf(buff);
	if (m == 64) {
		fwrite("Wait what?!\n", 1, 12, stdout);
		system("/bin/sh");
	}
	return ;
}

int		main(void) {
	v();
	return (0);
}
