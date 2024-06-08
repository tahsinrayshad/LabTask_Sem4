//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

ll fibo(ll n){
    if(n == 0) return 0;
    if(n == 1) return 1;
    return fibo(n-1) + fibo(n-2);
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    ll t;
    cin >> t;
        ll n;
        cin >> n;
        cout << fibo(n) << endl;        
    }



    
    return 0;
}