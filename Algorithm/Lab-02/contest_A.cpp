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
    int n;
    cin >> n;
    vector<int> skills;
    for(int i = 0; i < n; i++) {
        int x;
        cin >> x;
        skills.push_back(x);
    }
    mergeSort(skills, 0, n-1);

    int totalProblems = 0;

    for(int i = 0; i < n; i=i+2) {       
        totalProblems += skills[n-i-1] - skills[i];
    }
    cout << totalProblems << endl;

    return 0;
}