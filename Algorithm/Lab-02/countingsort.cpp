//Tahsin Islam - rayshad
//IUT, 2024

#include <bits/stdc++.h>
using namespace std;

vector<int> countSort(vector<int>& input)
{
    int n = input.size();
    int m = 0;

    for (int i = 0; i < n; i++)
        m = max(m, input[i]);

    vector<int> count(m + 1, 0);

    for (int i = 0; i < n; i++){
        count[input[i]]++;
    }

    for (int i = 1; i <= m; i++){
        count[i] += count[i - 1];

    }
    vector<int> output(n);

    for (int i = n - 1; i >= 0; i--){
        output[count[input[i]] - 1] = input[i];
        count[input[i]]--;
    }

    return output;
}

int main() {
    // Redirect input from input.txt
    ifstream in("../input.txt");
    cin.rdbuf(in.rdbuf());

    // Redirect output to output.txt
    ofstream out("../output.txt");
    cout.rdbuf(out.rdbuf());

    vector<int> input;
    int n;
    cin >> n;
    for (int i = 0; i < n; i++){
        int x;
        cin >> x;
        input.push_back(x);
    }

    vector<int> output = countSort(input);

    for (int i = 0; i < n; i++){
        cout << output[i] << " ";
    }
        
    return 0;
}