#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

char	*service;
char	*auth;

int		main(void) {
	char	*buff;
	
	while (42) {
		printf("%p, %p \n", auth, service);
		fgets(buff, 128, stdin);
		if (buff == NULL)
			return (0);
		if (!strncmp("auth ", buff, 5)) {
			auth = malloc(4);
			*auth = 0;
			if ((strlen(buff + 5)) <= 30)
				strcpy(auth, buff + 5);
		}
		if (!strncmp("reset", buff, 5))
			free(auth);
		if (!strncmp("service", buff, 6))
			service = strdup(buff + 7);
		if (!strncmp("login", buff, 5)) {
			if (auth[32] == 0)
				fwrite("Password:\n", 1, 10, stdout);
			else
				system("/bin/sh");
		}
	}
	return (0);
}
