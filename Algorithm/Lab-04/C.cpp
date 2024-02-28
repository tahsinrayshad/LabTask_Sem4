//Tahsin Islam - 210042137
//IUT, 2024

#include <iostream>
#include <vector>

using namespace std;

const int MAX_Num = 30005;

vector<pair<int, int>> graph[MAX_Num];
bool visited[MAX_Num];
int maxDist, farthestNode;

void dfs(int node, int distance) {
    visited[node] = true;

    if (distance > maxDist) {
        maxDist= distance;
        farthestNode = node;
    }

    for (auto neighbor : graph[node]) {
        int nextNode = neighbor.first;
        int edgeWeight = neighbor.second;
        if (!visited[nextNode]) {
            dfs(nextNode, distance + edgeWeight);
        }
    }
}


int main() {
    int T;
    cin >> T;

    for (int caseNumber = 1; caseNumber <= T; ++caseNumber) {
        int n;
        cin >> n;


        for (int i = 0; i < n; ++i) {
            graph[i].clear();
            visited[i] = false;
        }


        for (int i = 1; i < n; ++i) {
            int u, v, w;
            cin >> u >> v >> w;
            graph[u].push_back({v, w});
            graph[v].push_back({u, w});
        }

        maxDist = -1;
        dfs(0, 0);


        for (int i = 0; i < n; ++i) {
            visited[i] = false;
        }
        maxDist = -1;
        dfs(farthestNode, 0);

        cout << "Case " << caseNumber << ": " << maxDist << endl;
    }

    return 0;
}