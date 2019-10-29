PKG_VERSION=7.66.0
SRC_NAME=curl-$(PKG_VERSION)
SRC_ARCHIVE=$(SRC_ARCHIVE).tar.xz
SRC_URL=https://curl.haxx.se/download/$(SRC_ARCHIVE)

THISDIR=$(shell pwd)

LDFLAGS += -Wl,--gc-sections

all: prepare_sources config_test
        $(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)

include ${EXTERNAL_SOURCES}

config_test:
	( if [ -f ./config_done ]; then \
		echo "the same configuration"; \
	else \
        curl https://curl.haxx.se/ca/cacert.pem -o $(THISDIR)/ca-bundle.crt; \
        make configure && touch config_done; \
	fi )

configure:
	( cd $(SRC_NAME) ; \
	PKG_CONFIG_PATH=$(STAGEDIR)/lib/pkgconfig \
	./configure \
		--prefix=$(STAGEDIR) \
		--enable-static \
		--enable-shared \
		--enable-openssl-auto-load-config \
		$(if $(CONFIG_IPV6),--enable-ipv6,--disable-ipv6) \
		--disable-gopher \
		--disable-ldap \
		--disable-ldaps \
		--disable-rt \
		--disable-rtsp \
		--disable-telnet \
		--disable-tftp \
		--disable-smb \
		--disable-smtp \
		--disable-pop3 \
		--disable-imap \
		--disable-sspi \
		--disable-dict \
		--disable-ares \
		--disable-debug \
		--disable-curldebug \
		--disable-manual \
		--disable-verbose \
		--disable-tls-srp \
		--disable-libcurl-option \
		--disable-threaded-resolver \
		--without-brotli \
		--without-gnutls \
		--without-ca-path \
		--without-ca-fallback \
		--without-cyassl \
		--without-darwinssl \
		--without-default-ssl-backend \
		--without-libidn2 \
		--without-libmetalink \
		--without-libpsl \
		--without-librtmp \
		--without-libssh \
		--without-libssh2 \
		--without-krb4 \
		--without-nghttp2 \
		--without-nss \
		--without-mesalink \
		--without-polarssl \
		--without-schannel \
		--without-wolfssl \
		--without-winidn \
		--without-winssl \
		--without-ssl \
		--without-zsh-functions-dir \
		--with-random=/dev/urandom \
		--with-zlib=$(STAGEDIR) \
		--with-mbedtls=$(STAGEDIR) \
		--with-ca-bundle=$(THISDIR)/ca-bundle.crt \
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
ifeq ($(CONFIG_FIRMWARE_INCLUDE_CURL),y)
        $(ROMFSINST) -d $(DESTDIR)/bin/curl /usr/bin/curl
endif
        cp -fP $(DESTDIR)/lib/libcurl.so* $(ROMFSDIR)/lib
