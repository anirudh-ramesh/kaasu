#!/bin/sh

echo "date,transactionNumber,transactionInfo,points,valueAmount_O,valueAmount_₹,direction" > /destination/card.csv

for file in /source/*; do

	tail -n +9 "$file" >> /destination/card.csv

done
