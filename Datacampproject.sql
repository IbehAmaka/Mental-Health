--Create database mental_health;

select *
from students;

select max (age)
from students;
-- The maximum age of student is 31

--questions to be answered,
--lets count the total number of students in this survey

select  count(inter_dom) as total_records
from students;

--count international and domestic student
select inter_dom, count (inter_dom ) as count_inter_dom
from students
where inter_dom is not null
group by inter_dom;

---count graduate and undergradate that are international students
select 
      case when academic = 'Grad' then 'Gradaute'
           when academic = 'under' then 'undergraduate'
	  End as student_category,
	  count(*) as number_of_students
from students
where academic in ('Grad', 'under') 
and inter_dom = 'inter'
group by academic;

---How many international student can speak fluent japanese
select 
     case when japanese_cate = 'Average' then 'Average'
	       when japanese_cate = 'High'  then 'High'
		   when japanese_cate = 'Low' then 'Low'
	 end as langauage_cat,
	count (*) as number_of__inter_students
from students 
 where inter_dom  =  'inter'
and japanese_cate in ('Average', 'High', 'Low')
group by japanese_cate;

---how many international student speak fleunt English
select 
            case when english_cate = 'Average' then 'Average'
			     when english_cate = 'High' then 'High'
				 when english_cate = 'Low' then 'Low'
			end as language_cat,
			count (*) as number_of__inter_students
from students
   where inter_dom = 'inter'
   and english_cate  in ('Average', 'High', 'Low')
   group by english_cate;

--How many japanese student can speak fluent english
select 
            case when english_cate = 'Average' then 'Average'
			     when english_cate = 'High' then 'High'
				 when english_cate = 'Low' then 'Low'
			end as language_cat,
			count (*) as number_of__inter_students
from students
   where inter_dom = 'Dom'
   and english_cate  in ('Average', 'High', 'Low')
   group by english_cate;
            
--- how long international and domestic students have stayed in the university

select * 
from students;

SELECT
    stay_cate AS stay_cat,
    COUNT(CASE WHEN inter_dom = 'Dom' THEN 1 END) AS number_of_domestic_students_stay,
    COUNT(CASE WHEN inter_dom = 'Inter' THEN 1 END) AS number_of_international_students_stay
FROM students
WHERE stay_cate IN ('Short', 'Medium', 'Long')
GROUP BY stay_cate
ORDER BY stay_cat;

----lets see the test score of drpression by both international and domestic student
--first count the values in the depsev

--- i noticed some weird numbers are inside so i removed them
DELETE FROM students
WHERE depsev in ('107', '15', '65', '73', '8');
--first count the values in the depsev
select depsev, count (*) as depresion_severity
from students
where depsev is not null
group by depsev
order by depsev
;


SELECT 
    ROUND(AVG(todep), 2) AS average_score,
    ROUND(MIN(todep), 2) AS min_score,
    ROUND(MAX(todep), 2) AS max_score,
    ROUND(STDEV(todep), 2) AS std_deviation,
    ROUND(VAR(todep), 2) AS variance
FROM students;

----do the same for internationl student
SELECT 
    ROUND(AVG(todep), 2) AS average_score,
    ROUND(MIN(todep), 2) AS min_score,
    ROUND(MAX(todep), 2) AS max_score,
    ROUND(STDEV(todep), 2) AS std_deviation,
    ROUND(VAR(todep), 2) AS variance
FROM students
where inter_dom = 'inter';

---lets see for domestic student
SELECT 
    ROUND(AVG(todep), 2) AS average_score,
    ROUND(MIN(todep), 2) AS min_score,
    ROUND(MAX(todep), 2) AS max_score,
    ROUND(STDEV(todep), 2) AS std_deviation,
    ROUND(VAR(todep), 2) AS variance
FROM students
where inter_dom = 'DOM';

---See if length of stay impacts the average diagnostic scores rounded
---to two decimal places for international students, and order the 
---results by descending order of the length of stay.

SELECT 
    stay_cate AS length_of_stay,
    ROUND(AVG(todep), 2) AS average_diagnostic_score
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay_cate
ORDER BY stay_cate DESC;

SELECT 
    stay AS length_of_stay,
    ROUND(AVG(todep),2) AS average_phq,
	ROUND(AVG(tosc), 2) AS average_scs,
	ROUND (AVG(acs),2) AS average_as
FROM students
WHERE inter_dom = 'Dom'
GROUP BY stay
ORDER BY stay DESC;

select * 
from students;

---lets see who students prefare to seek help when depressed

SELECT
    inter_dom AS student_type,
    SUM(CASE WHEN religion_bi = 'Yes' THEN 1 ELSE 0 END) AS religion_yes,
    SUM(CASE WHEN religion_bi = 'No' THEN 1 ELSE 0 END) AS religion_no,
    SUM(CASE WHEN partner_bi = 'Yes' THEN 1 ELSE 0 END) AS partner_yes,
    SUM(CASE WHEN partner_bi = 'No' THEN 1 ELSE 0 END) AS partner_no,
    SUM(CASE WHEN internet_bi = 'Yes' THEN 1 ELSE 0 END) AS internet_yes,
    SUM(CASE WHEN internet_bi = 'No' THEN 1 ELSE 0 END) AS internet_no,
    SUM(CASE WHEN parents_bi = 'Yes' THEN 1 ELSE 0 END) AS parents_yes,
    SUM(CASE WHEN parents_bi = 'No' THEN 1 ELSE 0 END) AS parents_no,
    SUM(CASE WHEN doctor_bi = 'Yes' THEN 1 ELSE 0 END) AS doctors_yes,
    SUM(CASE WHEN doctor_bi = 'No' THEN 1 ELSE 0 END) AS doctors_no,
	SUM(CASE WHEN friends_bi = 'No' THEN 1 ELSE 0 END) AS friends_yes,
	SUM(CASE WHEN friends_bi = 'YES' THEN 1 ELSE 0 END) AS friends_no,
	SUM(CASE WHEN professional_bi = 'No' THEN 1 ELSE 0 END) AS professional_yes,
	SUM(CASE WHEN professional_bi = 'YES' THEN 1 ELSE 0 END) AS professional_no,
	SUM(CASE WHEN alone_bi = 'YES' THEN 1 ELSE 0 END) AS alone_yes,
	SUM(CASE WHEN alone_bi = 'NO' THEN 1 ELSE 0 END) AS alone_no,
	SUM(CASE WHEN phone_bi = 'YES' THEN 1 ELSE 0 END) AS phone_yes,
	SUM(CASE WHEN phone_bi = 'NO' THEN 1 ELSE 0 END) AS phone_no
FROM students
WHERE inter_dom IS NOT NULL
GROUP BY inter_dom;



---the percentage
SELECT
    inter_dom AS student_type,
    ROUND((SUM(CASE WHEN religion_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS religion_percentage,
    ROUND((SUM(CASE WHEN partner_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS partner_percentage,
    ROUND((SUM(CASE WHEN internet_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS internet_percentage,
    ROUND((SUM(CASE WHEN parents_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS parents_percentage,
    ROUND((SUM(CASE WHEN doctor_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS doctors_percentage,
    ROUND((SUM(CASE WHEN friends_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS friends_percentage,
    ROUND((SUM(CASE WHEN professional_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS professional_percentage,
    ROUND((SUM(CASE WHEN alone_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS alone_percentage,
    ROUND((SUM(CASE WHEN phone_bi = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS phone_percentage
FROM students
WHERE inter_dom IS NOT NULL
GROUP BY inter_dom;



