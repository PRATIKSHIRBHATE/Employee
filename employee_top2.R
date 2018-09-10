# Employee Dataset

setwd("/Users/pratikshirbhate/Documents/Data Science/Projects/Employee_Dataset/")

df <- read.csv("employee.csv")

ordered <- df[order(df$Salary, decreasing = TRUE),]
splits <- split(ordered, ordered$dept_id)
heads <- lapply(splits, head.matrix)
do.call(rbind, heads)

library(dplyr)
head1 <-  df %>% group_by(dept_id) %>% top_n(n = 2, wt = Salary)

library(data.table)
setorder(setDT(df), -Salary)[, head(.SD, 2), keyby = dept_id]

OR
setorder(setDT(df), dept_id, -Salary)[, head(.SD, 2), by = dept_id]

OR
setorder(setDT(df), dept_id, -Salary)[, indx := seq_len(.N), by = dept_id][indx <= 2]

# SQL
library("sqldf")

#MS Sql
#query = "SELECT * FROM (SELECT emp_id,emp_name,dept_id,Salary ,dense_rank() OVER ( partition by dept_id ORDER BY Salary desc) as ranking FROM df) a WHERE a.ranking <= 2"
#df3 <- sqldf(query)

#MySql
query1 = "SELECT df1.emp_id , df1.emp_name, df1.dept_id, df1.Salary
FROM df df1
WHERE (
SELECT COUNT(DISTINCT(df2.Salary))
FROM df df2
WHERE df2.Salary > df1.Salary and df1.dept_id  = df2.dept_id ) in (0,1) group by df1.dept_id , df1.Salary"

df4 <- sqldf(query1)


