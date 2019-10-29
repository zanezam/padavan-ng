PKG_VERSION=1.0.23
SRC_NAME=libusb-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.bz2
SRC_URL=https://github.com/libusb/libusb/releases/download/v$(PKG_VERSION)/$(SRC_ARCHIVE)

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
	ac_cv_lib_rt_clock_gettime=no \
	./configure \
		--prefix=$(STAGEDIR) \
		--enable-shared \
		--disable-static \
		--disable-log \
		--disable-udev \
		--disable-timerfd \
		--disable-examples-build \
		--disable-tests-build \
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
	cp -fP $(DESTDIR)/lib/libusb-1.0.so* $(ROMFSDIR)/lib
