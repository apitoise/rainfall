#define	_GNU_SOURCE
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int		main(int ac, char **av) {
	int		gid, uid, arg;
	char	*exec_arg[2];

	arg = atoi(av[1]);
	if (arg != 423) {
		write(2, "No !\n", 5);
		return 0;
	}
	exec_arg[0] = strdup("/bin/bash");
	exec_arg[1] = NULL;
	gid = getegid();
	uid = geteuid();
	setresgid(gid, gid, gid);
	setresuid(uid, uid, uid);
	execv(exec_arg[0], exec_arg);
	return (0);
}
