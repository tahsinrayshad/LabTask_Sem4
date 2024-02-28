//Tahsin Islam - 210042137
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

void bfs(vector<int> adj[], int v, int s){
    bool visited[v];
    for(int i = 0; i < v; i++){
        visited[i] = false;
    }

    queue<int> q;
    visited[s] = true;
    q.push(s);

    cout << "BFS Traversal: ";
    while(!q.empty()){
        int u = q.front();
        cout << u << " ";
        q.pop();

        for(int i=0; i<adj[u].size(); i++){
            if(!visited[adj[u][i]]){
                visited[adj[u][i]] = true;
                q.push(adj[u][i]);
            }
        }
    }
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int v, e;
    cin >> v >> e;

    vector<int> adj[v];
    for(int i=0; i<e; i++){
        int x, y;
        cin >> x >> y;
        adj[x].push_back(y);
        adj[y].push_back(x);
    }

    bfs(adj, v, 1);
    return 0;
}

/*
Input:
7 7
0 1
0 2
1 3
1 4
2 5
2 6
4 6

Output:
BFS Traversal: 1 0 3 4 2 6 5 

*/