#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

typedef void	(*f_ptr)(void);

void	n(void) {
	system("/bin/cat /home/user/level7/.pass");
}

void	m(void) {
	puts("Nope");
}

int		main(int ac, char **av) {
	char	*buff;
	f_ptr	*f;

	buff = malloc(64);
	f = malloc(4);
	*f = m;
	strcpy(buff, av[1]);
	(**f)();	
}
