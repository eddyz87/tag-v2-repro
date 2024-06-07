#ifndef __VMLINUX_H__
#define __VMLINUX_H__

#define __rcu __attribute__((btf_type_tag("rcu")))

typedef unsigned int __u32;

struct dst_entry;

struct dst_ops {
	struct dst_entry * (*check)(struct dst_entry *, __u32);
};

struct sock {
	struct dst_entry __rcu *sk_rx_dst;
};

struct dst_entry {
	struct dst_ops *ops;
};

#endif /* __VMLINUX_H__ */
