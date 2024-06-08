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

    ll N, W;
    cin >> N >> W;
    vector<ll> weight(N), value(N);

    for(ll i=0; i<N; i++){
        cin >> weight[i] >> value[i];
    }




    
    return 0;
}