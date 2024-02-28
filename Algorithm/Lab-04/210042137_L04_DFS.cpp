//Tahsin Islam - 210042137
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

void dfs(vector<int> adj[], int v, int s){
    bool visited[v];
    for(int i=0; i<v; i++){
        visited[i]=false;
    }
    
    stack<int> st;
    st.push(s);
    visited[s]=true;

    cout << "DFS Traversal: ";
    while(!st.empty()){
        int u = st.top();
        cout << u << ' ';
        st.pop();

        for(int i=0; i<adj[u].size(); i++){
            if(!visited[adj[u][i]]){
                visited[adj[u][i]] = true;
                st.push(adj[u][i]);
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

    int n;
    cin >> n;
    vector<int> adj[n+1];

    while(true){
        int x, y;
        cin >> x >> y;
        if(x==0 && y==0) break;
        adj[x].push_back(y);
        adj[y].push_back(x);
    }
    dfs(adj, n, 1);
    
    return 0;
}

/*
Input:
5
1 2
1 3
2 4
2 5
0 0

Output:
DFS Traversal: 1 3 2 5 4 
*/