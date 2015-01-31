include $(PQ_FACTORY)/factory.mk

pq_part_name := zlib-1.2.8
pq_part_file := $(pq_part_name).tar.gz

pq_zlib_configuration_flags += --prefix=$(part_dir)

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install prefix=$(part_dir)
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure $(pq_zlib_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
