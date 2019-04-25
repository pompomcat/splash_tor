#! /bin/bash

trap 'kill $(jobs -p)' INT

ulimit -n 32768

/usr/bin/tor -f /etc/tor/torrc --hush &

python3 /app/bin/splash --proxy-profiles-path /etc/splash/proxy-profiles \
			--js-profiles-path /etc/splash/js-profiles \
			--filters-path /etc/splash/filters \
			--lua-package-path /etc/splash/lua_modules/?.lua \
			--max-timeout 610 &

wait
