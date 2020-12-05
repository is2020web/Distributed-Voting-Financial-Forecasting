del C:\xampp\htdocs\*.* /Q /F
mysql -u root --silent --skip-column-names -e "DROP DATABASE dist_vot_fin_for;"
mysql -u root --silent --skip-column-names -e "CREATE DATABASE dist_vot_fin_for CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -u root dist_vot_fin_for < .\database\dist_vot_fin_for.sql
copy .\client\*.* C:\xampp\htdocs\
copy .\server\*.* C:\xampp\htdocs\
