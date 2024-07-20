// 1. Most Popular Project :
// Formulate a query to find the project with the highest budget by joining the Projects collection with the Departments collection, summarizing the total number of projects per department, and limiting the result to the department with the highest budget project.
db.projects.aggregate([
    {
        $lookup: {
            from: "departments",
            localField: "department",
            foreignField: "_id",
            as: "department",
        },
    },
    {
        $unwind: "$department",
    },
    {
        $group: {
            _id: "$department._id",
            projects: {
                $push: {
                    name: "$name",
                    budget: "$budget",
                },
            },
            project_count: { $sum: 1 },
        },
    },
    {
        $project: {
            _id: 1,
            project_count: 1,
            projects: {
                $sortArray: {
                    input: "$projects",
                    sortBy: {
                        budget: -1,
                    },
                },
            },
            highest_budget_project: {
                $slice: ["$projects", 1],
            },
        },
    },
    {
        $project: {
            _id: 1,
            project_count: 1,
            highest_budget_project: 1,
        },
    },
]);

// 2. Employees in Engineering Department :
// Write a MongoDB query to list all employees working in the "Engineering" department, sorted by their hire date in ascending order.
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
        $match: {
            "department.name": "Engineering",
        },
    },
    {
        $sort: {
            hire_date: 1,
        },
    },
]);

// 3. Finance Department Projects :
// Create a query to list all projects in the "Finance" department, sorted by budget in descending order.
db.projects.aggregate([
    {
        $lookup: {
            from: "departments",
            localField: "department",
            foreignField: "_id",
            as: "department",
        },
    },
    {
        $unwind: "$department",
    },
    {
        $match: {
            "department.name": "Finance",
        },
    },
    {
        $sort: {
            budget: -1,
        },
    },
]);

// 4. Recent Sales by Finance Employees :
// Formulate a query to list all sales made by employees in the "Finance" department since "2023-09-15", sorted by sale date in ascending order.
db.sales.aggregate([
    {
        $lookup: {
            from: "employees",
            localField: "employee_id",
            foreignField: "_id",
            as: "employee",
        },
    },
    {
        $unwind: "$employee",
    },
    {
        $addFields: {
            department: "$employee.department_id",
        },
    },
    {
        $lookup: {
            from: "departments",
            localField: "department",
            foreignField: "_id",
            as: "department",
        },
    },
    {
        $unwind: "$department",
    },
    {
        $match: {
            "department.name": "Finance",
            sale_date: { $gte: "2023-09-15" },
        },
    },
    {
        $sort: {
            sale_date: 1,
        },
    },
]);

// 5. Project Details for Employee "John Doe" :
// Write a query to find all projects associated with "John Doe", including project name, budget, and department name.
db.employees.aggregate([
    {
        $match: {
            name: "John Doe",
        },
    },
    {
        $unwind: "$projects",
    },
    {
        $lookup: {
            from: "projects",
            localField: "projects",
            foreignField: "_id",
            as: "project_details",
        },
    },
    {
        $unwind: "$project_details",
    },
    {
        $lookup: {
            from: "departments",
            localField: "project_details.department",
            foreignField: "_id",
            as: "department",
        },
    },
    {
        $unwind: "$department",
    },
    {
        $addFields: {
            project_name: "$project_details.name",
            project_budget: "$project_details.budget",
            department_name: "$department.name",
        },
    },
    {
        $project: {
            project_name: 1,
            project_budget: 1,
            department_name: 1,
            _id: 0,
        },
    },
]);

// 6. Employees and Their Office Address for "Payroll Software" Project :
// Create a query to list all employees working on the "Payroll Software" project with their office addresses.
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
        $unwind: "$projects",
    },
    {
        $addFields: {
            project_name: "$projects.name",
        },
    },
    {
        $match: {
            project_name: "Payroll Software",
        },
    },
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
            office_address: 1,
            _id: 0,
        },
    },
]);

// 7. Detailed Sales Report for "Engineering" Employees :
// Formulate a query to generate a detailed sales report for each sale made by employees in the "Engineering" department, including employee name, sale amount, and office address.
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
        $match: {
            "department.name": "Engineering",
        },
    },
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
            office_address: "$office.address",
            sale_amount: "$sale.amount",
        },
    },
    {
        $project: {
            name: 1,
            office_address: 1,
            sale_amount: 1,
            _id: 0,
        },
    },
]);

// 8. Top Selling Employees in Each Department :
// Write a query to identify the top-selling employee in each department based on total sales amount, sorting the results by department name.

// 9. Average Salary by Department: Create a query to calculate the average salary of employees in each department, sorting the results by average salary in descending order.
db.employees.aggregate([
    {
        $group: {
            _id: "$department_id",
            avg_salary: { $avg: "$salary" },
        },
    },
    {
        $sort: {
            avg_salary: -1,
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
            avg_salary: 1,
            _id: 0,
        },
    },
]);

// 10. Most Involved Employees in Projects by Department :
// Formulate a query to find the employee with the highest number of projects in each department, including the employee's name, number of projects, and department name, sorted by the number of projects in descending order.
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
            num_projects: {
                $size: "$projects",
            },
            dept_name: "$department.name",
        },
    },
    {
        $group: {
            _id: "$department_id",
            employees: {
                $push: {
                    name: "$name",
                    num_projects: "$num_projects",
                    dept_name: "$dept_name",
                },
            },
        },
    },
    {
        $project: {
            employees: {
                $sortArray: {
                    input: "$employees",
                    sortBy: {
                        num_projects: -1,
                    },
                },
            },
            top_employee: {
                $slice: ["$employees", 1],
            },
        },
    },
    {
        $addFields: {
            name: "$top_employee.name",
            num_projects: "$top_employee.num_projects",
            dept_name: "$top_employee.dept_name",
        },
    },
    {
        $unwind: "$name",
    },
    {
        $unwind: "$num_projects",
    },
    {
        $unwind: "$dept_name",
    },
    {
        $project: {
            name: 1,
            num_projects: 1,
            dept_name: 1,
            _id: 0,
        },
    },
]);
