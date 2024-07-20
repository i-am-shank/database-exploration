// 1. Identify all unique product tags and the total number of products associated with each tag, but only include tags associated with more than 3 products. Project only the tag name and the count of products.
db.products.aggregate([
    {
        $unwind: "$tags",
    },
    {
        $group: {
            _id: "$tags",
            productCount: { $sum: 1 },
        },
    },
    {
        $match: {
            productCount: { $gt: 3 },
        },
    },
    {
        $project: {
            _id: 1,
            productCount: 1,
        },
    },
]);

// 2. For each manufacturer, find the total number of different tags their products belong to. Include only manufacturers with products in more than 2 different tags. Project the manufacturer name and the number of different tags.
db.products.aggregate([
    {
        $unwind: "$tags",
    },
    {
        $group: {
            _id: "$details.manufacturer",
            uniqueTags: { $addToSet: "$tags" },
        },
    },
    {
        $project: {
            _id: 1,
            tagCount: { $size: "$uniqueTags" },
        },
    },
    {
        $match: {
            tagCount: { $gt: 2 },
        },
    },
]);

// 3. Determine the top 5 most frequently occuring tags for in-stock products and their occurence counts, sorted by occurence count in descending order.
db.products.aggregate([
    {
        $unwind: "$tags",
    },
    {
        $match: {
            in_stock: true,
        },
    },
    {
        $group: {
            _id: "$tags",
            productCount: { $sum: 1 },
        },
    },
    {
        $sort: { productCount: -1 },
    },
    {
        $limit: 5,
    },
]);

// 4. List the top 3 manufacturers based on the number of unique products they have in stock, sorted in descending order.
db.products.aggregate([
    {
        $match: {
            in_stock: true,
        },
    },
    {
        $group: {
            _id: "$details.manufacturer",
            uniqueProducts: { $addToSet: "$product_id" },
        },
    },
    {
        $project: {
            _id: 1,
            productCount: { $size: "$uniqueProducts" },
        },
    },
    {
        $sort: {
            productCount: -1,
        },
    },
    {
        $limit: 3,
    },
]);

// 5. Find the names and prices of the first 3 in-stock electronics products, after skipping the first 2 results, sorted by price in descending order.
db.products.aggregate([
    {
        $match: {
            in_stock: true,
            tags: { $in: ["electronics"] },
        },
    },
    {
        $skip: 2,
    },
    {
        $limit: 3,
    },
    {
        $sort: { price: -1 },
    },
    {
        $project: {
            name: 1,
            price: 1,
            _id: 0,
        },
    },
]);

// 6. Retrieve the names and prices of the 5 most expensive products in the "furniture" category, skipping the first 1 result.
db.products.aggregate([
    {
        $match: {
            tags: { $in: ["furniture"] },
        },
    },
    {
        $project: {
            name: 1,
            price: 1,
        },
    },
    {
        $sort: {
            price: -1,
        },
    },
    {
        $skip: 1,
    },
    {
        $limit: 5,
    },
]);

// 7. Determine the total sales value of all in-stock products grouped by category(tags), and include a field for the average price per category. Sort the results by total sales value in descending order.
db.products.aggregate([
    {
        $unwind: "$tags",
    },
    {
        $match: {
            in_stock: true,
        },
    },
    {
        $group: {
            _id: "$tags",
            salesValue: { $sum: "$price" },
            countProduct: { $sum: 1 },
        },
    },
    {
        $project: {
            _id: 1,
            salesValue: 1,
            averagePrice: { $divide: ["$salesValue", "$countProduct"] },
        },
    },
    {
        $sort: {
            salesValue: -1,
        },
    },
]);

// 8. Calculate the total number of products and the average price of products in each manufacturer group, including only products priced above $50, and sort the results by the total number of products in descending order.
db.products.aggregate([
    {
        $match: {
            price: { $gt: 50 },
        },
    },
    {
        $group: {
            _id: "$details.manufacturer",
            countProduct: { $sum: 1 },
            totalPrice: { $sum: "$price" },
        },
    },
    {
        $project: {
            _id: 1,
            countProduct: 1,
            averagePrice: { $divide: ["$totalPrice", "$countProduct"] },
        },
    },
    {
        $sort: {
            countProduct: -1,
        },
    },
]);

// 9. For each tag, find the top 3 highest-rated products, calculate their average rating, and list the tag, product name, and average rating, sorted by average rating in descending order.

// 10. Identify the top 3 manufacturers with the highest total sales value, considering only in-stock products and products priced above $50. Include the manufacturer name and total sales value in the result, sorted by total sales value in descending order.
db.products.aggregate([
    {
        $match: {
            in_stock: true,
            price: { $gt: 50 },
        },
    },
    {
        $group: {
            _id: "$details.manufacturer",
            salesValue: { $sum: "$price" },
        },
    },
    {
        $sort: {
            salesValue: -1,
        },
    },
    {
        $limit: 3,
    },
]);
