typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

string lcs(string s, string t) {
    int m = s.length();
    int n = t.length();
    
    vector<vector<int>> dptable(m + 1, vector<int>(n + 1, 0));

    for (int i = 1; i <= m; ++i) {
        for (int j = 1; j <= n; ++j) {
            if (s[i - 1] == t[j - 1]) {
                dptable[i][j] = dptable[i - 1][j - 1] + 1;
            } else {
                dptable[i][j] = max(dptable[i - 1][j], dptable[i][j - 1]);
            }
        }
    }

    string result = "";
    int i = m, j = n;
    while (i > 0 && j > 0) {
        if (s[i - 1] == t[j - 1]) {
            result = s[i - 1] + result;
            i--;
            j--;
        } else if (dptable[i - 1][j] > dptable[i][j - 1]) {
            i--;
        } else {
            j--;
        }
    }

    return result;
}

int main() {
    // // Redirect input from input.txt
    // ifstream in("../input.txt");
    // cin.rdbuf(in.rdbuf());

    // // Redirect output to output.txt
    // ofstream out("../output.txt");
    // cout.rdbuf(out.rdbuf());

    string s, t;
    cin >> s >> t;

    string ans = lcs(s, t);
    cout << ans << endl;

    return 0;
}
