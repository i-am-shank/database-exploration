// 1. Employee and Department Information :
// Write a MongoDB query to join the Employees collection with the Departments collection to display each employee's name, age, and corresponding department names.
db.employees.aggregate([
    {
        $lookup: {
            from: "departments",
            localField: "department_id",
            foreignField: "_id",
            as: "department",
        },
    },
    {
        $unwind: "$department",
    },
    {
        $addFields: {
            dept_name: "$department.name",
        },
    },
    {
        $project: {
            name: 1,
            dept_name: 1,
            _id: 0,
        },
    },
]);

// 2. Employee Projects Overview :
// Create a query to list all employees with their names and a list of project names they are working on, excluding all other details about the projects.
db.employees.aggregate([
    {
        $lookup: {
            from: "projects",
            localField: "projects",
            foreignField: "_id",
            as: "projects",
        },
    },
    {
        $unwind: "$projects",
    },
    {
        $addFields: {
            project_name: "$projects.name",
        },
    },
    {
        $project: {
            name: 1,
            project_name: 1,
            // _id: 0,
        },
    },
    {
        $group: {
            _id: "$_id",
            projects: { $push: "$project_name" },
            name: {
                $addToSet: "$name",
            },
        },
    },
    {
        $unwind: "$name",
    },
    {
        $project: {
            _id: 0,
            name: 1,
            projects: 1,
        },
    },
]);

// 3. Office Location of Employees :
// Formulate a query to retrieve a list of all employees, including their names, salaries, and the address of their office, without including office IDs in the result.
db.employees.aggregate([
    {
        $lookup: {
            from: "offices",
            localField: "office_id",
            foreignField: "_id",
            as: "office",
        },
    },
    {
        $unwind: "$office",
    },
    {
        $addFields: {
            office_address: "$office.address",
        },
    },
    {
        $project: {
            name: 1,
            salary: 1,
            office_address: 1,
            _id: 0,
        },
    },
]);

// 4. Top Department by Employee Count :
// Write a query to determine which department has the most employees, displaying only the department's name and the number of employees.
db.employees.aggregate([
    {
        $group: {
            _id: "$department_id",
            num_employees: { $sum: 1 },
        },
    },
    {
        $lookup: {
            from: "departments",
            localField: "_id",
            foreignField: "_id",
            as: "department",
        },
    },
    {
        $unwind: "$department",
    },
    {
        $addFields: {
            dept_name: "$department.name",
        },
    },
    {
        $project: {
            dept_name: 1,
            num_employees: 1,
            _id: 0,
        },
    },
]);

// 5. Highest Sales by Employee :
// Create a query to find the employee who has made the highest total sales amount, displaying the employee's name and the total sales amount.
db.employees.aggregate([
    {
        $lookup: {
            from: "sales",
            localField: "_id",
            foreignField: "employee_id",
            as: "sale",
        },
    },
    {
        $unwind: "$sale",
    },
    {
        $addFields: {
            sale_amount: "$sale.amount",
        },
    },
    {
        $group: {
            _id: "_id",
            total_sale_amount: { $sum: "$sale_amount" },
            name: { $push: "$name" },
        },
    },
    {
        $unwind: "$name",
    },
    {
        $project: {
            name: 1,
            total_sale_amount: 1,
            _id: 0,
        },
    },
    {
        $sort: {
            total_sale_amount: -1,
        },
    },
    {
        $limit: 1,
    },
]);
