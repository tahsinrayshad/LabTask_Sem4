//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

int knapsack_01(vector<int>& wt, vector<int>& val, int W){
    int n = wt.size();
    vector<vector<int> > dp(n+1, vector<int>(W+1, 0));
    for(int i=1; i<=n; i++){
        for(int w=1; w<=W; w++){
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
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int n, W;
    cin >> n >> W;

    vector<int> wt(n), val(n);
    for(int i=0; i<n; i++){
        cin >> wt[i];
        cin >> val[i];
    }

    cout << knapsack_01(wt, val, W) << endl;
       
    return 0;
}


// Input:
// 5 10
// 2 2 6 5 4
// 6 3 5 4 6


// Output:
// 15