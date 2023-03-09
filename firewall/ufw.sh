
# UFW script
#
#   230301  PLH     First version
#
FUTUREBOX=77.72.50.240
FUTUREBOXNET=10.11.131.0/24
SERVER1=40.85.133.90
SERVER3=77.72.50.82
ADMIN=87.61.93.103

#ufw reset
#ufw default allow outgoing
#ufw default deny incoming


# allow all

ufw allow from $FUTUREBOX
ufw allow from $ADMIN

# ntp

ufw allow 123/udp

# ssh

ufw allow proto tcp from $FUTUREBOX to any port ssh
ufw allow proto tcp from $FUTUREBOXNET to any port ssh

# mysql

#ufw allow proto tcp from x to any port 3306

# mail

ufw limit "Postfix"
#ufw limit "Postfix SMTPS"
#ufw limit "Postfix Submission"

# apache

#ufw allow "Apache"
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow proto tcp from $SERVER1 to any port 80
ufw allow proto tcp from $SERVER1 to any port 443

# do not log

#ufw deny from 44.200.239.121

echo "\nDeny and do not log services\n"
#ufw deny 23/tcp         # telnet
#ufw deny "Apache Secure"        # do not log
#ufw deny 161/udp        # snmp
#ufw deny 529/udp        # irc
#ufw deny 1433/tcp       # ms sqlserver
#ufw deny 1900/udp       # ssdp unpnp

#ufw deny 53/udp         # dns attack
#ufw deny 3306/tcp       # Mysql
#ufw deny 3128/tcp       # often used for proxy
#ufw deny 3389/tcp       # remote desktop
#ufw deny 4899/tcp       # radmin remote admin
#ufw deny 5060           # sip
#ufw deny 8080/tcp       # www proxy
#ufw deny 8291/tcp       # winbox vuln.
#ufw deny 53413/udp      # Netis vunerability
#ufw deny 5358/tcp       # adsl hack
#ufw deny 7547/tcp       # adsl hack

ufw enable
