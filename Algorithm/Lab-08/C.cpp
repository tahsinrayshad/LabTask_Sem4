//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

const int MOD = 1e9+7;
const int MX = 1e6+5;

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    vector<ll> dp(MX);
    dp[0] = 1;
    for(ll i = 1; i < MX; i++) {
        for(ll j = 1; j <= 6; j++) {
            if(i-j >= 0) {
                dp[i] = (dp[i] + dp[i-j]) % MOD;
            }
        }
    }
    

    ll n;
    cin >> n;
    cout << dp[n] << endl;

    return 0;
}