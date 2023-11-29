#!/bin/sh
# THIS FILE MUST BE FORMATED IN UNIX FORMAT
# IF FORMATED IN DOSS FORMAT IT WILL NOT WORK
# PLEASE USE THE COMMAND dos2unix test.sh TO
# FORMAT IT TO UNIX.

date > test.log

# Creo el directorio base de el testeo
mkdir -p test_tmp

#Compilo la clase de Test
gcc test/Test.cpp -c -o test_tmp/Test.o -w

#Compilo los fichero a testear
DEPENDENCIES=$(tree -fi src | grep .cpp)
for FILE in $DEPENDENCIES; do
    NAME_NO_EXTENSION=$(echo $FILE | awk -F/ '{print $NF}')
    NAME_NO_EXTENSION=$(echo $NAME_NO_EXTENSION | cut -d '.' -f 1)
    gcc $FILE -c -o test_tmp/$NAME_NO_EXTENSION.o -fpermissive -w
done;

#Compilo los test y los ejecuto
TOTAL_FAILURES=0
FAILED_TESTS=""
TESTS=$(tree -fi test | grep -E [^/]Test.cpp)
for FILE in $TESTS; do
    NAME_NO_EXTENSION=$(echo $FILE | cut -d '.' -f 1)                       # Quito la extension del fichero
    NAME_NO_EXTENSION=$(echo $NAME_NO_EXTENSION | cut -d '/' -f 2-)         # Quito la primera parte de la ruta
    FILE_PATH=$(echo "/"$NAME_NO_EXTENSION | rev | cut -d '/' -f 2- | rev)     # Almaceno la subruta

    mkdir -p ./test_tmp/$FILE_PATH

    if [ $NAME_NO_EXTENSION != 'Test' ]; then
        g++ test/$NAME_NO_EXTENSION.cpp test_tmp/*.o -o test_tmp/$NAME_NO_EXTENSION -w;
        ./test_tmp/$NAME_NO_EXTENSION $NAME_NO_EXTENSION >> test.log;
        FAILURES=$?
        [ $FAILURES -ne 0 ] && FAILED_TESTS="$FAILED_TESTS $NAME_NO_EXTENSION"
        TOTAL_FAILURES=$((FAILURES + $FAILURES))
    fi
done;

cat test.log

rm -rf test_tmp
