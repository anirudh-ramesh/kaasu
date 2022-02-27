#!/bin/sh

echo "date,transactionNumber,transactionInfo,points,valueAmount_O,valueAmount_₹,direction" > /destination/card.csv

for file in /source/*; do

	content=`tail -n +9 "$file"`

	echo $content >> /destination/card.csv

done
