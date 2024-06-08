//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

int main() {
    // // Redirect input from input.txt
    // ifstream in("../input.txt");
    // cin.rdbuf(in.rdbuf());

    // // Redirect output to output.txt
    // ofstream out("../output.txt");
    // cout.rdbuf(out.rdbuf());

    ll t;
    cin >> t;
    while(t--){

        ll N;
        cin >> N;
        vector<ll> P(N), W(N);
        for(ll i=0; i<N; i++){
            cin >> P[i] >> W[i];
        }

        ll G;
        cin >> G;

        vector<ll> MW(G);
        for(ll i=0; i<G; i++){
            cin >> MW[i];
        }

        vector<ll> dp(31,0);
        for(ll i=0; i<N; i++){
            for(ll j=30; j>=W[i]; j--){
                dp[j] = max(dp[j], dp[j-W[i]] + P[i]);
            }
        }

        ll total = 0;
        for(ll i=0; i<G; i++){
            total += dp[MW[i]];
        }
        cout << total << endl;
        
    }




    
    return 0;
}