PKG_VERSION=2.9.9
SRC_NAME=libxml2-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.gz
SRC_URL=http://xmlsoft.org/sources/$(SRC_ARCHIVE)

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
		$(if $(CONFIG_IPV6),--enable-ipv6,--disable-ipv6) \
		--without-catalog \
		--without-debug \
		--without-docbook \
		--without-ftp \
		--without-http \
		--without-legacy \
		--without-lzma \
		--without-pattern \
		--without-push \
		--without-python \
		--without-readline \
		--without-regexps \
		--without-iconv \
		--without-iso8859x \
		--with-c14n \
		--with-html \
		--with-output \
		--with-reader \
		--with-sax1 \
		--with-schemas \
		--with-threads \
		--with-tree \
		--with-valid \
		--with-writer \
		--with-xinclude \
		--with-xpath \
		--with-xptr \
		--with-zlib=$(STAGEDIR) \
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
