// Tahsin Islam 
// 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

ll knapsack_01(vector<ll>& wt, vector<ll>& val, ll W){
    ll n = wt.size();
    vector<vector<ll> > dp(n+1, vector<ll>(W+1, 0));
    for(ll i=1; i<=n; i++){
        for(ll w=1; w<=W; w++){
            if(wt[i-1] <= w){
                dp[i][w] = max(val[i-1] + dp[i-1][w-wt[i-1]], dp[i-1][w]);
            }
            else{
                dp[i][w] = dp[i-1][w];
            }
        }
    }
    return dp[n][W];
}

int main() {

    ll n, W;
    cin >> n >> W;

    vector<ll> wt(n), val(n);
    for(ll i=0; i<n; i++){
        cin >> wt[i];
        cin >> val[i];
    }

    cout << knapsack_01(wt, val, W);
       
    return 0;
}