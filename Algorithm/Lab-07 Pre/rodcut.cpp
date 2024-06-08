//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

int cutRod(int price[], int index, int n)
{
    // base case
    if (index == 0) {
        return n * price[0];
    }
    //At any index we have 2 options either
      //cut the rod of this length or not cut 
      //it
    int notCut = cutRod(price,index - 1,n);
    int cut = INT_MIN;
    int rod_length = index + 1;
 
    if (rod_length <= n)
        cut = price[index]
               + cutRod(price,index,n - rod_length);
   
    return max(notCut, cut);
}

int main() {
    // // Redirect input from input.txt
    // ifstream in("../input.txt");
    // cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int arr[] = { 1, 5, 8, 9, 10, 17, 17, 20 };
    int size = sizeof(arr) / sizeof(arr[0]);
    cout << "Maximum Obtainable Value is "<< cutRod(arr, size - 1, size);

    getchar();

    return 0;
}