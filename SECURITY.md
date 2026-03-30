# Security Policy

## Supported Versions

| Version | Supported          |
|---------|--------------------|
| 1.x     | ✅ Active support  |
| < 1.0   | ❌ End of life     |

## Reporting a Vulnerability

We take security vulnerabilities seriously. **Please do not open a public
GitHub issue for security bugs.**

### How to Report

1. **Email**: Send a detailed report to `security@yourdomain.com` with:
   - A description of the vulnerability
   - Steps to reproduce
   - Potential impact assessment
   - Any suggested mitigations (optional)

2. **GitHub Security Advisories**: Use the
   [private vulnerability reporting](https://github.com/yourusername/pyproxy/security/advisories/new)
   feature on this repository.

### What to Expect

| Milestone                          | Target SLA |
|------------------------------------|-----------|
| Acknowledgement of your report     | 48 hours  |
| Confirmed / not confirmed decision | 5 days    |
| Patch released (if confirmed)      | 30 days   |
| Public disclosure                  | 90 days or after patch ships |

We follow a **coordinated disclosure** policy. We will credit you in the
release notes unless you request anonymity.

### Scope

In scope:
- Authentication bypass
- SSRF protection bypass
- TLS downgrade or cipher weakness
- Header injection / sanitisation bypass
- Denial-of-service via the proxy layer
- Information disclosure

Out of scope:
- Vulnerabilities in end-user operating systems or third-party dependencies
- Social engineering attacks
- Issues without a clear security impact

### PGP Key

Our security contact PGP key is available at
`https://yourdomain.com/.well-known/security.txt`.

Thank you for helping keep PyProxy secure.
