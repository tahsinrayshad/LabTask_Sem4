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

    ll n;
    cin >> n;

    char arr[n][n];

    for(ll i=0; i<n; i++){
        for(ll j=0; j<n; j++){
            cin >> arr[i][j];
        }
    }




    
    return 0;
}