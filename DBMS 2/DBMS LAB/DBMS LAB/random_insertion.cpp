#include <iostream>
#include <string>
#include <cstdlib>
#include <ctime>
#include <iomanip>

using namespace std;

// Function to generate random string of given length
string generateRandomString(int length) {
    static const char alphanum[] =
        "0123456789"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "abcdefghijklmnopqrstuvwxyz";

    string result;
    for (int i = 0; i < length; ++i) {
        result += alphanum[rand() % (sizeof(alphanum) - 1)];
    }

    return result;
}

// Function to generate random data for book and insert into table
void generateAndInsertBookData(int numRecords) {
    // Seed for random number generation
    srand(time(0));

    // Generating and inserting random data for the book table
    for (int i = 0; i < numRecords; ++i) {
        long long isbn = rand() % 10000000000LL + 1000000000LL; // Generating 10-digit ISBN
        string name = generateRandomString(10);
        double price = (rand() % 1000) / 10.0; // Generating a price between 0 and 100

        // Assuming publisher_ID is the same as the Publisher table's ID
        int publisher_ID = rand() % numRecords + 1;

        // Inserting data into the book table
        cout << "INSERT INTO book VALUES (" << isbn << ", '" << name << "', " << fixed << setprecision(2) << price << ", " << publisher_ID << ");" << endl;
    }
}

// Function to generate random data for Publisher and insert into table
void generateAndInsertPublisherData(int numRecords) {
    // Seed for random number generation
    srand(time(0));

    // Generating and inserting random data for the Publisher table
    for (int i = 0; i < numRecords; ++i) {
        int ID = i + 1; // Assuming ID starts from 1
        string name = generateRandomString(10);

        // Inserting data into the Publisher table
        cout << "INSERT INTO Publisher VALUES (" << ID << ", '" << name << "');" << endl;
    }
}

int main() {
    // Number of records to generate
    int numRecords = 500;

    // Generate and insert data for the Publisher table
    generateAndInsertPublisherData(numRecords);

    // Generate and insert data for the book table
    generateAndInsertBookData(numRecords);

    return 0;
}
