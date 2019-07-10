
duplicate farmer's markets
select substr(MarketName, 1,20), street, zip, count(substr(MarketName, 1,20)) as NumOccurrences from farmers_market_base_table 
group by street, substr(MarketName, 1,20) having (count(street) > 1 and count(zip) > 1 and count(substr(MarketName,1,20)) > 1);

select substr(MarketName, 1,30), street, zip, count(substr(MarketName, 1,30)) as NumOccurrences from farmers_market_base_table 
group by street, substr(MarketName, 1,30) having (count(street) > 1 and count(zip) > 1 and count(substr(MarketName,1,30)) > 1);
