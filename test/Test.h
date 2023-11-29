#include <stdio.h>
#include <iostream>
#include <string>

using namespace std;

class Test{
    public:
        string name;
        string errors;
        int passes;
        int no_passes;

    private:
        void showResults();
        void error(int test);

    protected:
        void assert(bool (*test)());
        virtual void execute() = 0;

    public:
        Test(std::string name);
        void assertAll();
};
