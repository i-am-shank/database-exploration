// 1. Find al products that have a price greater than or equal to $100.
db.products.find({ price: { $gte: 100 } });

// 2. Find products that are not manufactured by "Apple".
db.products.find({ "details.manufacturer": { $ne: "Apple" } });

// 3. Find products that have tags including either "wireless" or "bluetooth".
db.products.find({
    tags: { $in: ["wireless", "bluetooth"] },
});

// 4. Find all products that are both in stock and priced below $50 using logical "and".
db.products.find({
    $and: [{ in_stock: true }, { price: { $lt: 50 } }],
});

// 5. Find products that are either out of stock or have a price greater than $300 using logical "or".
db.products.find({
    $or: [{ in_stock: false }, { price: { $gt: 300 } }],
});

// 6. Find products that have exactly 4 tags.
db.products.find({ tags: { $size: 4 } });

// 7. Count the number of products that are currently in stock.
db.products.find({ in_stock: true }).count();

// 8. Update the price of the "Bluetooth Mouse" to $34.99.
db.products.updateOne({ name: "Bluetooth Mouse" }, { $set: { price: 34.99 } });

// 9. Update all the electronics products and make all of them in stock (Ready for selling).
db.products.updateMany(
    { tags: { $in: ["electronics"] } },
    { $set: { in_stock: true } }
);

// 10. Delete the product with the name "LED Lamp".
db.products.deleteOne({ name: "LED Lamp" });
