#include<bits/stdc++.h>
using namespace std;

int main() {
    int T;
    cin >> T;
    while(T--) {
        int N;
        cin >> N;
        vector<int> P(N), W(N);
        for(int i = 0; i < N; i++) {
            cin >> P[i] >> W[i];
        }
        int G;
        cin >> G;
        vector<int> MW(G);
        for(int i = 0; i < G; i++) {
            cin >> MW[i];
        }
        vector<int> dp(31, 0);
        for(int i = 0; i < N; i++) {
            for(int j = 30; j >= W[i]; j--) {
                dp[j] = max(dp[j], dp[j-W[i]] + P[i]);
            }
        }
        int total = 0;
        for(int i = 0; i < G; i++) {
            total += dp[MW[i]];
        }
        cout << total << "\n";
    }
    return 0;
}