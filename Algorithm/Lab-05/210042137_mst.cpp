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
                cout << char(x + 'A') << " " << char(y + 'A') << " " << w << endl;
            }
        }
        cout << "Minimum Cost: " << ans << "\n";
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
        char x, y;
        int w;
        cin >> x >> y >> w;
        g.addEdge(x - 'A', y - 'A', w);
    }

    g.kruskal_mst();
        
    return 0;
}


/*
Input:
9 15
A B 2
A G 3
A F 7
B C 4
B G 6
G I 1
G H 3
C D 2
C H 2
D H 8
D E 1
H I 4
E I 2
E F 6
I F 5

Output:
D E 1
G I 1
A B 2
C D 2
C H 2
E I 2
A G 3
I F 5
Minimum Cost: 18
*/