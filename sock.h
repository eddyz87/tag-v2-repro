#ifndef __VMLINUX_H__
#define __VMLINUX_H__

#define __rcu __attribute__((btf_type_tag("rcu")))

struct foo ;
struct bar { struct foo *foo; };
struct foo { struct bar *bar; };

struct sock {
	struct foo __rcu *foo;
};

#endif /* __VMLINUX_H__ */
