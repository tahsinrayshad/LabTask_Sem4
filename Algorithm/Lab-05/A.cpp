//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

int main() {
    // // Redirect input from input.txt
    // ifstream in("../input.txt");
    // cin.rdbuf(in.rdbuf());

    // // Redirect output to output.txt
    // ofstream out("../output.txt");
    // cout.rdbuf(out.rdbuf());


    int n, m;
    cin >> n >> m;

    vector<vector<int>> adj(n+1);
    vector<int> indegree(n+1, 0);
    for(int i = 0; i < m; i++) {
        int x, y;
        cin >> x >> y;
        adj[x].push_back(y);
        indegree[y]++;
    }

    priority_queue<int, vector<int>, greater<int>> pq;
    for(int i = 1; i <= n; i++) {
        if(indegree[i] == 0) {
            pq.push(i);
        }
    }

    vector<int> result;
    while(!pq.empty()) {
        int u = pq.top();
        pq.pop();
        result.push_back(u);

        for(int v : adj[u]) {
            indegree[v]--;
            if(indegree[v] == 0) {
                pq.push(v);
            }
        }
    }

    if(result.size() != n) {
        cout << "Sandro fails.";
    } else {
        for(int i = 0; i < n; i++) {
            cout << result[i] << " ";
        }
    }
    
    return 0;
}