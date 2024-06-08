//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
ll inf = 1e9;
ll neg_inf = -1e9;
#define mod 1000000007

#include <bits/stdc++.h>
using namespace std;

ll Max(ll a, ll b){
    return (a > b) ? a : b; 
}

ll Max(ll a, ll b, ll c){
    return Max(Max(a, b), c);
}


ll CS(vector<ll>&arr, ll l, ll mid, ll r){
    ll sum = 0;
    ll left_sum = INT_MIN;

    for(ll i = mid; i>=l; i--){
        sum = sum + arr[i];
        if(sum > left_sum){
            left_sum = sum;
        }
    }


    sum = 0;
    ll right_sum = INT_MIN;

    for(ll i = mid; i<= r; i++){
        sum = sum + arr[i];
        if(sum > right_sum){
            right_sum = sum;
        }
    }

    return Max((left_sum + right_sum - arr[mid]), left_sum, right_sum);
}

ll MSS(vector<ll>& arr, ll l, ll r){
    if(l > r){
        return INT_MIN;
    }

    if(l == r){
        return arr[l];
    }

    ll mid = (l+r)/2;

    return Max(MSS(arr, l, mid-1), MSS(arr, mid+1, r), CS(arr, l, mid, r));
}

ll MSEQ(vector<ll>& arr, ll n){
    bool is_neg = false;
    ll sum = 0;
    for(ll i=0; i<n; i++){
        if(arr[i] > 0){
            sum += arr[i];
        }
        else{
            is_neg = true;
        }
    }

    if(sum > 0){
        return sum;
    }
    else{
        ll max = arr[0];
        for(ll i=1; i<n; i++){
            if(arr[i] > max){
                max = arr[i];
            }
        }

        return max;
    }
}


int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    ll t;
    cin >> t;

    while(t--){
        ll n;
        cin >> n;

        vector<ll> arr(n);

        for(ll i=0; i<n; i++){
            cin >> arr[i];
        }

        ll max_seq = MSEQ(arr, n);
        ll max_sum = MSS(arr, 0, n-1);
        

        cout << max_sum << " " << max_seq << endl;
    }

    


    
    return 0;
}