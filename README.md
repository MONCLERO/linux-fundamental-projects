# Automated Server Health Check Script

### Objective
Replace manual daily health checks (nginx status, disk space, mount verification) with a single automated, logged Bash script.

### File
healthcheck-script/healthcheck.sh

---

## What it does:

- Prints a timestamp for the check
- Captures NGINX's live status via systemctl is-active and reports UP/DOWN using -       conditional logic
- Reports available disk space on /
- Verifies a mount point's existence using a -d directory test
- Appends (not overwrites) every run to a persistent log file, building a running history

---

## Key concepts demonstrated:

- Command substitution ($(...)) to capture command output into variables

- Conditional logic (if/else) for string comparisons and file/directory tests

- Output redirection: The "exec >> logfile 2>&1" to capture both stdout and stderr for the entire script in one line, rather than redirecting per statement

- Exit code behavior under set -e: Discovered firsthand that set -e terminates a script immediately on any non-zero exit code — including from a command captured into a variable — and that intentionally "expected" failures (like a service being down) need to be explicitly handled with '' || true '' so the script can report the failure instead of dying before it gets the chance to


**Debugging highlight:** Traced a misleading "silent script death" back to set -e reacting to systemctl is-active returning non-zero when NGINX was down — the exact scenario the script was built to detect and report. Fixed by explicitly suppressing the expected failure (|| true) while keeping set -e active for genuine unexpected errors elsewhere in the script.

---

## Environment

- **Ubuntu (via WSL2)**
- **Bash** 
- **systemd, NGINX, ext4**

---

## Notes

This repo is a working log of hands-on Linux/DevOps practice — commands, real terminal output, real errors, and the actual troubleshooting process, not just the finished solution.

---

## Author
Cyril Meshach - [@monclero](https://github.com/MONCLERO)