#ifndef KEXEC_IA64_H
#define KEXEC_IA64_H

#define MAX_MEMORY_RANGES 1024

int elf_ia64_probe(const char *buf, off_t len);
int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
	struct kexec_info *info);
void elf_ia64_usage(void);
#define MAX_MEMORY_RANGES 1024
#define EFI_PAGE_SIZE	  (1UL<<12)
#define ELF_PAGE_SIZE	  (1UL<<16)
#endif /* KEXEC_IA64_H */
