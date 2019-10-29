PKG_VERSION=3.2.2
SRC_NAME=confuse-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.xz
SRC_URL=https://github.com/martinh/libconfuse/releases/download/v$(PKG_VERSION)/$(SRC_ARCHIVE)

CFLAGS += -Os

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
		--enable-static \
		--disable-shared \
		--host=$(HOST_TARGET) \
		--build=$(HOST_BUILD) ; \
	)

clean:
        rm -rf $(SRC_NAME)
		rm -f patching_done
        rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME) install DESTDIR="" ;

romfs:
