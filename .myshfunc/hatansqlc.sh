hatansqlc() {
# Usage: hatansqlc db_file sql_script
echo -e "\x1b[92msql query processor by hatan\x1b[0m"
if test -z "$1"; then
	echo -e "\x1b[91mError: You must provide a database file.\x1b[0m"
	return 1
fi
if test -z "$2"; then
	echo -e "\x1b[91mError: You must provide an SQL script file.\x1b[0m"
	return 1
fi
user_db="$1"
sql_script="$2"
echo -e "\x1b[92mdatabase: \x1b[93m${user_db}\x1b[0m"
echo -e "\x1b[92msql script: \x1b[93m${sql_script}\x1b[92m\x1b[0m"
sqlite3 "${user_db}" < "${sql_script}"
}
