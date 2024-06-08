//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

// Time complexity: O(n^3)
int MSS(int arr[], int n){
    int ans = INT_MIN;
    for(int sas=1; sas <=n; ++sas){
        for(int si=0; si<n; ++si){
            if(si+sas>n){
                break;
            }
            int sum=0;
            for(int i=si; i<si+sas; ++i){
                sum+=arr[i];
            }
            ans = max(ans, sum);
        }
    }
    return ans;
}

// Time complexity: O(n^2)
int MSS2(int arr[], int n){
    int ans = INT_MIN;
    for(int si=0; si<n; ++si){
        int sum=0;
        for(int sas=1; sas <=n; ++sas){
            if(si+sas>n){
                break;
            }
            sum+=arr[si+sas-1];
            ans = max(ans, sum);
        }
    }
    return ans;
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int n;
    cin>>n;
    int arr[n];
    for(int i=0; i<n; ++i){
        cin>>arr[i];
    }
    clock_t start = clock();
    int ans = MSS(arr, n);
    clock_t end = clock();
    double cpu_time_used = ((double) (end - start));
    //printf("for loop took %f seconds to execute \n", cpu_time_used);
    cout << ans << " , " << cpu_time_used << endl;
    


    
    return 0;
}








// //Adib Sakhawat - sakhadib
// //IUT, 2024
// typedef long long ll;
// ll inf = 1e9;
// ll neg_inf = -1e9;
// #define mod 1000000007

// #include <bits/stdc++.h>
// using namespace std;

// ll Max(ll a, ll b){
//     return (a > b) ? a : b; 
// }

// ll Max(ll a, ll b, ll c){
//     return Max(Max(a, b), c);
// }


// ll MCS(vector<ll>&arr, ll l, ll mid, ll r){
//     ll sum = 0;
//     ll left_sum = INT_MIN;

//     for(ll i = mid; i>=l; i--){
//         sum = sum + arr[i];
//         if(sum > left_sum){
//             left_sum = sum;
//         }
//     }


//     sum = 0;
//     ll right_sum = INT_MIN;

//     for(ll i = mid; i<= r; i++){
//         sum = sum + arr[i];
//         if(sum > right_sum){
//             right_sum = sum;
//         }
//     }

//     return Max((left_sum + right_sum - arr[mid]), left_sum, right_sum);
// }

// ll MSAS(vector<ll>& arr, ll l, ll r){
//     if(l > r){
//         return INT_MIN;
//     }

//     if(l == r){
//         return arr[l];
//     }

//     ll mid = (l+r)/2;

//     return Max(MSAS(arr, l, mid-1), MSAS(arr, mid+1, r), MCS(arr, l, mid, r));
// }

