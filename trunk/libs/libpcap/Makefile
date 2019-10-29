PKG_VERSION=1.9.1
SRC_NAME=libpcap-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_NAME).tar.gz
SRC_URL=https://www.tcpdump.org/release/$(SRC_ARCHIVE)

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
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_WITH_LIBNL=OFF \
	-DDISABLE_DAG=ON \
	-DDISABLE_DBUS=ON \
	-DDISABLE_NETMAP=ON \
	-DDISABLE_RDMA=ON \
	-DDISABLE_SEPTEL=ON \
	-DDISABLE_SNF=ON \
	-DDISABLE_TC=ON \
	-DBDEBUG=OFF \
	-DYYDEBUG=OFF \
	-DPCAP_SUPPORT_NETFILTER=OFF \
	.. \
	)

clean:
	rm -rf $(SRC_NAME)
	rm -f patching_done
	rm -f config_done

install:
	$(MAKE) -C $(SRC_NAME) install DESTDIR=""

romfs:
	cp -fP $(DESTDIR)/lib/libpcap.so.* $(ROMFSDIR)/lib/
