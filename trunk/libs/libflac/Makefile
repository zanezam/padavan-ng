PKG_VERSION=1.3.2
SRC_NAME=flac-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.xz
SRC_URL=https://ftp.osuosl.org/pub/xiph/releases/flac/$(SRC_ARCHIVE)

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
		$(if $(LIBS_BUILD_SHARED),--disable-static,--enable-static) \
		$(if $(LIBS_BUILD_SHARED),--enable-shared,--disable-shared) \
		--disable-cpplibs \
		--disable-sse \
		--disable-altivec \
		--disable-local-xmms-plugin \
		--disable-xmms-plugin \
		--disable-ogg \
		--disable-oggtest \
		--disable-debug \
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
ifeq ($(LIBS_BUILD_SHARED),y)
	cp -fP $(DESTDIR)/lib/libFLAC.so* $(ROMFSDIR)/lib
endif
