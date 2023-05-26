/* 1.Create new schema as alumni*/

create database alumni;

/*3.Run SQL command to see the structure of six tables*/

desc college_a_hs;
desc college_a_se;
desc college_a_sj;
desc college_b_hs;
desc college_b_se;
desc college_b_sj;

/* 6.Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values.*/

create view college_a_hs_v as 
select * from college_a_hs 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
HSDegree is not null and 
EntranceExam is not null and 
Institute is not null and 
Location is not null ;

/*7.Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.*/

create view college_a_se_v as
select * from college_a_se 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Location is not null ;

/*8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.*/

create view college_a_sj_v as
select * from college_a_sj 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Designation is not null and
Location is not null ;


/*9.Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.*/

create view college_b_hs_v as
select * from college_b_hs 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Branch is not null and
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
HSDegree is not null and 
EntranceExam is not null and 
Institute is not null and 
Location is not null ;

/*10.Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.*/

create view college_b_se_v as 
select * from college_b_se 
where  RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Branch is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Location is not null ;

/*11.Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V.*/

create view college_b_sj_v as 
select * from college_b_sj 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and
Branch is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Designation is not null and
Location is not null ;


/*12.Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views 
(College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) */

delimiter $
create procedure v1()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_a_hs_v;
end $
delimiter ;

call v1();

delimiter $
create procedure v2()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_a_se_v;
end $
delimiter ;

call v2();

delimiter $
create procedure v3()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_a_sj_v;
end $
delimiter ;

call v3();

delimiter $
create procedure v4()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_b_hs_v;
end $
delimiter ;

call v4();

delimiter $
create procedure v5()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_b_se_v;
end $
delimiter ;

call v5();

delimiter $
create procedure v6()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from college_b_sj_v;
end $
delimiter ;

call v6();

/*14.Write a query to create procedure get_name using the cursor to fetch names of all students from college A.*/

delimiter $$
create  procedure get_name1(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from college_a_hs
		union
		select Name from college_a_se
		union
		select Name from college_a_sj;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name1(@l);
select @l student_names_college_a;

/*15.Write a query to create procedure get_name using the cursor to fetch names of all students from college B.*/

delimiter $$
create  procedure get_name2(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from college_b_hs
		union
		select Name from college_b_se
		union
		select Name from college_b_sj;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name2(@l);
select @l student_names_college_b;

/* 16.Calculate the percentage of career choice of College A and College B Alumni (w.r.t Higher Studies, Self Employed and Service/Job)*/

select (1157+1016+5633) Total_No_of_alumni_college_a;

select 'Higher_studies' career_choice,count(*) No_of_students ,count(*)/7806*100 Percentage from college_a_hs
union
select 'Self Employed'  career_choice,count(*) No_of_students,count(*)/7806*100 Percentage from college_a_se
union
select 'Service/Job'  career_choice,count(*) No_of_students,count(*)/7806*100 Percentage from college_a_sj;

select (199+201+1859) Total_no_of_alumni_college_b;

select 'Higher_studies' career_choice,count(*) No_of_students,count(*)/2259*100 Percentage  from college_b_hs
union
select 'Self Employed'  career_choice,count(*) No_of_students,count(*)/2259*100 Percentage from college_b_se
union
select 'Service/Job'  career_choice,count(*) No_of_students,count(*)/2259*100 Percentage from college_b_sj;
