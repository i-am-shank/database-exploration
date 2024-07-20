show dbs;
show databases;
// both statements  -->  show all dbs in current-cluster (connection string)

// ##################    CREATE    ###################

use("mongosh_practice_db");
// create / switch to a database inside a cluster

db.createCollection("inventory2");
// create a collection (similar to SQL tables) in current db

show collections;
// show collections stored in the current-database (which is in execution context)

db.inventory2.insertOne({"name":"Shashank", "age":25});
// insertOne   -->   insert 1 document

db.inventory2.insertMany([
    {"name":"Aditya", "age":20},
    {"name":"Archa", "age":20},
    {"name":"Bhadra", "age":19}
]);
// insertMany   -->   insert multiple documents




// ##################    READ    ##################

db.getMongo().getDBs();
// Fetch all the databases in current db-cluster

use("mongosh_practice_db");
// switch to any database

db.getCollectionNames();
// get all the collections in current db



// ---------------------------  QUERY  -----------------------------
db.inventory2.find();
// fetch all the documents inside this collection

db.inventory2.find({age:20});
// fetch documents  -->  with matching attribute-values

db.inventory2.find({age : {$in : [19, 25]}});
// fetch documents  -->  with multiple-matching options for an attribute

db.inventory2.find({age : {$lt : 20}});
// fetch documents  -->  value of attribute  <  value

db.inventory2.find({age : {$lte : 20}});
// fetch documents  -->  value of attribute  <=  value

db.inventory2.find({name : {$in: ["Archa", "Bhadra"]} ,  age : {$lte : 19}});
// fetch documents  -->  AND operator  (all conditions fulfilled)
db.inventory2.find({$and: [ {name: {$in: ["Archa","Bhadra"]}, age: {$lte: 19}}]});

db.inventory2.find({$or : [ {name : "Shashank"} , {age : {$lt : 20}}]});
// fetch documents  -->  OR operator  (any of the conditions match)

db.inventory2.findOne({age: {$lte : 20}});
// fetches only 1 document  -->  matching the condition




// ##################    UPDATE    ###################

// update() , updateMany()
// (matching-conditions, updates)

db.inventory2.updateMany(
    {name : {$in : ["Archa", "Bhadra"]}},
    {
        $set : {"college" : "NIT Patna", "interests":["music"]}
    }
);
// updates all the matching entries

db.inventory2.update(
    {name : "Archa"},
    {
        $set : {interests : ["music", "software technologies"]}
    }
);
// update only 1 matching entry (even if multiple entries match)

db.inventory2.replaceOne(
    {name: "Shashank"},
    {
        "name": "Shashank",
        "age": 25,
        "college": "Masai School",
        "interests": [
            "music", "software technologies", "sports"
        ]
    }
);

db.inventory2.replaceOne(
    {name: "Aditya"},
    {
        "name": "Aditya",
        "age": 20,
        "college": "VIT Mumbai",
        "interests": [
            "gaming", "food"
        ]
    }
);
// replaces 1 matching documents

db.inventory2.find();




// ##################    DELETE    ###################

db.inventory2.drop();
// drop the specified collection

