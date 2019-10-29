PKG_VERSION=autoconf-3300100
SRC_NAME=sqlite-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.gz
SRC_URL=https://www.sqlite.org/2019/$(SRC_ARCHIVE)

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
		--disable-readline \
		--disable-dependency-tracking \
		--disable-dynamic-extensions \
		--disable-fts3 \
		--disable-fts4 \
		--disable-fts5 \
		--disable-json1 \
		--disable-rtree \
		--disable-session \
		--disable-debug \
		--disable-static-shell \
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
	cp -fP $(DESTDIR)/lib/libsqlite3.so* $(ROMFSDIR)/lib ;
endif

