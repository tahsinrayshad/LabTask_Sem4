//Tahsin Islam - 210042137
//IUT, 2024
typedef long long ll;
#define mod 1000000007
#define inf 1e9

#include <bits/stdc++.h>
using namespace std;

class DSU{
    int *parent;
    int *rank;

public:
    DSU(int n){
        parent = new int[n];
        rank = new int[n];

        for(int i=0; i<n; i++){
            parent[i]= -1;
            rank[i] = 1;
        }
    }

    int find(int i){
        if(parent[i] == -1){
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    void unite(int x, int y){
        int s1 = find(x);
        int s2 = find(y);

        if(s1 != s2){
            if(rank[s1] < rank[s2]){
                parent[s1] = s2;
            }
            else if(rank[s1] > rank[s2]){
                parent[s2] = s1;
            }
            else{
                parent[s2] = s1;
                rank[s1] += 1;
            }
        }
    }
};

class Graph{
    vector<vector<int>> edgelist;
    int V;

public:
    Graph(int V){
        this->V = V;
    }

    void addEdge(int x, int y, int w){
        edgelist.push_back({w, x, y});
    }

    void kruskal_mst(){
        sort(edgelist.begin(), edgelist.end());

        DSU s(V);
        int ans = 0;
        for(auto edge : edgelist){
            int w = edge[0];
            int x = edge[1];
            int y = edge[2];

            // Taking that edge in MST if it doesn't form a cycle
            if(s.find(x) != s.find(y)){
                s.unite(x, y);
                ans += w;
            }
        }

        // Check if all cities are in the same set
        int rep = s.find(0);
        for(int i = 1; i < V; i++){
            if(s.find(i) != rep){
                cout << "IMPOSSIBLE" << endl;
                return;
            }
        }

        cout << ans;
    }
};

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    int v, e;
    cin >> v >> e;

    Graph g(v);
    for(int i=0; i<e; i++){
        int x, y;
        int w;
        cin >> x >> y >> w;
        g.addEdge(x, y, w);
    }

    g.kruskal_mst();
        
    return 0;
}
