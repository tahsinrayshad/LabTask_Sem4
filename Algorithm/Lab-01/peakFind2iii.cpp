//Tahsin Islam - rayshad
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

int find2DPeak(vector<vector<int> > arr, int row, int col){
    int left = 0, right = col - 1;
    while(left <= right){
        int mid = (left + right) / 2;
        int maxIndex = 0;
        for(int i = 0; i < row; i++){
            if(arr[i][mid] > arr[maxIndex][mid]){
                maxIndex = i;
            }
        }
        if(arr[maxIndex][mid] >= arr[maxIndex][mid - 1] && arr[maxIndex][mid] >= arr[maxIndex][mid + 1]){
            return arr[maxIndex][mid];
        }
        else if(arr[maxIndex][mid] <= arr[maxIndex][mid - 1]){
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

    int rows, cols;
    cin >> rows >> cols;

    vector<vector<int> > arr(rows, vector<int>(cols));

    // Input the 2D matrix
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            arr[i][j] = i+(2*j);
        }
    }

    clock_t start = clock();
    int result = find2DPeak(arr, rows, cols);
    clock_t end = clock();

    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    cout << "Duration - " << cpu_time_used << endl;
    
    cout << "The 2D peak is: " << result << endl;



    
    return 0;
}