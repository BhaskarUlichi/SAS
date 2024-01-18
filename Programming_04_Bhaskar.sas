/* DSCI 507 */
/* Programming Exercise 04 */
/* Bhaskar Teja Ulichi [101127292] */
/* Problem 1 (a) */
DATA eu_occ_total;
	SET pg1.eu_occ;
	Year=substr(YearMon, 1, 4);
	Month=substr(YearMon, 6, 2);
	ReportDate=mdy(Month, "01", Year);
	Total=sum(Hotel, ShortStay, Camp);
	format Total comma32.0;
run;

/* Problem 1 (b) */
DATA eu_occ_total;
	SET pg1.eu_occ;
	Year=substr(YearMon, 1, 4);
	Month=substr(YearMon, 6, 2);
	ReportDate=mdy(Month, "01", Year);
	Total=sum(Hotel, ShortStay, Camp);
	format Hotel comma32.0 ShortStay comma32.0 Camp comma32.0 Total comma32.0;
	format ReportDate MONYY7.;
run;

/* Problem 1 (c) */
DATA eu_occ_total;
	SET pg1.eu_occ;
	Year=substr(YearMon, 1, 4);
	Month=substr(YearMon, 6, 2);
	ReportDate=mdy(Month, "01", Year);
	Total=sum(Hotel, ShortStay, Camp);
	format Hotel comma32.0 ShortStay comma32.0 Camp comma32.0 Total comma32.0;
	format ReportDate MONYY7.;
	Keep Country Hotel ShortStay Camp ReportDate Total;
run;

/* Problem 2 (a) */
DATA parks monuments;
	set pg1.np_summary;
	if type='NP' then
		output parks;
	else if type='NM' then
		output monuments;
run;

/* Problem 2 (b) */
DATA parks monuments;
	set pg1.np_summary;
	Campers = sum(TentCampers, RVCampers, BackcountryCampers); 
	format campers comma32.0;
	if type='NP' then
		output parks;
	else if type='NM' then
		output monuments;
run;

/* Problem 2 (c) */
DATA parks monuments;
	set pg1.np_summary;
	Campers = sum(TentCampers, RVCampers, BackcountryCampers); 
	format campers comma32.0;
	length ParkType $8;
	if type='NP' then do;
	ParkType = 'Park'; 
	output parks;
	end;
	else if type='NM' then do;
	ParkType = 'Monument';
	output monuments;
	end;
run;

/* Problem 2 (d) */
DATA parks monuments;
	set pg1.np_summary;
	Campers = sum(TentCampers, RVCampers, BackcountryCampers); 
	format campers comma32.0;
	length ParkType $8;
	if type='NP' then do;
	ParkType = 'Park'; 
	output parks;
	end;
	else if type='NM' then do;
	ParkType = 'Monument';
	output monuments;
	end;
	keep Reg ParkName DayVisits OtherLodging Campers ParkType;
run;




