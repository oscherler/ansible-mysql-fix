DB_VERSIONS = \
	mariadb-5.2.11 \
	mariadb-5.2.14 \
	mariadb-5.2.3 \
	mariadb-5.3.12 \
	mariadb-5.3.5 \
	mariadb-5.5.23 \
	mariadb-5.5.50 \
	mysql-5.0.96 \
	mysql-5.1.72 \
	mysql-5.5.50 \
	mysql-5.5.8 \
	mysql-5.6.31 \
	mysql-5.7.13

.PHONY: download $(DB_VERSIONS)

download: $(DB_VERSIONS)

$(DB_VERSIONS):
	$(MAKE) -C $@ download
