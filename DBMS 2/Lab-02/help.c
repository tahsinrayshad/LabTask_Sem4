#include<stdio.h>
#include<math.h>

int main(){
    int n;
    printf("Enter the number of terms: ");
    scanf("%d", &n);
    long sum = 0;

    for(int i=0; i<n; i++){
        sum = sum + pow(pow(2,i),2);
    }

    printf("The sum of the series to %d is: %ld", n, sum);
    return 0;

}