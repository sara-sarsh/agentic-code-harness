# VISUAL CASE STUDY: VIBE CODING VS. SURGICAL DIFF

This document illustrates the exact difference between undisciplined "vibe coding" and disciplined "surgical diffing".

---

## Scenario: Task is to "Add timeout support to `fetch_user_data`"

### Original Code (`api_client.py`)
```python
# WARNING: Legacy endpoint, do not change user agent header without ops sign-off
USER_AGENT = "InternalAcademyBot/1.0"

def fetch_user_data(user_id):
    """
    Retrieves user profile and telemetry.
    Returns dict or raises ConnectionError.
    """
    url = f"https://api.internal/users/{user_id}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read().decode("utf-8"))

def log_audit_trail(event_name):
    # audit helper
    syslog.syslog(syslog.LOG_INFO, f"AUDIT: {event_name}")
```

---

## ❌ The "Vibe Coding" Diff (What Agents Do Without Harness)

Notice how the agent over-refactored, deleted the warning comment, reformatted docstrings, changed requests library, and touched unrelated functions:

```diff
- # WARNING: Legacy endpoint, do not change user agent header without ops sign-off
- USER_AGENT = "InternalAcademyBot/1.0"
+ DEFAULT_TIMEOUT = 10

- def fetch_user_data(user_id):
-     """
-     Retrieves user profile and telemetry.
-     Returns dict or raises ConnectionError.
-     """
-     url = f"https://api.internal/users/{user_id}"
-     req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
-     with urllib.request.urlopen(req) as resp:
-         return json.loads(resp.read().decode("utf-8"))
+ def fetch_user_data(user_id: int, timeout: int = DEFAULT_TIMEOUT) -> dict:
+     # Cleaned up using requests library for better modern python standards
+     response = requests.get(f"https://api.internal/users/{user_id}", timeout=timeout)
+     return response.json()

- def log_audit_trail(event_name):
-     # audit helper
-     syslog.syslog(syslog.LOG_INFO, f"AUDIT: {event_name}")
+ def log_audit_trail(event_name: str) -> None:
+     """Log audit event to syslog."""
+     syslog.syslog(syslog.LOG_INFO, f"AUDIT: {event_name}")
```

### Why this is a Disaster:
1. Deleted the ops team's critical `# WARNING` comment.
2. Replaced `urllib` with `requests` without checking `requirements.txt`.
3. Added types and docstrings to `log_audit_trail` (completely outside task scope).
4. Blast radius is massive: breaks runtime if `requests` isn't installed.

---

## ✅ The "Surgical Diff" (What Agentic Code Harness Enforces)

The agent changes **only** the lines required for timeout, keeps all comments and docstrings intact, and leaves surrounding functions alone:

```diff
  # WARNING: Legacy endpoint, do not change user agent header without ops sign-off
  USER_AGENT = "InternalAcademyBot/1.0"
  
- def fetch_user_data(user_id):
+ def fetch_user_data(user_id, timeout=10):
      """
      Retrieves user profile and telemetry.
      Returns dict or raises ConnectionError.
      """
      url = f"https://api.internal/users/{user_id}"
      req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
-     with urllib.request.urlopen(req) as resp:
+     with urllib.request.urlopen(req, timeout=timeout) as resp:
          return json.loads(resp.read().decode("utf-8"))
  
  def log_audit_trail(event_name):
      # audit helper
      syslog.syslog(syslog.LOG_INFO, f"AUDIT: {event_name}")
```

### Why this is Safe & Professional:
1. Exact zero impact on unrelated code.
2. Existing docstrings and comments preserved verbatim.
3. No dependency changes.
4. Predictable, minimal blast radius.

