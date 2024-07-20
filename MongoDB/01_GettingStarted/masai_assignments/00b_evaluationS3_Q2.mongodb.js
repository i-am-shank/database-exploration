// 1. Retrieve the name and price of the product with product_id 101.
db.products.find({ product_id: 101 }, { name: 1, price: 1, _id: 0 });

// 2. List the name and manufacturer of all in-stock products in the electronics category.
db.products.find(
    {
        $and: [{ tags: { $in: ["electronics"] } }, { in_stock: true }],
    },
    { name: 1, "details.manufacturer": 1, _id: 0 }
);

// 3. Find all furniture products and sort them by price in ascending order.
db.products.find({ tags: { $in: ["furniture"] } }).sort({ price: 1 });

// 4. Identify all out-of-stock products and sort them by weight in descending order.
db.products.find({ in_stock: false }).sort({ "details.weight": -1 });

// 5. How many products are offered by each manufacturer? Sort the results by the number of products in descending order.
db.products
    .aggregate([
        {
            $group: {
                _id: "$details.manufacturer",
                countProducts: { $sum: 1 },
            },
        },
    ])
    .sort({ countProducts: -1 });

// 6. Calculate the average price of products for each tag and sort the results by the average price in ascending order.
db.products.aggregate([
    {
        $unwind: "$tags",
    },
    {
        $group: {
            _id: "$tags",
            averagePrice: { $avg: "$price" },
        },
    },
    {
        $sort: { averagePrice: 1 },
    },
]);

// 7. Identify the top 3 manufacturers with the highest number of in-stock products.
db.products.aggregate([
    {
        $match: {
            in_stock: true,
        },
    },
    {
        $group: {
            _id: "$details.manufacturer",
            countProducts: { $sum: 1 },
        },
    },
    {
        $sort: { countProducts: -1 },
    },
    {
        $limit: 3,
    },
]);

// 8. Increase the price of the "Wireless Keyboard" by $5.
db.products.updateMany({ name: "Wireless Keyboard" }, { $inc: { price: 5 } });

// 9. Find manufacturers whose average product price is greater than $100. List the manufacturer names and their average product prices, sorted by average price in descending order.
db.products.aggregate([
    {
        $group: {
            _id: "$details.manufacturer",
            averagePrice: { $avg: "$price" },
        },
    },
    {
        $match: {
            averagePrice: { $gt: 100 },
        },
    },
    {
        $sort: {
            averagePrice: -1,
        },
    },
]);

// 10. Find products in the electronics category, sort them by price in descending order, skip the first 2, limit to the next 3, and display only the product name and price.
db.products.aggregate([
    {
        $match: {
            tags: { $in: ["electronics"] },
        },
    },
    {
        $sort: {
            price: -1,
        },
    },
    {
        $skip: 2,
    },
    {
        $limit: 3,
    },
    {
        $project: {
            name: 1,
            price: 1,
            _id: 0,
        },
    },
]);
