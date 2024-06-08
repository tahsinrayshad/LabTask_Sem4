//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;


int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    string s,t;

    cin >> s >> t;

    ll n = s.length();
    ll m = t.length();

    ll dp[n+1][m+1];

    for(int i=0; i<n; i++){
        for(int j=0; j<m; j++){
            if(s[i]== t[j]){
                dp[i+1][j+1] = 1 + dp[i][j];
            }
            else{
                dp[i+1][j+1] = max(dp[i][j+1], dp[i+1][j]);
            }
        }
    }

    string ans = "";
    int i=n, j=m;

    while(i>0 && j>0){
        if(s[i-1]==t[j-1]){
            ans = s[i-1]+ans;
            i--;
            j--;
        }
        else if(dp[i-1][j] > dp[i][j-1]){
            i--;
        }
        else{
            j--;
        }
    }

    cout << ans;


    
    return 0;
}