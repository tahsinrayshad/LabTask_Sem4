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

// Insertion Sort
void insertionsort(vector<int> &arr){
    int n = arr.size();
    for(int i=0; i<n; i++){
        for(int j=i; j>0; j--){
            if(arr[j]<arr[j-1]){
                swap(arr[j], arr[j-1]);
            }
            else{
                break;
            }
        }
    }
}

// Merge Sort
void mergeSort(vector<int> &arr, int left, int right){
    if(left >= right){
        return;
    }
    int mid = (left + right) / 2;
    mergeSort(arr, left, mid);
    mergeSort(arr, mid + 1, right);

    int temp[right - left + 1];
    int i = left, j = mid + 1, k = 0;
    while(i <= mid && j <= right){
        if(arr[i] < arr[j]){
            temp[k++] = arr[i++];
        }
        else{
            temp[k++] = arr[j++];
        }
    }
    while(i <= mid){
        temp[k++] = arr[i++];
    }
    while(j <= right){
        temp[k++] = arr[j++];
    }
    for(int i = left; i <= right; i++){
        arr[i] = temp[i - left];
    }
}
// 


int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    vector<int> array;

    int t;
    cin >> t;
    while(t--){
        int n;
        cin >> n;

        array = randomGen(n);

        clock_t start = clock();
        insertionsort(array);
        // mergeSort(array, 0, n)
        clock_t end = clock();


        double cpu_time_used = ((double) (end - start));
        //printf("for loop took %f seconds to execute \n", cpu_time_used);
        cout << n << " , " << cpu_time_used << endl;

        array.clear();
    }


    
    return 0;
}