#include <stdio.h>

int main() {
    while(1) {
        int a = 0;
        int b;
        a++;
        if (a > 0) {
            b = 1 / a;
        }
        else if (a > 100) {
            b = 1 / a * 2;
        }
        else {
            b = 1 / a;
        }
    }
}