#!/bin/bash

# Specify the critical files to check
files=("etc/passwd" "etc/shadow" "/bin/bash")

# Calculate and compare checksums
for file in "${files[@]}"; do
  checksum=$(md5sum "$file" | awk '{print $1}')
  if [[ $checksum != "expected_checksum" ]]; then
    echo "Integrity compromised for $file"
  fi
done
