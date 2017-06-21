#!/bin/bash
echo Date Checked: > /git/TIMBS/db/results
date >>/git/TIMBS/db/results
echo -----------------Inventory Past Warranty Date \(Hostname\|Serial Number\|Warranty Date\) ---------- >>/git/TIMBS/db/results
cat /git/TIMBS/db/query.sql|sqlite3 /git/TIMBS/db/development.sqlite3 >> /git/TIMBS/db/results
echo --------------------------------------------------------- >>/git/TIMBS/db/results
a=`date`
echo The items attached have exceeded their warranty date according to our records. Please investigate further and replace where needed. | mail -a "/git/TIMBS/db/results" -s "Inventory Past Warranty Date: $a" jlanyon99@gmail.com

