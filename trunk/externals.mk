ifndef SRC_URL
	$(info "SRC_URL is empty, external sources will be disabled")
	call config_test
endif

.PHONY: prepare_sources
prepare_sources: patch_test
	@echo Sources prepared

.PHONY: dowload_test
dowload_test:
	@if [ ! -f "$(SRC_ARCHIVE)" ] ; then \
		echo "Downloading... $(SRC_ARCHIVE)\n" ; \
		wget -t5 --timeout=30 --no-check-certificate -q --show-progress -O "$(SRC_ARCHIVE)" "$(SRC_URL)"; \
	fi
	@echo "Extracting... $(SRC_NAME)\n"
    @pv $(SRC_ARCHIVE) | xzcat | tar -xvpf "$(SRC_ARCHIVE)"

.PHONY: patch_test
patch_test: dowload_test
	( if [ -d "$(SRC_NAME)/../patches" ] ; then \
		cd "$(SRC_NAME)" ; \
		( if [ ! -f ../patching_done ]; then \
			for file in ../patches/*.patch ; do \
				patch -p1 < $$file ; \
			done ; \
			echo "Patching done" && touch ../patching_done ; \
		fi ) \
	fi )
