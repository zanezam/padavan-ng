PKG_VERSION=1.0.1
SRC_NAME=libnfnetlink-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.bz2
SRC_URL=https://www.netfilter.org/projects/libnfnetlink/files/$(SRC_ARCHIVE)

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
	$(MAKE) -C $(SRC_NAME) install DESTDIR=""

romfs:
