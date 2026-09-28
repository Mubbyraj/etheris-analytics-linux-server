#!/bin/bash
# ssh-ratelimit.sh
# Opens SSH on a non-default port and applies a firewalld rich rule
# that limits new connections, to slow (not stop) brute-force scanning.
#
# NOTE: firewalld's `limit` applies to the rule as a whole, not per
# source IP, and reject-type rich rules are evaluated before accept
# rules at the same priority. Test a normal login still works after
# applying this before you rely on it. For true per-IP throttling,
# use fail2ban or an nftables meter instead.

set -e
PORT=2222

firewall-cmd --permanent --add-port=${PORT}/tcp

firewall-cmd --permanent --add-rich-rule=\
  "rule family='ipv4' port port=${PORT} protocol='tcp' \
   limit value='4/m' accept"

firewall-cmd --permanent --add-rich-rule=\
  "rule family='ipv4' port port=${PORT} protocol='tcp' reject"

firewall-cmd --reload
echo "SSH rate limiting active on port ${PORT} (approx. 4 new conns/min, rule-wide)."
firewall-cmd --list-rich-rules
