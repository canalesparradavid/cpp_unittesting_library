$(V).SILENT:
.ONESHELL:

all: clear dependencies assert

dependencies:
	sudo apt install dos2unix
	sudo apt install tree

	echo "All dependencies installed."

assert:
	echo "Executing test files."

	# Creo un directorio temporal
	mkdir -p test_tmp

	# Formateo el fichero de test a UNIX
	dos2unix test.sh
	sh test.sh

	rm -rf test_tmp/*.o

clear:
	echo "Deleting temporary files."
	rm -rf test_tmp
