#!/bin/sh


# Product Issuer Name: ICICI Bank
# Product Category: Credit Card
# Product Name: Coral Visa

for file in /source/ICICI_Bank__Credit_Card__Coral_Visa/*; do

	tail -n +9 "$file" > "$file".transactions.csv

	accountNumber=`head -n 1 "$file" | cut -d"'" -f2`

	sqlite3 /store.db "DELETE FROM \"ICICI_Bank__Credit_Card__Coral_Visa__file\"";
	sqlite3 -separator ',' /store.db ".import \"$file.transactions.csv\" \"ICICI_Bank__Credit_Card__Coral_Visa__file\""
	sqlite3 /store.db "UPDATE \"ICICI_Bank__Credit_Card__Coral_Visa__file\" SET \"direction\" = 'C' WHERE \"direction\" = 'CR';"
	sqlite3 /store.db "UPDATE \"ICICI_Bank__Credit_Card__Coral_Visa__file\" SET \"direction\" = 'D' WHERE \"direction\" = '';"
	sqlite3 /store.db "INSERT INTO \"ICICI_Bank__Credit_Card__Coral_Visa__warehouse\" (\"date\", \"transactionNumber\", \"transactionInfo\", \"points\", \"valueAmount_O\", \"valueAmount_₹\", \"direction\", \"accountNumber\") SELECT *, '$accountNumber' FROM \"ICICI_Bank__Credit_Card__Coral_Visa__file\" ORDER BY 2";
	sqlite3 /store.db "DELETE FROM \"ICICI_Bank__Credit_Card__Coral_Visa__file\"";

	rm "$file".transactions.csv

done


# Product Issuer Name: ICICI Bank
# Product Category: Current Account
# Product Name: X

for file in /source/ICICI_Bank__Current_Account__X/*.xls; do

	# ssconvert "$file" "$file".csv
	xls2csv "$file" > "$file".csv

	# tail -n +8 "$file".csv > "$file".transactions.csv
	tail -n +8 "$file".csv | head -n -1 > "$file".transactions.csv

	accountNumber=`head -6 "$file".csv | tail -1 | cut -d'"' -f2 | cut -d'-' -f4 | sed 's/ //g'`

	rm "$file".csv

	sqlite3 /store.db "DELETE FROM \"ICICI_Bank__Current_Account__X__file\";"
	sqlite3 -separator ',' /store.db ".import \"$file.transactions.csv\" \"ICICI_Bank__Current_Account__X__file\""
	sqlite3 /store.db "UPDATE \"ICICI_Bank__Current_Account__X__file\" SET \"direction\" = 'C' WHERE \"direction\" = 'CR'";
	sqlite3 /store.db "UPDATE \"ICICI_Bank__Current_Account__X__file\" SET \"direction\" = 'D' WHERE \"direction\" = 'DR'";
	sqlite3 /store.db "UPDATE \"ICICI_Bank__Current_Account__X__file\" SET \"chequeNumber\" = '' WHERE \"chequeNumber\" = '-';";
	sqlite3 /store.db "INSERT INTO \"ICICI_Bank__Current_Account__X__warehouse\" (\"transactionId\", \"valueDate\", \"txnpostDate\", \"chequeNumber\", \"description\", \"direction\", \"transactionAmt\", \"balanceAmt\", \"accountNumber\") SELECT \"transactionId\", \"valueDate\", SUBSTRING(\"txnpostDate\", 1, 22), \"chequeNumber\", \"description\", \"direction\", \"transactionAmt\", \"balanceAmt\", '$accountNumber' FROM \"ICICI_Bank__Current_Account__X__file\" ORDER BY 2";
	sqlite3 /store.db "DELETE FROM \"ICICI_Bank__Current_Account__X__file\";"

	rm "$file".transactions.csv

done

cp /store.db /destination/store.db
