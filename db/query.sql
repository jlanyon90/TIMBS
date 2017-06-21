select device_name,serial_number,warrenty_date 
	from items 
	where warrenty_date<date('now');
