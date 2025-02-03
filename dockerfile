FROM debian:bullseye

# Install necessary packages
RUN apt-get update
RUN apt-get install debconf nano mutt mailutils -y
RUN echo "postfix postfix/mailname string jdelrey.local" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'localhost'" | debconf-set-selections
RUN apt-get install postfix dovecot-core dovecot-imapd -y

COPY postfix_config/main.cf /etc/postfix/
COPY dovecot/10-auth.conf /etc/dovecot/conf.d/
COPY dovecot/10-mail.conf /etc/dovecot/conf.d/

# RUN echo "127.0.0.1 mail" >> /etc/hosts


RUN service postfix restart
RUN service dovecot restart

# Expose Apache2 ports
EXPOSE 80

# Set entrypoint
CMD ["tail","-f","/dev/null"]
