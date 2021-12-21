#! /bin/bash
echo 'The Path where Log4J Vulnerability is being looked up >>' $1 
grep -r --include *.[wj]ar "JndiLookup.class" $1 2>&1 | tr " " "," > Detected_Log4J_vuln.csv
