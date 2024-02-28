//Tahsin Islam - rayshad
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

void bubblesort(vector<int> &arr){
    int length = arr.size();
    for(int i=0; i<length; i++){
        for(int j=0; j<length-i-1; j++){
            if(arr[j]>arr[j+1]){
                swap(arr[j], arr[j+1]);
            }
        }
    }
}

void insertionsort(vector<int> &arr){
    int l = arr.size();
    for(int i=0; i<l; i++){
        for(int j=i; j>0; j--){
            if(arr[j]<arr[j-1]){
                swap(arr[j], arr[j-1]);
            }
        }
    }
}

void mergesort(vector<int> &arr, int left, int right){
    if(left >= right){
        return;
    }

    int mid = (left+right)/2;
    mergesort(arr, left, mid);
    mergesort(arr, mid+1, right);

    int temp[right-left+1];
    int i=left, j=mid+1, k=0;

    while(i<=mid && j<=right){
        if(arr[i]< arr[j]){
            temp[k++]=arr[i++];
        }
        else{
            temp[k++]=arr[j++];
        }
    }

    while(i<=mid){
        temp[k++]=arr[i++];
    }

    while(j<=right){
        temp[k++]=arr[j++];
    }

    for(int i=left; i<=right; i++){
        arr[i]= temp[i-left];
    }

}

void heapify(int arr[], int n, int i){
    int largest = i;
    int l = 2*i + 1;
    int r = 2*i + 2;

    if(l < n && arr[l] > arr[largest]){
        largest = l;
    }

    if(r < n && arr[r] > arr[largest]){
        largest = r;
    }

    if(largest != i){
        swap(arr[i], arr[largest]);
        heapify(arr, n, largest);
    }
}

void heapSort(int arr[], int n){
    for(int i = n/2 - 1; i >= 0; i--){
        heapify(arr, n, i);
    }

    for(int i = n-1; i >= 0; i--){
        swap(arr[0], arr[i]);
        heapify(arr, i, 0);
    }
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    vector<int> arr;
    int a[10];

    int n;
    cin >> n;
    for(int i=0; i<n; i++){
        int x;
        cin >> x;
        // arr.push_back(x);
        a[i]=x;
    }
    // bubblesort(arr);
    // insertionsort(arr);
    // mergesort(arr, 0, n-1);
    heapSort(a, n);
    cout << "Heap Sort" << endl;
    for(int i=0; i<n; i++){
        cout << a[i] << " ";
    }


    
    return 0;
}