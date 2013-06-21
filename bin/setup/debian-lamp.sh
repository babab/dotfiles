# Quick setup of Apache, MySQL and PHP on Debian 7 (wheezy)

apt-get install vim nano- openssh-server sudo tmux git tig
update-alternatives --config editor
visudo
apt-get update
apt-get install apache2 php5 mysql-server
apt-get install phpmyadmin
a2enmod rewrite
a2enmod auth_digest
service apache2 stop
mkdir /var/www/default
mv /var/www/index.html /var/www/default/_index.html

echo "<VirtualHost *:80>
    ServerAdmin ${USER}@$(hostname)
    DocumentRoot /var/www/default
    #ServerName
    #ServerAlias

    <Directory />
        Options FollowSymLinks
        AllowOverride None
    </Directory>
    <Directory /var/www/default/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order allow,deny
        allow from all
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/default-error.log
    # debug, info, notice, warn, error, crit, alert or emerg
    LogLevel warn
    CustomLog ${APACHE_LOG_DIR}/default-access.log combined

#   ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
#   <Directory "/usr/lib/cgi-bin">
#       AllowOverride None
#       Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
#       Order allow,deny
#       Allow from all
#   </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/default
service apache2 start
