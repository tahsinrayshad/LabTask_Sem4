//Tahsin Islam - rayshad
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

vector<int> randomGen(int n){
    vector<int> v; 
    for(int i=0; i<n; i++){
        int x = rand()%n;
        v.push_back(x);
    }

    return v;
}

int oneDPick(vector<int> &arr){
    for(int i=0; i<arr.size(); i++){
        if(arr[i]>arr[i+1] && arr[i]> arr[i-1]){
            return arr[i];
        }
    }
}

void bubblesort(vector<int> &arr){
    int n = arr.size();
    for(int i=0; i<n-1; i++){
        bool anyswap = false;
        for(int j=0; j<n-i-1; j++){
            if(arr[j]>arr[j+1]){
                swap(arr[j], arr[j+1]);
                anyswap = true;
            }
        }
        if(anyswap == false)
            break;
    }
}

void mergesort(vector<int> &arr, int left, int right){
    if(left >= right){
        return;
    }
    int mid = (left + right) / 2;
    mergesort(arr, left, mid);
    mergesort(arr, mid + 1, right);

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

void insertionSort(vector<int> &arr){
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




int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int n;
    cin >> n;
    vector<int> haha;
    haha = randomGen(n);

    for(int i=0; i<n; i++){
        cout << haha[i] << " ";
    }
    cout << endl;

    // mergesort(haha, 0, n-1);
    insertionSort(haha);

    for(int i=0; i<n; i++){
        cout << haha[i] << " ";
    }
    cout << endl;

    // int t;
    // cin >> t;
    // while(t--){
    //     vector<int> haha;

    //     int n;
    //     cin >> n;
    //     haha = randomGen(n);

    //     clock_t start = clock();
    //     bubblesort(haha);
    //     clock_t end = clock();



    //     double cpu_time_used = ((double) (end - start));
    //     // printf("for loop took %f seconds to execute \n", cpu_time_used);
    //     cout << n << " , " << cpu_time_used << endl;

    //     haha.clear();
    // }

    
    return 0;
}