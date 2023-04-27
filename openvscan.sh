#!/bin/bash

# Scan network hosts for open ports
nmap -v -sS -T4 -p- -oA nmap_scan_results $1

# Scan open ports for services and versions
nmap -v -sV -T4 -oA nmap_service_scan_results --append-output --version-all $1

# Scan for vulnerabilities using OpenVAS
for host in $(cat nmap_scan_results.gnmap | grep "Status: Up" | cut -d " " -f 2); do
  echo "Scanning $host for vulnerabilities"
  sudo omp -u seu_usuario -w sua_senha --xml='<create_task><name>scan_task</name><comment>Scan for vulnerabilities on host '$host'</comment><config id="c402cc3e-b531-11e2-916a-406186ea4fc5"/><target id="'$host'"/></create_task>' > /dev/null
done

echo "Done scanning for vulnerabilities"
