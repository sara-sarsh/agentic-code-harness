# SKILL: Flask & REST API Patterns

## Core Constraints
- Keep route handlers thin (< 30 lines). Delegate business logic to dedicated service classes or domain engines.
- Validate request payloads explicitly before processing. Return clear JSON error structures with appropriate HTTP status codes (400, 401, 403, 404, 422, 500).
- Never modify database models (`models.py`) or generate Alembic/Flask-Migrate migrations without explicit human approval.

## Testing Standards
- Test endpoints using Flask test client:
  ```python
  def test_endpoint_success(client):
      response = client.post("/api/v1/resource", json={"key": "val"})
      assert response.status_code == 200
      assert response.get_json()["status"] == "success"
  ```
- Always mock external HTTP requests, background queues, or third-party SDK calls in unit tests.
