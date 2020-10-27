dir:
	mv *.txt *.dta *.do $(lab)

clean:
	find . -type f -name '*.DS_STORE' -exec rm -rf {} \;
	find . -type f -name '*.pyc' -exec rm -rf {} \;
	find . -type f -name '__pycache__' -delete;