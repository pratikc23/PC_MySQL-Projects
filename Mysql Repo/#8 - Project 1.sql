-- 1.Create new schema as ecommerce.
create database ecommerce;
use ecommerce;

-- 2.Import .csv file users_data into MySQL
-- (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)
use ecommerce;
select count(*) from users_data;

-- 3.Run SQL command to see the structure of table
desc users_data;


-- 4.Run SQL command to select first 100 rows of the database.
select * from users_data limit 100;

-- 5.How many distinct values exist in table for field country and language.
select count(distinct country) country, count(distinct language) language from users_data;

-- 6.Check whether male users are having maximum followers or female users.
 select gender,sum(socialNBFollowers) from users_data group by gender;
 
-- 7.Calculate the total users those:
-- a.Uses Profile Picture in their Profile
select count(hasProfilePicture) Users_with_ProfilePicture from users_data where hasProfilePicture = 'True';
-- b.Uses Application for Ecommerce platform
select count(hasAnyApp) Users_with_Anyapp from users_data where hasAnyApp = 'True';
-- c.Uses Android app
select count(hasAndroidApp) Users_with_Androidapp from users_data where hasAndroidApp = 'True';
-- d.Uses ios app
select count(hasIosApp) Users_with_Iosdapp from users_data where hasIosApp = 'True';

-- 8.Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only those users having at least 1 product bought.)
select country,count(productsBought) Buyers from users_data group by country order by Buyers desc;

-- 9.Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only those users having at least 1 product sold.)
select country,count(productsSold) Sellers from users_data group by country order by Sellers asc;


-- 10.Display name of top 10 countries having maximum products pass rate.
select country from users_data group by country having max(productsPassRate) limit 10;

-- 11.Calculate the number of users on an ecommerce platform for different language choices
select language,count(language) from users_data group by language;


-- 12.Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. (Hint: use UNION to answer this question.)
select sum(productsWished) ,sum(socialProductsLiked) from users_data where gender='F';
-- choice of ehr female users about putting the product in a wishlist or to like socially om an ecommerce platform is same. 


-- 13.Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
select count(productsSold),count(productsBought) from users_data where gender='M';
-- choicr of male users about being seller or buyer is same.

-- 14.Which country is having maximum number of buyers?
select country,max(productsBought) Max_no_of_buyers from users_data group by country order by max(productsBought) desc limit 1;
-- Belfique country is having maximum number of buyers.

-- 15.List the name of 10 countries having zero number of sellers.
select country , productsSold from users_data where productsSold=0 limit 10;


-- 16.Display record of top 110 users who have used ecommerce platform recently.
select * from users_data group by daysSinceLastLogin having min(daysSinceLastLogin) order by daysSinceLastLogin asc limit 110;


-- 17.Calculate the number of female users those who have not logged in since last 100 days.
select count(type) from users_data where gender='F' and daysSinceLastLogin >= 100;

-- 18.Display the number of female users of each country at ecommerce platform.
select country,count(gender) Female_users from users_data where gender='F' group by country;

-- 19.Display the number of male users of each country at ecommerce platform.
select country,count(gender) Male_users from users_data where gender='M' group by country;

-- 20.Calculate the average number of products sold and bought on ecommerce platform by male users for each country.
select country,avg(productsSold) Products_sold,avg(productsBought) Products_bought from users_data where gender='M' group by country;
