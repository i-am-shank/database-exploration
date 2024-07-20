db.collection_name.aggregate([
    {
        $unwind: "$cities",
    },
    {
        $match: {
            age: { $gte: 18 },
            isIndian: true,
        },
    },
    {
        $group: {
            _id: "$cities",
            avgAge: { $avg: "$age" },
            // avg, sum, mul, min, max
        },
    },
    {
        $sort: { age: 1 },
        // age: -1
    },
    {
        $project: { name: 1, email: 1, _id: 0 },
    },
]);

/*
$skip : 2
$limit : 3  -->  Top [3 - 5] inclusive

$limit : 5   --> [1 - 5]
$skip : 2   -->  [3 - 5]
*/

/*
{
  "name" , "cities", "age", "email"
  _id
}
*/

// cities: ["delhi", "mumbai", "chennai"]
// cities: "delhi"
// cities: "mumbai",
// cities: "chennai"

db.collection_name.find({
    age: { $gte: 18 },
});
