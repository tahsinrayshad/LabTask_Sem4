use Social_Media

-- Task 2
db.runCommand({
    collMod: "users",
    validator: {
        $jsonSchema:{
            required : ["name", "password", "email"],
            properties:{
                name:{
                    bsonType: "string",
                    description: "must be a string and is required"
                },
                password:{
                    bsonType: "string",
                    description: "must be a string and is required"
                },
                email:{
                    bsonType: "string",
                    description: "must be a string and is required"
                }
            }
        }
    }
});

-- Task 3

db.runCommand({
    collMod: "posts",
    validator: {
        $jsonSchema:{
            required : ["content"],
            properties:{
                content:{
                    bsonType: "string",
                    description: "must be a string and is required"
                }
            }
        }
    }
});

-- Task 4: Insertion
--(a) An entry of a user with only email, name and password.

db.users.insertOne({
    name: "John Doe",
    email: "doejohn@gmail.com",
    password: "doedoe"
});

--(b) An entry of users with basic info and hobbies (consider a user may have multiple hobbies).

db.users.insertOne({
    name: "Bucky Barns",
    email: "wintersoilder@gmail.com",
    password : "wintersol",
    dob : "19-07-1993",
    address : "Brooklyn",
    hobbies: ["reading", "gaming", "watching movies"]
})

-- (c) Two entries of users with basic info and telephone number (work and personal). [hint:use insertMany]

db.users.insertMany([
    {
        name: "Steve Rogers",
        email: "ca@avengers.com",
        password : "cap",
        dob : "04-07-1918",
        address : "Brooklyn",
        telephone: {
            work: 98512365,
            personal: 95124875
        }

    }
    ,
    {
        name: "Tony Stark",
        email: "ironman@avengers.com",
        password: "jarvis",
        dob: "29-05-1970",
        address: "Manhattan",
        telephone: {
            work: 92169856,
            personal: 93216584
        }
    }
]);

-- (d) Four posts with the content, creation time. [hint: use insertMany]

db.posts.insertMany([
    {
        content: "I am Ironman",
        creation_time: new Date()
    },
    {
        content: "I can do this all day",
        creation_time: new Date()
    },
    {
        content: "I am inevitable",
        creation_time: new Date()
    },
    {
        content: "I am Groot",
        creation_time: new Date()
    }
]);

-- Task 5: Updating
-- (a) Add multiple followers for multiple users.

db.users.updateMany(
    { name: { $in: ["Steve Rogers", "Tony Stark"] } },
    { $set: { followers: ["Takia Farhin", "Tahsin Islam", "Adib Sakhawat", "Antara Arifa", "Farhan Abid", "Niaz Rahman"] } }
);


-- (b) Add multiple friends for multiple users

db.users.updateMany(
    { name: { $in: ["John Doe", "Tony Stark"] } },
    { $set: { friends: ["Bucky Barns", "Steve Rogers"] } }
);

-- (c) Add multiple users who like a post.

db.posts.updateMany(
    { content: { $in: ["I am Ironman", "I am Groot"] } },
    { $set: { likes: ["John Doe", "Tony Stark", "Steve Rogers"] } }
);

-- (d) Add at least two comments for two posts with the commenters.

db.posts.updateMany(
    { $or: [
        { content: "I can do this all day" },
        { content: "I am inevitable" }
       
    ] },
    {
        $set: {
            comments: [
                { comment: "Where is spider-man?", commenter: "John Doe" },
                { comment: "Peace out", commenter: "Tony Stark" },
                { comment: "Life is too good", commenter: "Bucky Barns" }
            ]
        }
    }
);

-- 6. Data Retrieving
-- (a) Display the total number of posts.

db.posts.find().count();

-- (b) Display the most recent to oldest posts along with their poster(s).

db.posts.find().sort({ creation_time: -1 });

-- (c) Show all the posts that were created from yesterday.

db.posts.find({ creation_time: { $gte: new Date(new Date().setDate(new Date().getDate() - 1)) } });

-- (d) Show all the users who are following more than 3 users.

db.users.find({ $where: "followers.length > 3" });

-- (e) Show all the users who were born within 1990-2000.

db.users.find({ dob: { $gte: "01-01-1990", $lte: "31-12-2000" } });

-- (f) Show three profiles that were created the earliest.

db.users.find().sort({ _id: 1 }).limit(3);

-- (g) Show all the posts where commenter "ABC" commented.

db.posts.find({ "comments.commenter": "John Doe" });

-- (h) Show the user’s detail who posted "Life is too good".

db.posts.aggregate([
    { $match: { content: "Life is too good" } },
    {
        $lookup: {
            from: "users",
            localField: "content",
            foreignField: "name",
            as: "user"
        }
    }
]);

-- Task-7: Delete the users who don’t have any work phone number

db.users.deleteMany({ telephone: { $exists: false } })