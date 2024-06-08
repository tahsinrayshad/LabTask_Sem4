//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

int coin_change(vector<int>& coins, int amount){
    vector<int> dp(amount+1, INT_MAX);
    dp[0] = 0;
    for(int i=1; i<=amount; i++){
        for(int j=0; j<coins.size(); j++){
            if(coins[j] <= i){
                dp[i] = min(dp[i], dp[i-coins[j]] + 1);
            }
        }
    }
    return dp[amount] == INT_MAX ? -1 : dp[amount];
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int n, amount;
    cin >> n >> amount;

    vector<int> coins(n); 
    for(int i=0; i<n; i++){
        cin >> coins[i];
    }


    cout << coin_change(coins, amount) << endl;
    return 0;
}


// Input:
// 4 11
// 1 2 5 10

// Output:
// 2