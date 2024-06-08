//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

ll dp[1000001];

int fibo(int n){
    if(n==0)
        return 0;
    else if(n==1)
        return 1;
    else if (dp[n] != 0)
        return dp[n];
    else
        return dp[n] = fibo(n-1)+fibo(n-2);
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
    cout << fibo(n);
    
    return 0;
}