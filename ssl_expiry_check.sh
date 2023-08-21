#!/bin/bash

# Read the list of domains from a file (one domain per line)
while IFS= read -r domain; do
  expiry_date=$(echo | openssl s_client -connect "$domain":443 2>/dev/null | openssl x509 -noout -dates | grep "notAfter" | cut -d "=" -f 2)
  expiry_unix=$(date -d "$expiry_date" +%s)
  current_unix=$(date +%s)
  days_left=$(( (expiry_unix - current_unix) / 86400 ))

  if [ "$days_left" -lt 32320 ]; then
    message="SSL Expiry Alert\n* Domain : $domain\n* Warning : The SSL certificate for $domain will expire in $days_left days."
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "${SLACK_WEBHOOK_URL}"
  fi
done < domains.txt
