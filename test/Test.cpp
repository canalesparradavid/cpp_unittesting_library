#include <iostream>
#include <string>
#include "Test.h"

using namespace std;

#define MSG_COLOR_RED "\x1b[31m"
#define MSG_COLOR_GREEN "\x1b[32m"
#define MSG_COLOR_BLUE "\x1b[34m"
#define MSG_COLOR_RESET "\x1b[0m"

string extractName(string path){
    size_t posicionBarra = path.find('/');

    if (posicionBarra != std::string::npos) {
        std::string resultado = path.substr(posicionBarra + 1);

        return extractName(resultado);
    } else {
        return path;
    }
}

Test::Test(std::string testName){
    // printf(MSG_COLOR_BLUE"%s"MSG_COLOR_RESET"\n", msg);
    name = testName;
    errors = MSG_COLOR_RED;
    passes = 0;
    no_passes = 0;
}

void Test::showResults(){
    //if (no_passes != 0) {
        printf(
            MSG_COLOR_GREEN"(%4d OK    / "
            MSG_COLOR_RED"%4d NO_OK    )"
            MSG_COLOR_RESET" ",
        passes, no_passes);
        std::cout << name << std::endl;

        if (no_passes != 0){
            errors += "\n"MSG_COLOR_RESET;
            std::cout << errors;
        }
    //}
}

void Test::assertAll(){
    execute();
    showResults();
}

void Test::error(int test){
    errors += "\t\t\t\tError in unitary test ";
    errors += std::to_string(test);
    errors += "\n";
    //printf(MSG_COLOR_RED"Error in unitary test %d.\n"MSG_COLOR_RESET, test);
}

void Test::assert(bool (*test)()){
    bool result = test();

    if(result) passes += 1;
    else{
        no_passes += 1;
        error(passes + no_passes);
    }
}