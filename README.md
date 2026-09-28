# Aetheris Analytics — Hardened Linux Server (CIT6314 Project)

A hardened AlmaLinux 9.8 server built for a fictional 70-employee data
analytics company, as a university System Administration project.
Runs in a UTM (QEMU) VM on Apple Silicon macOS.

## Problem statement

Aetheris Analytics' infrastructure was fragmented. The project consolidates
it into a single secure Linux server with department-based access control,
core internal services, and a hardened perimeter.

## Stack

| Layer | Choice |
|---|---|
| Distribution | AlmaLinux OS 9.8 (aarch64) |
| Hypervisor | UTM 4.x (QEMU) on Apple Silicon |
| Access control | Users/groups per department + POSIX ACLs, SELinux enforcing |
| Services | OpenSSH (key-only, port 2222), Apache + self-signed TLS, Samba |
| Firewall | firewalld, default-deny |
| Audit | Lynis |
| Monitoring | cron + custom disk-usage alerting |

## Departments

| Group | Headcount |
|---|---|
| Data Engineering (de) | 20 |
| Software QA (sqa) | 12 |
| Business Intelligence (bi) | 13 |
| Cybersecurity & IT (cit) | 15 |
| Operations & HR (ops) | 10 |

## Repo layout

```
docs/           full technical report + interview prep handbook
screenshots/    evidence for each configuration step
scripts/        create_users.sh, ssh-ratelimit.sh, disk_check.sh
configs/        sanitized config samples (no real keys/passwords)
```

## Key results

- [ ] Lynis hardening index: fill in once the audit is run
- [ ] All 5 department shares live on Samba
- [ ] SSH hardened to key-only auth on port 2222

## Lessons learned

See `docs/CIT6314_Report.pdf`, Section 7.2.

## What's intentionally excluded

Real SSH private keys, Samba password files, and the real student ID
are not committed — see `.gitignore`.
