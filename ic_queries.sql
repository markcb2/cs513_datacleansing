Missing Farmers Market Name
select fmid from farmers_market_base_table where MarketName is null;

no rows found.

duplicate farmer's markets
select substr(MarketName, 1,20), street, zip, count(substr(MarketName, 1,20)) as NumOccurrences from farmers_market_base_table 
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

select substr(MarketName, 1,30), street, zip, count(substr(MarketName, 1,30)) as NumOccurrences from farmers_market_base_table 
group by street, substr(MarketName, 1,30) having (count(street) > 1 and count(zip) > 1 and count(substr(MarketName,1,30)) > 1);

Foothills Farmers' Market, Inc|126 W. Marion Street|28152|2
Redland Community Farm And Mar|12690 Sw 280th Street|33033|2
Crescent City Farmers Market|200 Broadway Street|70118|2
Welcome Center Farmers Market|2931 Monroe Avenue|51555|2
Paulding County Farm Bureau Fa|4075 Charles Hardy Pkway,|30157|2
Dresden Farmers Market|421 Linden St.|38225|2

Invalid US Longitude and Lattitude
select fmid, MarketName, x, y from farmers_market_base_table where x > 0 or y < 0 or x > abs(180) or y > abs(90) or x is null or y is null;

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

