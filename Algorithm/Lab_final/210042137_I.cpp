#include <bits/stdc++.h>
using namespace std;

vector<int> adj[100001];
bool visited[100001];
vector<int> components;

void dfs(int node) {
    visited[node] = true;
    for(int child : adj[node]) {
        if(!visited[child]) {
            dfs(child);
        }
    }
}

int main() {

    int n, m;
    cin >> n >> m;

    for(int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        adj[a].push_back(b);
        adj[b].push_back(a);
    }

    for(int i = 1; i <= n; i++) {
        if(!visited[i]) {
            components.push_back(i);
            dfs(i);
        }
    }

    cout << components.size() - 1 << "\n";
    for(int i = 0; i < components.size() - 1; i++) {
        cout << components[i] << " " << components[i+1] << "\n";
    }

    return 0;
}