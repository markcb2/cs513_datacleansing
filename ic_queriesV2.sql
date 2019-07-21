IC violations


 1. Market records where there are at least two rows having the same ID, but some differing attributes.


select fm1.fmid, fm1.MarketName, fm1.street, fm1.city, fm1.County, fm1.State, fm1.zip, fm1.x, fm1.y
  from markets fm1
  join ( select *
           from markets 
          group by fmid
         having count(*) > 1 ) fm2
    on fm1.fmid = fm2.fmid;


No rows found

2. Missing market names in the Market table

select fmid from markets where MarketName is null;

No rows found.

3. Duplicate market names in the Market table

select substr(MarketName, 1,20), street, zip, count(substr(MarketName, 1,20)) as NumOccurrences from markets 
group by street, substr(MarketName, 1,20) having (count(street) > 1 and count(zip) > 1 and count(substr(MarketName,1,20)) > 1);

Foothills Farmers' M|126 W. Marion Street|28152|2
Redland Community Fa|12690 Sw 280th Street|33033|2
Vashon Farmers Marke|17519 Vashon Highway Sw|98070|2
Crescent City Farmer|200 Broadway Street|70118|2
Mccutcheon/mount Ver|2501 Sherwood Hall Lane|22306|2
Welcome Center Farme|2931 Monroe Avenue|51555|2
Main Street Farmers |301 Main Street|20878|2
Paulding County Farm|4075 Charles Hardy Pkway,|30157|2
Dresden Farmers Mark|421 Linden St.|38225|2
Mississippi Farmers |929 High Street|39202|2
Beaverton Farmers Ma|Hall Blvd.|97075|2

select substr(MarketName, 1,30), street, zip, count(substr(MarketName, 1,30)) as NumOccurrences from markets 
group by street, substr(MarketName, 1,30) having (count(street) > 1 and count(zip) > 1 and count(substr(MarketName,1,30)) > 1);

Foothills Farmers' Market, Inc|126 W. Marion Street|28152|2
Redland Community Farm And Mar|12690 Sw 280th Street|33033|2
Crescent City Farmers Market|200 Broadway Street|70118|2
Welcome Center Farmers Market|2931 Monroe Avenue|51555|2
Paulding County Farm Bureau Fa|4075 Charles Hardy Pkway,|30157|2
Dresden Farmers Market|421 Linden St.|38225|2

4. Invalid US Longitude or Lattitude in Market table.  These rows can't be used for our USA farmers market geo-location use cases.

select fmid, MarketName, x, y from markets where x > 0 or y < 0 or x > abs(180) or y > abs(90) or abs(y) >  abs(x); 

No rows found

5. Missing Longitude or Lattitude in the Market table.  These rows can't be used for our USA farmers market geo-location use cases;

select fmid, MarketName, x, y from markets  where x is null or y is null;

2000001|Center For Design Practice - Mobile Farmers Market||
1011689|Charlotte Regional Farmers Market||
2000002|Dig It!||
1002854|East Goshen Farmers Market||
2000004|Farm A La Carte||
2000005|Farm Fresh Mobile Market||
2000006|Farm To Family||
2000007|Farmer’s Market Express||
2000008|Food Shuttlle||
2000009|Freshest Cargo: Mobile Farmers’ Market||
2000010|Fulton Fresh Mobile Farmer’s Market||
2000011|Go Fresh Mobile Farmer's Market||
2000012|Gorge Grown Mobile Farmers' Market||
2000013|Green Mountain - Mobile Farmers Market||
2000014|Greensgrow Farms Mobile Food Delivery System||
2000016|Honeybee Mobile Farmers Market||
2000019|Merced County’s Mobile Farmers Market||
2000020|Mobile Farm Fresh Of Nc||
2000021|Osage Nation Sr. Farmers Market||
2000022|Real Food System||
2000026|Riverview Farms Of Ranger||
2000028|San Joaquin Mobile Farmers Market||
2000030|Steve Casey's Mobile Produce Market||
2000032|Tmc Healthy Harvest Mobile Market||
2000033|Tri-community mobile farmers market||
2000034|Urban Oasis Farmers Market On The Move||
2000035|Westside Tailgate Farmers Market||
2000036|Ymca Farmers Market And Veggie Van||


6.  Social Media records where its foreign key not found in Market table

select * from socialMedia sm where sm.fmid not in (select mkt.fmid from markets mkt);

No rows found

7. Social Media records where there are at least two rows having the same ID, but some differing attributes.

select sm1.fmid, sm1.website, sm1.Facebook, sm1.Twitter, sm1.Youtube, sm1.OtherMedia
  from socialMedia sm1
  join ( select *
           from socialMedia 
          group by fmid
         having count(*) > 1 ) sm2
    on sm1.fmid = sm2.fmid;

No rows found


8. Invalid websites in the Social Media table. Valid web sites must have at least one character between "http(s)://" and the "." and at least two characters after the dot. 

select fmid, website  from  socialMedia where website not  like 'http%://_%.__%';

No rows found

9. Social Media records with no social media data

select fmid, website, Facebook,  Twitter,  Youtube, OtherMedia from  socialMedia where website is null and Facebook is null and Twitter is null and Youtube is null and OtherMedia is null;

No records found

10. Payment Type records where their foreign keys are not found in the Market table

select * from paymentTypes pmt where pmt.fmid not in (select mkt.fmid from markets mkt);

No records found


11. Payment Type records where there are at least two rows having the same ID, but some differing attributes.

select pmt1.fmid, pmt1.wic, pmt1.wiccash, pmt1.SFMNP, pmt1.SNAP
  from paymentTypes pmt1
  join ( select *
           from paymentTypes 
          group by fmid
         having count(*) > 1 ) pmt2
    on pmt1.fmid = pmt2.fmid;


No rows found

12. Rows with invalid payment type indicator values (valid values are 'Y' or null) in the Payment Type table;

select fmid, Credit, wic, wiccash, SFMNP, SNAP from paymentTypes where Credit not in ('Y', null) or wic not in ('Y', null) or wiccash not in ('Y', null) or SFMNP not in ('Y', null) or SNAP not in ('Y', null);

No rows found

13. Schedule records where their foreign keys are not found in the Market table 

select * from schedule sch where sch.fmid not in (select mkt.fmid from markets mkt);

No records found

14. Schedule records where there are at least two rows having the same ID, but some differing attributes.

select sch1.fmid, sch1.season, sch1.seasonOpenning, sch1.seasonClosing, sch1.seasonTime
  from schedule sch1
  join ( select *
           from schedule 
          group by fmid
         having count(*) > 1 ) sch2
    on sch1.fmid = sch2.fmid;

No rows found

.15  Rows where there is no or incomplete schedule information

select *  from schedule  where season is null and (seasonOpenning is null or seasonClosing is null) or seasonTime is null limit 20;

1009364||||
1011213||||Tue: 3:00 PM-7:00 PM;
1006234||||
1006494||||
1010617||||
1007585||||
1003865||||
1002947||||
1004031||||
1007070||||
1009543||||
1002108||||
1007575||||
1005122||||
1008461||||Mon: 9:00 AM-5:00 PM;Tue: 9:00 AM-5:00 PM;Wed: 9:00 AM-5:00 PM;Thu: 9:00 AM-5:00 PM;Fri: 9:00 AM-5:00 PM;Sat: 9:00 AM-5:00 PM;
1007519||||
1006969||||
1018278||||Sat: 8:00 AM-1:00 PM;
1005109||||
1002464||||

select count( *)  from schedule  where season is null and (seasonOpenning is null or seasonClosing is null) or seasonTime is null;

3205 records with no incomplete schedile inforation

16.  Product records where their foreign keys are not found in the Market tables

select * from products prd where prd.fmid not in (select mkt.fmid from farmers_market_base_table mkt);

No rows found.

17. Product records where there are at least two rows having the same ID, but differing attributes.

select *
  from products prd1
  join ( select *
           from products 
          group by fmid
         having count(*) > 1 ) prd2
    on prd1.fmid = prd2.fmid;

No rows found


18.  Rows with no product information

select * from products where Organic is null and Bakedgoods is null and Cheese is null and Crafts is null and Flowers and Eggs is null and Seafood is null and Herbs is null and Vegetables is null and Honey is null
    and Jams is null and Maple is null and Meat is null and Nursery is null and Nuts is null and Plants is null and Poultry is null and Prepared is null and Soap is null and Trees and
    Wine is null and Coffee is null and Beans is null and Fruits is null and Grains is null and Juices is null and Mushrooms is null and Tofu is null and WildHarvested is null;

No rows found



------------------

Additional data cleansing to eliminate Integrity Constraints shown above


create table deduplicated_markets as
select fmid, MarketName, street, city, County, State, zip, x, y from markets where fmid not in (
select fmid from markets 
group by street, substr(MarketName, 1,20) having (count(street) > 1 and count(zip) > 1 and count(substr(MarketName,1,20)) > 1));

create table cleansed_markets as 
select fmid, MarketName, street, city, County, State, zip, x, y from deduplicated_markets where fmid not in 
(
  select fmid from markets  where x is null or y is null
);

create table cleansed_socialMedia as 
  select fmid, website, Facebook, Twitter, Youtube, OtherMedia from socialMedia where fmid in (
    select fmid from cleansed_markets
);

create table cleansed_paymentTypes as
  select fmid, Credit, wic, wiccash, SFMNP, SNAP from paymentTypes where fmid in (
    select fmid from cleansed_markets
);

create table cleansed_products as 
  select * from products where fmid in (
    select fmid from cleansed_markets
);

create table temp_cleansed_schedule as
    select fmid, season, seasonOpenning, seasonClosing, seasonTime from schedule where fmid not in (
      select fmid  from schedule  where season is null and (seasonOpenning is null or seasonClosing is null) or seasonTime is null
);

create table cleansed_schedule as
  select * from temp_cleansed_schedule where fmid in (
    select fmid from cleansed_markets
);

DROP TABLE IF EXISTS markets;
CREATE TABLE markets (
FMID VARCHAR(10) NOT NULL,
MarketName VARCHAR(100) NOT NULL,
street VARCHAR(100) NULL,
city VARCHAR(50) NULL,
County VARCHAR(50) NULL,
State VARCHAR(50) NULL,
zip VARCHAR(10) NULL,
x NUMERIC(12) NULL,
y NUMERIC(12) NULL
);

DROP TABLE IF EXISTS paymentTypes;
CREATE TABLE paymentTypes (
FMID VARCHAR(10) NOT NULL,
Credit VARCHAR(1) NULL,
WIC VARCHAR(1) NULL,
WICcash VARCHAR(1) NULL,
SFMNP VARCHAR(1) NULL,
SNAP VARCHAR(1) NULL
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
FMID VARCHAR(10) NOT NULL,
Organic VARCHAR(1) NULL,
Bakedgoods VARCHAR(1) NULL,
Cheese VARCHAR(1) NULL,
Crafts VARCHAR(1) NULL,
Flowers VARCHAR(1) NULL,
Eggs VARCHAR(1) NULL,
Seafood VARCHAR(1) NULL,
Herbs VARCHAR(1) NULL,
Vegetables VARCHAR(1) NULL,
Honey VARCHAR(1) NULL,
Jams VARCHAR(1) NULL,
Maple VARCHAR(1) NULL,
Meat VARCHAR(1) NULL,
Nursery VARCHAR(1) NULL,
Nuts VARCHAR(1) NULL,
Plants VARCHAR(1) NULL,
Poultry VARCHAR(1) NULL,
Prepared VARCHAR(1) NULL,
Soap VARCHAR(1) NULL,
Trees VARCHAR(1) NULL,
Wine VARCHAR(1) NULL,
Coffee VARCHAR(1) NULL,
Beans VARCHAR(1) NULL,
Fruits VARCHAR(1) NULL,
Grains VARCHAR(1) NULL,
Juices VARCHAR(1) NULL,
Mushrooms VARCHAR(1) NULL,
PetFood VARCHAR(1) NULL,
Tofu VARCHAR(1) NULL,
WildHarvested VARCHAR(1) NULL
);

DROP TABLE IF EXISTS socialMedia;
CREATE TABLE socialMedia (
FMID VARCHAR(10) NOT NULL,
Website VARCHAR(256) NULL,
Facebook VARCHAR(256) NULL,
Twitter VARCHAR(256) NULL,
Youtube VARCHAR(256) NULL,
OtherMedia VARCHAR(256) NULL
);

DROP TABLE IF EXISTS schedule;
CREATE TABLE schedule (
FMID VARCHAR(10) NOT NULL,
season VARCHAR(50) NULL,
seasonOpenning VARCHAR(50) NULL,
seasonClosing VARCHAR(50) NULL,
seasonTime VARCHAR(100) NULL
);

insert into markets select * from cleansed_markets;

insert into paymentTypes select * from cleansed_paymentTypes;

insert into products select * from cleansed_products;

insert into socialMedia select * from cleansed_socialMedia;

insert into schedule select * from cleansed_schedule;

drop table deduplicated_markets;

drop table cleansed_markets;

drop table cleansed_socialMedia;

drop table cleansed_paymentTypes;

drop table cleansed_products;

drop table temp_cleansed_schedule;

drop table cleansed_schedule;

.headers on
.mode csv
.output markets.csv
select * from markets;
.quit

.headers on
.mode csv
.output paymentTypes.csv
select * from paymentTypes;
.quit

.headers on
.mode csv
.output products.csv
select * from products;
.quit

.headers on
.mode csv
.output socialMedia.csv
select * from socialMedia;
.quit
