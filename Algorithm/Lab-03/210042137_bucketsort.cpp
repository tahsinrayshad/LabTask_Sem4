//Tahsin Islam - 210042137
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

void heapify(float arr[], int n, int i){
    int largest = i;
    int left = 2*i+1;
    int right = 2*i+2;

    if(left < n && arr[largest] > arr[left]){
        largest = left;
    }

    if(right < n && arr[largest] > arr[right]){
        largest = right;
    }

    if(largest != i){
        swap(arr[i], arr[largest]);
        heapify(arr, n, largest);
    }
}

void heapsort(float arr[], int n){
    for(int i=n/2-1; i>=0; i--){
        heapify(arr, n, i);
    }

    for(int i=n-1; i>0; i--){
        swap(arr[0], arr[i]);
        heapify(arr, i, 0);
    }
}
void bucketsort(float arr[], int n){
    vector<float> b[n];
    for(int i=0; i<n; i++){
        int bi = n*arr[i];
        b[bi].push_back(arr[i]);
    }
    for(int i=0; i<n; i++){
        heapsort(b[i].data(), b[i].size());
    }

    int index = 0;
    for(int i=0; i<n; i++){
        for(int j=0; j<b[i].size(); j++){
            arr[index++] = b[i][j];
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

    float arr[n];
    for(int i=0; i<n; i++){
        cin >> arr[i];
    }

    bucketsort(arr, n);

    cout << "Bucketsort: " << endl;
    for(int i=0; i<n; i++){
        cout << arr[i] << " ";
    }


    
    return 0;
}