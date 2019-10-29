PKG_VERSION=1.1.4
SRC_NAME=libtirpc-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.bz2
SRC_URL=https://downloads.sourceforge.net/libtirpc/$(SRC_ARCHIVE)

all: prepare_surces config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)

include $(EXTERNAL_SOURCES)

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( cd $(SRC_NAME) ; \
	./configure \
		--prefix=$(STAGEDIR) \
		--enable-shared \
		--disable-static \
		--disable-gssapi \
		--disable-ipv6 \
		--host=$(HOST_TARGET) \
		--build=$(HOST_BUILD) ; \
	)

clean:
	rm -rf $(SRC_NAME)
	rm -f patching_done
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME) install DESTDIR=""

romfs:
	cp -fP $(DESTDIR)/lib/libtirpc.so* $(ROMFSDIR)/lib
	cp -fP $(DESTDIR)/etc/netconfig $(ROMFSDIR)/etc_ro
