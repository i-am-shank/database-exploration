// 1. Write query using $group with a null grouping key, how can we find the average rating across all documents?
db.hotels.aggregate([
    {
        $match: {
            $and: [
                {
                    RATING: {
                        $exists: true,
                    },
                },
                {
                    RATING: { $ne: null },
                },
            ],
        },
    },
    {
        $group: {
            _id: null,
            avgRating: { $avg: "$RATING" },
        },
    },
]);

// 2. Write query to group documents by the RATING to see how many hotels have the same rating?
db.hotels.aggregate([
    {
        $group: {
            _id: "$RATING",
            countHotels: { $sum: 1 },
        },
    },
]);

// 3. Write query to group documents by RATING and use $push to gather all ADDRESSes of hotels for each rating level?]
db.hotels.aggregate([
    {
        $group: {
            _id: "$RATING",
            hotelAddresses: { $push: "$ADDRESS" },
        },
    },
]);

// 4. Write query to group documents by RATING and include all details of the hotels (entire documents) using $$ROOT?
db.hotels.aggregate([
    {
        $group: {
            _id: "$RATING",
            hotels: { $push: "$$ROOT" },
        },
    },
]);

// 5. Write query to group hotels by their RATING and count the number of hotels at each rating level?
db.hotels.aggregate([
    {
        $group: {
            _id: "$RATING",
            hotelCount: { $sum: 1 },
        },
    },
]);

// 6. Write query to find the maximum, minimum, and average FINAL_COST of hotels grouped by CATEGORY?
db.hotels.aggregate([
    {
        $group: {
            _id: "$CATEGORY",
            maxCost: { $max: "$FINAL_COST" },
            minCost: { $min: "$FINAL_COST" },
            avgCost: { $avg: "$FINAL_COST" },
        },
    },
]);

// 7. Write query to group hotels by RATING and calculate the maximum, minimum, and average BASE_COST for each rating level?
db.hotels.aggregate([
    {
        $group: {
            _id: "$RATING",
            maxCost: { $max: "$BASE_COST" },
            minCost: { $min: "$BASE_COST" },
            avgCost: { $avg: "$BASE_COST" },
        },
    },
]);

// 8. Write query using $project to show only the NAME, ADDRESS, and FINAL_COST of each hotel?
db.hotels.aggregate([
    {
        $project: {
            NAME: 1,
            ADDRESS: 1,
            FINAL_COST: 1,
            _id: 0,
        },
    },
]);

// 9. Write query using $unwind to separate each AMENITYS item into its own document for further analysis?
db.hotels.aggregate([
    {
        $unwind: "$AMENITYS",
    },
]);

// 10. Write query to add a new field DISCOUNT to each document, showing the difference between BASE_COST and FINAL_COST?
db.hotels.aggregate([
    {
        $addFields: {
            DISCOUNT: { $subtract: ["$FINAL_COST", "$BASE_COST"] },
        },
    },
]);
