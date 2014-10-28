.PHONY: zip

zip:
	@if [ -z "${RELEASE}" ]; then \
		echo "RELEASE not defined." ; \
		exit 1 ; \
	elif [ -f "unite-codesearch-${RELEASE}.zip" ]; then \
		echo "unite-codesearch-${RELEASE}.zip already exists" ; \
		exit 1; \
	else \
		zip -r unite-codesearch-${RELEASE}.zip autoload doc ; \
	fi
