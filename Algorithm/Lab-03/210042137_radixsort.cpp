//Tahsin Islam - 210042137
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

int getMax(int arr[], int n){
    int max = arr[0];
    for(int i=1; i<n; i++){
        if(arr[i] > max){
            max = arr[i];
        }
    }
    return max;
}

void countSort(int arr[], int n, int exp){
    int copy[n];

    int i, count[10] = {0};
    for(int i=0; i<n; i++){
        count[(arr[i]/exp)%10]++;
    }
    for(int i=1; i<10; i++){
        count[i] += count[i-1];
    }
    for(int i=n-1; i>=0; i--){
        copy[count[(arr[i]/exp)%10]-1] = arr[i];
        count[(arr[i]/exp)%10]--;
    }
    for(int i=0; i<n; i++){
        arr[i]=copy[i];
    }
}

void radixSort(int arr[], int n){
    int max = getMax(arr, n);
    for(int exp=1; max/exp>0; exp*=10){
        countSort(arr, n, exp);
    }
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());
    int n;
    cin >> n;
    int arr[n];

    for(int i=0; i<n; i++){
        cin >> arr[i];
    }
    radixSort(arr, n);
    for(int i=0; i<n; i++){
        cout << arr[i] << " ";
    }
    
    return 0;
}