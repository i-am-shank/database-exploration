// use masai_assignment_db;

// 1. How many hotels have a rating of 4 or higher?
db.hotels.find({ RATING: 4 }).count();

// 2. Retrieve the names and addresses of the first 5 hotels sorted by final cost in ascending order.
db.hotels
    .find({}, { NAME: 1, ADDRESS: 1, _id: 0 })
    .sort({ FINAL_COST: 1 })
    .limit(5);

// 3. How can you skip the first 10 hotels and then retrieve the next 5 hotels when sorted by rating in descending order.
db.hotels.find().sort({ RATING: -1 }).skip(10).limit(5);

// 4. Find the names and ratings of hotels, sorting them in descending order of ratings and limiting the results to 10.
db.hotels
    .find({}, { NAME: 1, RATING: 1, _id: 0 })
    .sort({ RATING: -1 })
    .limit(10);

// 5. Retrieve only the names and addresses of all hotels.
db.hotels.find({}, { NAME: 1, ADDRESS: 1, _id: 0 });

// 6. How do you get the list of amenities and room sizes available in hotels without including their IDs?
db.hotels.find(
    {},
    {
        AMENITYS: 1,
        "ROOM SIZE": 1,
        _id: 0,
    }
);

// 7. Can you display only the final cost and category for all hotels?
db.hotels.find(
    {},
    {
        FINAL_COST: 1,
        CATEGORY: 1,
        _id: 0,
    }
);

// 8. List the names of hotels along with their images.
db.hotels.find(
    {},
    {
        NAME: 1,
        IMAGES: 1,
        _id: 0,
    }
);

// 9. How can you find hotels where the final cost is greater than the base cost by at least 100?
db.hotels.find({
    $expr: { $gte: ["$FINAL_COST", "$BASE_COST" + 100] },
});

// 10. Retrieve hotels where the number of amenities is exactly 3.
db.hotels.find({
    AMENITYS: { $size: 3 },
});

// 11. Find hotels that offer both "WiFi" and "AC" amenities.
db.hotels.find({
    $and: [{ AMENITYS: { $in: ["WiFi"] } }, { AMENITYS: { $in: ["AC"] } }],
});

// 12. Which hotels have either "TV" or "AC" as amenities?
db.hotels.find({
    $or: [{ AMENITYS: { $in: ["TV"] } }, { AMENITYS: { $in: ["AC"] } }],
});

// 13. Match hotels with a rating of 5.
db.hotels.find({
    RATING: 5,
});

// 14. Match hotels located in "Telangana".
db.hotels.find({
    ADDRESS: /Telangana/i,
});

// 15. Limit to the first 3 hotels when retrieving data.
db.hotels.find({}).limit(3);

// 16. How do you limit results to the 2 highest-rated hotels?
db.hotels.find({}).sort({ RATING: -1 }).limit(2);

// 17. Sort hotels by their base cost in descending order.
db.hotels.find({}).sort({ BASE_COST: -1 });

// 18. Sort hotels by name alphabetically.
db.hotels.find({}).sort({ NAME: 1 });

// 19. Skip the top 5 hotels based on rating.
db.hotels.find({}).sort({ RATING: -1 }).skip(5);

// 20. Skip the first 2 hotels when displaying results.
db.hotels.find({}).skip(2);
