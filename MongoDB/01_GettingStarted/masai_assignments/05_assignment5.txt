// 1. Write query to group all documents in the collection without specifying a grouping key, to count the total number of documents?
db.hotels.aggregate([
    {
        $group: { _id: null, count: { $count: {} } },
    },
]);

// 2. Write query to group documents by the CATEGORY field to count the number of hotels in each category?
db.hotels.aggregate([
    {
        $group: { _id: "$CATEGORY", count: { $count: {} } },
    },
]);

// 3. Write query to group hotels by CATEGORY and use $push to create an array of all hotel names within each category?
db.hotels.aggregate([
    {
        $group: {
            _id: "$CATEGORY",
            hotelNames: { $push: "$NAME" },
        },
    },
]);

// 4. Write query to group hotels by CATEGORY and include the entire document for each hotel in the results using $$ROOT?
db.hotels.aggregate([
    {
        $group: {
            _id: "$CATEGORY",
            hotels: { $push: "$$ROOT" },
        },
    },
]);

// 5. Write query to group documents by CATEGORY and count the number of hotels in each category using {$sum: 1}?
db.hotels.aggregate([
    {
        $group: {
            _id: "$CATEGORY",
            numberOfHotels: { $sum: 1 },
        },
    },
]);

// 6. Write query to determine the maximum, minimum, and average room size (assuming room size can be parsed as a number) across all hotels?
db.hotels.aggregate([
    {
        $group: {
            _id: null,
            maxSize: {
                $max: "$ROOM SIZE",
            },
            minSize: { $min: "$ROOM SIZE" },
            avgSize: { $avg: "$ROOMO SIZE" },
        },
    },
]);

// 7. Write query to Grouping by CATEGORY, how can we find the hotel with the highest RATING in each category?
db.hotels.aggregate([
    {
        $group: {
            _id: "$CATEGORY",
            maxRatedHotel: { $max: "$RATING" },
        },
    },
]);

// 8. Write query to use $project to include the NAME, RATING, and a calculation field showing the difference between FINAL_COST and BASE_COST?
db.hotels.aggregate([
    {
        $project: {
            NAME: 1,
            RATING: 1,
            calculation: {
                $subtract: ["$FINAL_COST", "$BASE_COST"],
            },
            _id: 0,
        },
    },
]);

// 9. Write query by Using $unwind, how can we expand the IMAGES array to work with each image URL in separate documents?
db.hotels.aggregate([
    {
        $unwind: "$IMAGES",
    },
    {
        $group: {
            _id: "$IMAGES",
            hotels: { $push: "$$ROOT" },
        },
    },
]);

// 10. Write query to use $addField to add a field in all the document with name "onboardStatus" and value as true.
db.hotels.aggregate([
    {
        $addFields: {
            onboardStatus: true,
        },
    },
]);
