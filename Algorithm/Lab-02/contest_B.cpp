//Tahsin Islam - 210042137
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

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

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int n, k;
    cin >> n >> k;
    vector<int> skills;
    for(int i = 0; i < n; i++) {
        int x;
        cin >> x;
        skills.push_back(x);
    }
    mergeSort(skills, 0, n-1);

    int arr[n+1];
    for(int i=0; i<n+1; i++){
        if(i==k){
            arr[i]= skills[i-1]+1;
        }
    }

    cout << arr[k] << endl;    
    return 0;
}