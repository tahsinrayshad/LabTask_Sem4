//Tahsin Islam - rayshad
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

// Random Value Generator
vector<int> randomGen(int n){
    vector<int> v;
    for(int i=0; i<n; i++){
        int val = rand()%n;
        v.push_back(val);
    }
    return v;
}

// Peak Finder
int findPeak(vector<int> arr){
    int n= arr.size();
    for(int i=0;i<n;i++){
        if(arr[i]>arr[i-1] && arr[i]>arr[i+1]){
            return arr[i];
        }
    }

    return -1;
}

int dnc(vector<int> arr){
    int l = arr.size();
    int left = 0, right = l-1;

    while(left <= right){
        int mid = (left+right)/2;
        if(arr[mid]>= arr[mid+1] && arr[mid]>= arr[mid-1]){
            return arr[mid];
        }
        else if(arr[mid] < arr[mid - 1]){
            right = mid - 1;
        }
        else{
            left = mid + 1;
        }
    }

    return -1;
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    vector<int> X;
    vector<int> Y;


    int t;
    cin >> t;
    while(t--){
        int n;
        cin >> n;
        // n*=10;
        vector<int> arr = randomGen(n);
        X.push_back(n);
        clock_t start = clock();
        // int x = findPeak(arr);
        int m = dnc(arr);
        clock_t end = clock();

        double cpu_time_used = ((double) (end - start));
        // printf("for loop took %f seconds to execute \n", cpu_time_used);
        Y.push_back(cpu_time_used);
        arr.clear();

        n+=400;
    }

    for(int i=0; i<X.size(); i++){
        cout << X[i] << ", " << Y[i] << endl;
    }

    // cout << endl;

    // for(int i=0; i<Y.size(); i++){
    //     cout << Y[i] << ", ";
    // }

    // cout << x << endl;

    return 0;
}

