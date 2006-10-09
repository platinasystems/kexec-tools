#ifndef IO_H
#define IO_H
#define UNCACHED(x) (void *)((x)|(1UL<<63))
#define MF()	asm volatile ("mf.a" ::: "memory")
#define IO_SPACE_ENCODING(p)     ((((p) >> 2) << 12) | (p & 0xfff))

static inline void *io_addr (unsigned long port)
{
        unsigned long offset;
	unsigned long io_base;
	asm volatile ("mov %0=ar.k0":"=r"(io_base));
	offset = IO_SPACE_ENCODING(port);
        return UNCACHED(io_base | offset);
}

static inline unsigned int inb (unsigned long port)
{
        volatile unsigned char *addr = io_addr(port);
        unsigned char ret;
        ret = *addr;
        MF();
        return ret;
}

static inline unsigned int inw (unsigned long port)
{
        volatile unsigned short *addr = io_addr(port);
        unsigned short ret;

        ret = *addr;
	MF();
        return ret;
}

static inline unsigned int ia64_inl (unsigned long port)
{
        volatile unsigned int *addr = __ia64_mk_io_addr(port);
        unsigned int ret;
        ret = *addr;
	MF();
        return ret;
}

static inline void outb (unsigned char val, unsigned long port)
{
        volatile unsigned char *addr = io_addr(port);

        *addr = val;
	MF();
}

static inline void outw (unsigned short val, unsigned long port)
{
        volatile unsigned short *addr = io_addr(port);

        *addr = val;
	MF();
}

static inline void outl (unsigned int val, unsigned long port)
{
        volatile unsigned int *addr = io_addr(port);

        *addr = val;
	MF();
}


static inline unsigned char readb(const volatile void  *addr)
{
        return *(volatile unsigned char *) addr;
}
static inline unsigned short readw(const volatile void  *addr)
{
        return *(volatile unsigned short *) addr;
}
static inline unsigned int readl(const volatile void  *addr)
{
        return *(volatile unsigned int *) addr;
}

static inline void writeb(unsigned char b, volatile void  *addr)
{
        *(volatile unsigned char *) addr = b;
}
static inline void writew(unsigned short b, volatile void  *addr)
{
        *(volatile unsigned short *) addr = b;
}
static inline void writel(unsigned int b, volatile void  *addr)
{
        *(volatile unsigned int *) addr = b;
}
#endif
