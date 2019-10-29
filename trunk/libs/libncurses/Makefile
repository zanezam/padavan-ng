PKG_VERSION=6.1
SRC_NAME=ncurses-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.gz
SRC_URL=https://invisible-mirror.net/archives/ncurses/$(SRC_ARCHIVE)

all: prepare_sources config_test
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
		--without-ada \
		--without-progs \
		--without-tests \
		--without-manpages \
		--without-debug \
		--without-profile \
		--with-pkg-config-libdir="$(STAGEDIR)/lib/pkgconfig/" \
		--with-shared \
		--with-normal \
		--enable-overwrite \
		--enable-pc-files \
		--enable-widec \
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
	cp -fP $(DESTDIR)/lib/libncursesw.so* $(ROMFSDIR)/lib
