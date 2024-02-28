//Tahsin Islam - rayshad
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

int mergeAndCount(vector<int>& arr, int l, int m, int r) {
    int inverseCount = 0;

    int n1 = m - l + 1;
    int n2 = r - m;

    vector<int> Left(n1), Right(n2);

    for (int i = 0; i < n1; i++)
        Left[i] = arr[l + i];
    for (int j = 0; j < n2; j++)
        Right[j] = arr[m + 1 + j];

    int i = 0, j = 0, k = l;
    while (i < n1 && j < n2) {
        if (Left[i] <= Right[j]) {
            arr[k] = Left[i];
            i++;
        } else {
            arr[k] = Right[j];
            j++;

            inverseCount += (n1 - i);
        }
        k++;
    }

    while (i < n1) {
        arr[k] = Left[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = Right[j];
        j++;
        k++;
    }

    return inverseCount;
}

int mergeSortAndCount(vector<int>& arr, int l, int r) {
    int invCount = 0;
    if (l < r) {
        int m = l + (r - l) / 2;

        invCount += mergeSortAndCount(arr, l, m);
        invCount += mergeSortAndCount(arr, m + 1, r);
        invCount += mergeAndCount(arr, l, m, r);
    }
    return invCount;
}

int inversion_Count(vector<int>& arr) {
    return mergeSortAndCount(arr, 0, arr.size() - 1);
}

int main() {
    int t;
    cin >> t;

    while (t--) {
        int n;
        cin >> n;

        vector<int> arr(n);
        for (int i = 0; i < n; i++) {
            cin >> arr[i];
        }

        cout << inversion_Count(arr) << endl;
    }

    return 0;
}