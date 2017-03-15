/*************************************************************************
  > File Name: led.c
  > Author: Chen Wenjie
  > Mail: ChenWenjie@gmail.com 
  > Created Time: 2016年11月09日 星期三 17时03分45秒
 ************************************************************************/

#include <linux/module.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/io.h>		// ioremap() 
#include <asm/uaccess.h>

MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("SSD demo.");
MODULE_SUPPORTED_DEVICE("Zybo");
MODULE_AUTHOR("Wushufan@ECNU");  


#define PHY_GPIO_CHN0_BASE_PTR	0x43C00000    //PHY_BASE_ADDR of SSD 
static int paddr = PHY_GPIO_CHN0_BASE_PTR;
module_param( paddr, int, S_IRUGO );

static void __iomem * gpio_chn0_base_ptr; 
static void __iomem * ssd_mode_addr; 
static void __iomem * ssd_num_addr; 

static int driver_major;


// 
void _set_ssd(int mode, int num)   
{
	printk("_set_ssd()\n"); 

	*(int*)ssd_mode_addr = mode;
	*(int*)ssd_num_addr = num;

	return;
}


static ssize_t ssd_write(struct file * file, const char * buf, size_t count, loff_t *ppos)
{
	int buff[2]={0,0};
	int mode = 0;
	int num = 0;

	printk("ssd_write()\n"); 
	if(!copy_from_user(&buff,buf,sizeof(buff)));
	{
		mode = buff[0];
		num = buff[1];
		printk("mode is %d;num is %d\n",mode,num); 
		_set_ssd(mode,num);	
		_set_ssd(0,0);
	}
	
	
	return 0;
}

static int ssd_open(struct inode * inode, struct file * file)
{
	printk("ssd_open()\n");
	return 0;
}

static int ssd_release(struct inode *inode, struct file *file)
{
	return 0;
}

static struct file_operations ssd_fops = 
{
	.owner=          THIS_MODULE,
	.write=          ssd_write,
	.open=           ssd_open,
	.release=        ssd_release,
};

static int __init led_init(void)
{
//	gpio_chn0_base_ptr = ioremap(PHY_GPIO_CHN0_BASE_PTR, 32);
	gpio_chn0_base_ptr = ioremap(paddr, 32);

	printk("PHYSICAL ADDR=%x. \n", (int)paddr);
	printk("gpio_chn0_base_ptr= 0x%x.\n", (int)gpio_chn0_base_ptr);

	ssd_mode_addr = gpio_chn0_base_ptr;
	ssd_num_addr = ssd_mode_addr + 4;

	driver_major=register_chrdev(0, "SSD", &ssd_fops);
	if (driver_major < 0)
	{
		printk("failed to register device.\n");
		return ENOMEM;
	}

	printk("Init SSD module. major is %d\n",driver_major);
	printk("Use the following command to create a device node:\n");
	printk("mknod /dev/SSD c %d 0\n",driver_major); 
	return 0 ;
}

static void __exit led_exit(void) 
{ 
	unregister_chrdev (driver_major, "SSD");
	printk("Exit SSD module: %d\n",driver_major); 
}

module_init(led_init);
module_exit(led_exit);
