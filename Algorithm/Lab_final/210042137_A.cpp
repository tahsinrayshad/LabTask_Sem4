//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

int main() {

    int n;
    cin >> n;
    vector<int> a(n);
    for(int i = 0; i < n; i++) {
        cin >> a[i];
    }

    int l = 0, r = n - 1;
    while(l < r && a[l] < a[l + 1]) l++;
    while(r > 0 && a[r] > a[r - 1]) r--;

    reverse(a.begin() + l, a.begin() + r + 1);

    if(is_sorted(a.begin(), a.end())) {
        cout << "yes\n" << l + 1 << " " << r + 1;
    } else {
        cout << "no";
    }

    return 0;
}


