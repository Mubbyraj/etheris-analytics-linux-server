#!/bin/bash
# create_users.sh
# Bulk-creates Aetheris Analytics accounts from a CSV.
# CSV format (no header): username,fullname,department
# Usage: sudo bash create_users.sh users.csv

set -euo pipefail

CSV="${1:-users.csv}"

if [ ! -f "$CSV" ]; then
    echo "CSV file not found: $CSV" >&2
    exit 1
fi

for grp in de sqa bi cit ops; do
    groupadd "$grp" 2>/dev/null || true
done

while IFS=',' read -r username fullname dept; do
    [ -z "$username" ] && continue
    useradd -m -c "$fullname" -g "$dept" -s /bin/bash "$username"
    echo "$username:ChangeMe123!" | chpasswd
    passwd -e "$username"      # force password change at first login
done < "$CSV"

echo "Done. Created accounts from $CSV."
