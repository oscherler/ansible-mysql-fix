#!/bin/bash

# mysqld_safe does not work really well here
/usr/local/mysql/bin/mysqld --initialize-insecure
/usr/local/mysql/bin/mysql_ssl_rsa_setup
/usr/local/mysql/bin/mysqld --skip-networking &
pid="$!"

mysql=( /usr/local/mysql/bin/mysql --protocol=socket -uroot )

for i in {30..0}; do
	if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
		break
	fi
	sleep 1
	echo 'MySQL init process in progress...'
done

{ \
	echo "CREATE USER 'root'@'%' IDENTIFIED BY '';"; \
	echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"; \
	echo "INSTALL PLUGIN auth_socket SONAME 'auth_socket.so';"; \
} | "${mysql[@]}"

if ! kill -s TERM "$pid" || ! wait "$pid"; then
	echo >&2 'MySQL init process failed.'
	exit 1
fi

echo
echo 'MySQL init process done. Ready for start up.'
echo

exec "$@"
