/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

select facid,name,membercost
from Facilities
where membercost>0

/* Q2: How many facilities do not charge a fee to members? */

select count(distinct (name))
from Facilities
where membercost=0


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

select facid, name, membercost, monthlymaintenance
from Facilities
where membercost<0.2*monthlymaintenance

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

select *
from Facilities
where facid in (1,5)

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

select name,monthlymaintenance,
	   case when monthlymaintenance >100 then 'expensive' 
	   else 'cheap' end as category
from Facilities

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT firstname,surname
from Members
where joindate= (select max(joindate) from Members)



/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

select 
	   f.name as facility_name,
	   concat(m.firstname,' ',m.surname) as member_name,
	   count(*)
	   
from Bookings b
join Facilities f
	on b.facid=f.facid
join Members m
	on b.memid=m.memid
where b.facid in (0,1)
group by 1,2
order by 2

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT  b.bookid,
		case when b.memid=0 then b.slots*2*f.guestcost 
		else b.slots*2*f.membercost end as cost
from Bookings b
join Facilities f
on b.facid=f.facid
where left(b.starttime,10)='2012-09-14'
having cost>30

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

select
	sub.bookid,
	case when sub.memid=0 then sub.slots*2*f.guestcost 
	else sub.slots*2*f.membercost end as cost
from 
	(select bookid, facid, memid, slots
		from Bookings
		where left(starttime,10)='2012-09-14') sub
join Facilities f
on sub.facid=f.facid
having cost>30
order by cost


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

/* I calculate the monthly revenue by non_mem/member first and then combine them in 
the outer query */

select
		sub.name,
		sum(sub.revenue_non_mem+sub.mem_revenue) as revenue

from(

SELECT 
	f.facid as facid,
	f.name as name,
	DATE_FORMAT(cast(b.starttime as date),'%Y-%m-01') as month,
	sum(case when b.memid=0 then b.slots*2*f.guestcost else 0 end) as revenue_non_mem,
	sum(case when b.memid=1 then b.slots*2*f.membercost else 0 end) as mem_revenue,
	f.monthlymaintenance
from Bookings b
join Facilities f
on b.facid=f.facid                             
group by 1,2,3) sub

group by 1
having revenue <1000
order by 2
