FROM scrapinghub/splash:master

ADD ./tor.list  /etc/apt/sources.list.d/tor.list
RUN curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        tor deb.torproject.org-keyring

#RUN echo "fs.file-max = 2147483584" >> /etc/sysctl.conf && \
#    echo "# Increase number of incoming connections backlog" >> /etc/sysctl.conf && \
#    echo "net.core.somaxconn = 65536" >> /etc/sysctl.conf && \
#    echo "net.ipv4.tcp_max_syn_backlog=16384" >> /etc/sysctl.conf && \
#    echo "net.core.netdev_max_backlog=16384" >> /etc/sysctl.conf && \
#    echo "# Local Port Range" >> /etc/sysctl.conf && \
#    echo "net.ipv4.ip_local_port_range=1000 65535" >> /etc/sysctl.conf && \
#    echo "# Read/Write Buffer for TCP connections:" >> /etc/sysctl.conf && \
#    echo "net.core.rmem_default=262144" >> /etc/sysctl.conf && \
#    echo "net.core.wmem_default=262144" >> /etc/sysctl.conf && \
#    echo "net.core.rmem_max=16777216" >> /etc/sysctl.conf && \
#    echo "net.core.wmem_max=16777216" >> /etc/sysctl.conf && \
#    echo "net.core.optmem_max=16777216" >> /etc/sysctl.conf && \
#    echo "net.ipv4.tcp_rmem=1024 4096 16777216" >> /etc/sysctl.conf && \
#    echo "net.ipv4.tcp_wmem=1024 4096 16777216" >> /etc/sysctl.conf && \
#    echo "# The TIME-WAIT Buckets Pool, Recycling and Reuse" >> /etc/sysctl.conf && \
#    echo "net.ipv4.tcp_max_tw_buckets=1048576" >> /etc/sysctl.conf && \
#    echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf && \
#    echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf && \
#    echo "# Timeout for FIN-WAIT-2 socket" >> /etc/sysctl.conf && \
#    echo "net.ipv4.tcp_fin_timeout = 15" >> /etc/sysctl.conf 
#
#RUN echo "*        soft   nofile      65536" >> /etc/security/limits.conf && \
#    echo "*        hard   nofile      65536" >> /etc/security/limits.conf && \
#    echo "root        soft   nofile      65536" >> /etc/security/limits.conf && \
#    echo "root        hard   nofile      65536" >> /etc/security/limits.conf
#
#RUN echo "session    required     pam_limits.so" >> /etc/pam.d/common-session
#RUN echo "session    required     pam_limits.so" >> /etc/pam.d/common-session-noninteractive
#
#RUN sed -i 's/^#DefaultLimitNOFILE=/DefaultLimitNOFILE=65536/g' /etc/systemd/system.conf

RUN echo "HiddenServiceStatistics 0" >> /etc/tor/torrc && \
    echo "ConnLimit 32768 " >> /etc/tor/torrc && \
    echo "SocksTimeout 620" >> /etc/tor/torrc && \
    echo "SafeLogging 0" >> /etc/tor/torrc && \
    echo "ControlPort 9051" >> /etc/tor/torrc && \
    echo "# make 'tor --quiet --hash-password password'" >> /etc/tor/torrc && \
    echo "# password is 'password'" >> /etc/tor/torrc && \
    echo "HashedControlPassword 16:EAC87D69574E4A7160E42379D1EAAD4CBE6FB84D350ADA833ECAEAB9E7" >> /etc/tor/torrc && \
    echo "CookieAuthentication 0" >> /etc/tor/torrc && \
    echo "#Log info stdout" >> /etc/tor/torrc

ADD ./splash.sh /tmp/splash.sh
RUN chmod +x /tmp/splash.sh

EXPOSE 8050 5023 9051 9050

ENTRYPOINT ["/tmp/splash.sh"]
