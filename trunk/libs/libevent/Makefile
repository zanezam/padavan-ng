PKG_VERSION=2.1.11-stable
SRC_NAME=libevent-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.gz
SRC_URL=https://github.com/libevent/libevent/releases/download/release-$(PKG_VERSION)/$(SRC_ARCHIVE)

all: prepare_sources config_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

include $(EXTERNAL_SOURCES)

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
		make configure && touch config_done; \
	fi )

configure:
	( mkdir -p $(SRC_NAME)/build && cd $(SRC_NAME)/build ; \
	cmake \
	-DCMAKE_INSTALL_PREFIX=$(STAGEDIR) \
	-DCMAKE_TOOLCHAIN_FILE=../../cross-mipsel-linux.cmake \
	-DEVENT__DISABLE_BENCHMARK:BOOL=ON \
	-DEVENT__DISABLE_DEBUG_MODE:BOOL=ON \
	-DEVENT__DISABLE_REGRESS:BOOL=ON \
	-DEVENT__DISABLE_SAMPLES:BOOL=ON \
	-DEVENT__DISABLE_OPENSSL:BOOL=OFF \
	-DEVENT__DISABLE_THREAD_SUPPORT:BOOL=OFF \
	-DEVENT__DISABLE_TESTS:BOOL=ON \
	-DBUILD_TESTING:BOOL=OFF
	.. \
	)

clean:
    rm -rf $(SRC_NAME)
	rm -f patching_done
    rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME)/build install DESTDIR=""

romfs:
	cp -fP $(DESTDIR)/lib/libevent-2.1.so* $(ROMFSDIR)/lib
