
#!/bin/bash

service postfix restart
service dovecot start

cron -f