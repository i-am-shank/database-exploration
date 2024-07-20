CREATE TABLE `Departments`(
    `dept_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `head_of_department` BIGINT NOT NULL
);
ALTER TABLE
    `Departments` ADD UNIQUE `departments_head_of_department_unique`(`head_of_department`);