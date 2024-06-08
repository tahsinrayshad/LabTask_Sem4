//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

ll max(long long a, long long b) {
    return (a > b) ? a : b;
}

ll cutrod(ll price[],ll n){

    ll val[n+1];
    val[0] = 0;
    ll i, j;

    for(ll i=1; i<=n; i++) {
        ll max_val = INT_MIN;
        for(j=0; j<i; j++) {
            max_val = max(max_val, price[j] + val[i-j-1]);
        }
        val[i] = max_val;
    }

    return val[n];
}

int main() {
    //// Redirect input from input.txt
    //ifstream in("../input.txt");
    //cin.rdbuf(in.rdbuf());

    //// Redirect output to output.txt
    //ofstream out("../output.txt");
    //cout.rdbuf(out.rdbuf());

    ll n;
    cin >> n;

    ll price[n];

    for(ll i=0; i<n; i++){
        cin >> price[i];
    }

    cout << cutrod(price, n);

    return 0;
}