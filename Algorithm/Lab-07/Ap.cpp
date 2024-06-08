#include<iostream>
#include<bits/stdc++.h>
#include<math.h>

using namespace std;

long long  max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long cutRod(long long price[], long long n) {
   long long val[n+1];
    val[0] = 0;
    long long i, j;

    for(long long i=1; i<=n; i++) {
        long long max_val = INT_MIN;
        for(j=0; j<i; j++) {
            max_val = max(max_val, price[j] + val[i-j-1]);
        }
        val[i] = max_val;
    }

    return val[n];

}

int  main()
{
    long long t;
    cin>>t;
    long long a[t];

    for(long long i=0;i<t;i++ )
    {
        cin>>a[i];
    }

    cout<<cutRod(a,t);
    return 0;
}