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
	char	*s1[2];
	char	*s2[2];
	FILE	*fd;

	s1[0] = malloc(8);
	*s1[0] = 1;

	s1[1] = malloc(8);

	s2[0] = malloc(8);
	*s2[0] = 2;

	s2[1] = malloc(8);

	strcpy(s1[1], av[1]);
	strcpy(s2[3], av[2]);
	fd = fopen("/home/user/level8/.pass", "r");
	fgets(c, 68, fd);
	puts("~~");
	return (0);
}
