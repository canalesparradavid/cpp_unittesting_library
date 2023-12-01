#!/bin/sh
# THIS FILE MUST BE FORMATED IN UNIX FORMAT
# IF FORMATED IN DOSS FORMAT IT WILL NOT WORK
# PLEASE USE THE COMMAND dos2unix test.sh TO
# FORMAT IT TO UNIX.

LOG_FILE="test.log"
SRC_DIRECTORY="src"
TEST_DIRECTORY="test"
TEST_TMP_DIRECTORY=$TEST_DIRECTORY"_tmp"

date > $LOG_FILE

# Creo el directorio base de el testeo
mkdir -p $TEST_TMP_DIRECTORY

#Compilo la clase de Test
gcc $TEST_DIRECTORY/Test.cpp -c -o $TEST_TMP_DIRECTORY/Test.o -w

#Compilo los fichero a testear
DEPENDENCIES=$(tree -fi $SRC_DIRECTORY | grep .cpp)
for FILE in $DEPENDENCIES; do
    NAME_NO_EXTENSION=$(echo $FILE | awk -F/ '{print $NF}')
    NAME_NO_EXTENSION=$(echo $NAME_NO_EXTENSION | cut -d '.' -f 1)
    gcc $FILE -c -o $TEST_TMP_DIRECTORY/$NAME_NO_EXTENSION.o -fpermissive -w
done;

# Compilo los test
TESTS=$(tree -fi $TEST_DIRECTORY | grep -E [^/]Test.cpp)
for FILE in $TESTS; do
    NAME_NO_EXTENSION=$(echo $FILE | cut -d '.' -f 1)                       # Quito la extension del fichero
    NAME_NO_EXTENSION=$(echo $NAME_NO_EXTENSION | cut -d '/' -f 2-)         # Quito la primera parte de la ruta
    FILE_PATH=$(echo "/"$NAME_NO_EXTENSION | rev | cut -d '/' -f 2- | rev)  # Almaceno la subruta

    mkdir -p ./$TEST_TMP_DIRECTORY/$FILE_PATH

    if [ $NAME_NO_EXTENSION != 'Test' ]; then                               # Compilo todo menos Test.cpp y Test.h
        g++ $TEST_DIRECTORY/$NAME_NO_EXTENSION.cpp $TEST_TMP_DIRECTORY/*.o -o $TEST_TMP_DIRECTORY/$NAME_NO_EXTENSION -w 2> /dev/null
        if [ $? = '1' ]; then
            echo $COMPILATION_ERRORS"ERROR COMPILANDO EL TEST: "$NAME_NO_EXTENSION >> $LOG_FILE
        fi
        #./$TEST_TMP_DIRECTORY/$NAME_NO_EXTENSION $NAME_NO_EXTENSION >> LOG_FILE 2> /dev/null
    fi
done;

# Ejecuto los test
TESTS=$(tree -fi $TEST_DIRECTORY | grep -E [^/]Test.cpp)
for FILE in $TESTS; do
    NAME_NO_EXTENSION=$(echo $FILE | cut -d '.' -f 1)                       # Quito la extension del fichero
    NAME_NO_EXTENSION=$(echo $NAME_NO_EXTENSION | cut -d '/' -f 2-)         # Quito la primera parte de la ruta
    FILE_PATH=$(echo "/"$NAME_NO_EXTENSION | rev | cut -d '/' -f 2- | rev)  # Almaceno la subruta

    mkdir -p ./$TEST_TMP_DIRECTORY/$FILE_PATH

    if [ $NAME_NO_EXTENSION != 'Test' ]; then                               # Compilo todo menos Test.cpp y Test.h
        ./$TEST_TMP_DIRECTORY/$NAME_NO_EXTENSION $NAME_NO_EXTENSION >> $LOG_FILE 2> /dev/null
    fi
done;

cat $LOG_FILE

rm -rf $TEST_TMP_DIRECTORY
