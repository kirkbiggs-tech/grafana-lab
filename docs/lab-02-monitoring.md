# Lab 02: DevOps Monitoring

## Objective

Create an automated Linux health-check script.

## Script

scripts/health-check.sh

## Checks Performed

- Date and time
- Server hostname
- Current user
- System uptime
- Disk usage
- Memory usage
- Grafana service status

## Results

- Server: grafana
- Uptime: 5 days
- Root disk usage: 67%
- Available memory: approximately 1.7 GiB
- Grafana service: active

## DevOps Connection

This lab represents the Monitor stage of the DevOps lifecycle.

Plan -> Build -> Test -> Release -> Deploy -> Monitor -> Improve

Monitoring provides feedback about application and infrastructure
health. Teams use this information to detect problems and plan
improvements.

## Skills Practiced

- Bash scripting
- Linux system commands
- Service monitoring
- File permissions
- Git version control
- DevOps documentation
