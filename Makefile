CFLAGS=-g -mllvm -btf-type-tag-v2
PFLAGS=-J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust

default: stage2.o count-sock

stage1.o: stage1.c vmlinux.h
	bear -- clang $(CFLAGS) -c $< -o $@
	pahole $(PFLAGS) $@

stage2.o: stage2.c stage1.o vmlinux.h
	bear -- clang $(CFLAGS) -c $< -o $@
	pahole $(PFLAGS) --btf_base stage1.o $@

count-sock: stage1.o stage2.o
	bpftool btf dump file -B stage1.o stage2.o format c \
		| grep "struct sock[a-z0-9_]* {"

clean:
	rm -f stage1.o stage2.o

.PHONY: default count-sock
