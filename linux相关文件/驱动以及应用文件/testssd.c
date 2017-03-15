/*************************************************************************
  > File Name: test.c
  > Author: Chen Wenjie
  > Mail: ChenWenjie@gmail.com 
  > Created Time: 2016年11月09日 星期三 17时07分28秒
 ************************************************************************/

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>   

int main(int argc, char **argv)
{	int fd;
	int ssd_mode = 0;
	int ssd_num = 0;
	
	fd = open("/dev/SSD",O_RDWR);	
	if(fd<0){printf("open /dev/SSD fail.\n");exit(-1);}
	
	if(argc == 3)
	{
		ssd_mode = (int) strtol(argv[2], NULL, 10) + 3;
		if(ssd_mode > 6 || ssd_mode < 4)
			printf("Error:the value of parameters is out of range!\n");
	}
	else if(argc == 4)
	{
		ssd_mode = (int) strtol(argv[2], NULL, 10);
		ssd_num = (int) strtol(argv[3], NULL, 10);
		if(ssd_mode > 3 || ssd_mode < 1 || ssd_num > 99 ||ssd_num < 5)
			printf("Error:the value of parameters is out of range!\n");
	}
    else 
		printf("Error:the number of command parameters is out of range!\n");
	int buff[2]={ssd_mode,ssd_num};
	printf("size of buff is %d\n",sizeof(buff));
	write(fd, &buff, sizeof(buff));
	//~~~~~~~~~~~~~~~~~~~~~~~~~~

	close(fd);		
	return 0;
}
