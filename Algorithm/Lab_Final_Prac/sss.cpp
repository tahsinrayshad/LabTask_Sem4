//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;


void find_peek_binary(vector<int>& arr){
   int n = arr.size();
   int low = 0, high = n-1;
   while(low <= high){
       int mid = low + (high - low)/2;
       if (mid == 0 || arr[mid] >= arr[mid - 1]) {
           if (mid == n - 1 || arr[mid] >= arr[mid + 1]) {
               cout << arr[mid] << " at index " << mid << endl;
               return;
           }
       }
       if(mid > 0 && arr[mid-1] > arr[mid]){
           high = mid - 1;
       }
       else{
           low = mid + 1;
       }
   }
}

void find_peek(vector<vector<int> > &mat){
  int row = mat.size();
  int col = mat[0].size();
  int low = 0, high = col-1;
  while(low <= high){
      int mid = low + (high - low)/2;
      int mri = 0;
      for(int i=0; i<row; i++){
          if(mat[i][mid] > mat[mri][mid]){
              mri = i;
          }
      }
      if (mid == 0) {
          if (mat[mri][mid] >= mat[mri][mid - 1]) {
              if (mid == col - 1 || mat[mri][mid] >= mat[mri][mid + 1]) {
                  cout << mat[mri][mid] << " at index " << mri << " " << mid << endl;
                  return;
              }
          }
      } else if (mid == col - 1) {
          if (mat[mri][mid] >= mat[mri][mid + 1]) {
              if (mid == 0 || mat[mri][mid] >= mat[mri][mid - 1]) {
                  cout << mat[mri][mid] << " at index " << mri << " " << mid << endl;
                  return;
              }
          }
      } else {
          if (mat[mri][mid] >= mat[mri][mid - 1]) {
              if (mat[mri][mid] >= mat[mri][mid + 1]) {
                  cout << mat[mri][mid] << " at index " << mri << " " << mid << endl;
                  return;
              }
          }
      }
      if(mid > 0 && mat[mri][mid-1] > mat[mri][mid]){
          high = mid - 1;
      }
      else{
          low = mid + 1;
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




    
    return 0;
}