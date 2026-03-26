/*

𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Medium Level) hashtag#SQL Interview Question — Solution

Each Employee is assigned one territory and is responsible for the Customers from this territory. There may be multiple employees assigned to the same territory.

Write a query to get the Employees who are responsible for the maximum number of Customers. Output the Employee ID and the number of Customers.

🌀By solving this, you'll learn how to use Cte, Group by, Join, Agg function. Give it a try and share the output! 👇

𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭
CREATE TABLE map_employee_territory (empl_id VARCHAR(10), territory_id VARCHAR(10));

INSERT INTO map_employee_territory (empl_id, territory_id) VALUES ('E849', 'T3'), ('E850', 'T3'), ('E851', 'T3'), ('E852', 'T1'), ('E853', 'T2'), ('E854', 'T5'), ('E855', 'T5'), ('E856', 'T4'), ('E857', 'T2');

CREATE TABLE map_customer_territory (cust_id VARCHAR(10), territory_id VARCHAR(10));

INSERT INTO map_customer_territory (cust_id, territory_id) VALUES ('C273', 'T3'), ('C274', 'T3'), ('C275', 'T1'), ('C276', 'T1'), ('C277', 'T1'), ('C278', 'T2'), ('C279', 'T2'), ('C280', 'T4'), ('C281', 'T4'), ('C282', 'T4'), ('C283', 'T4'), ('C284', 'T5'), ('C285', 'T5'), ('C286', 'T3'), ('C287', 'T3');
---------

𝐄𝐱𝐩𝐥𝐚𝐧𝐚𝐭𝐢𝐨𝐧 𝐭𝐨 𝐒𝐨𝐥𝐯𝐞 𝐐𝐮𝐞𝐫𝐲
1. Join both tables on territory_id to associate each customer with all employees of the same territory.

2. Count customers for each employee.

3. Find the maximum customer count.

4. Filter employee(s) with that max.

*/

--My solution
with territory_wise_customer_cnt as (
Select territory_id, count(*) as cnt
from map_customer_territory
group by territory_id
),
territory_with_max_cust_cnt as 
(
select territory_id, cnt,rank() over(order by cnt desc) as rn
from territory_wise_customer_cnt
)
Select empl_id ,cnt
from map_employee_territory s
join territory_with_max_cust_cnt t
on s.territory_id = t.territory_id
where rn = 1