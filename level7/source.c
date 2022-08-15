#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

char	*c = NULL;

void	m(void) {
	printf("%s - %d\n", c, (int)time(0));
}

int		main(int ac, char **av) {
	char	*str[4];
	FILE	*fd;

	str[0] = malloc(8);
	*str[0] = 1;

	str[1] = malloc(8);

	str[2] = malloc(8);
	*str[2] = 2;

	str[3] = malloc(8);

	strcpy(str[1], av[1]);
	strcpy(str[3], av[2]);
	fd = fopen("/home/user/level8/.pass", "r");
	fgets(c, 68, fd);
	puts("~~");
}
