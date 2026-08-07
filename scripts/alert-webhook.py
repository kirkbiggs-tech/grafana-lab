#!/usr/bin/env python3

import json
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

PROJECT_DIR = Path(__file__).resolve().parent.parent
REPORT_DIR = PROJECT_DIR / "reports"
LOG_FILE = REPORT_DIR / "alert-webhook.log"


class AlertHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        if self.path != "/alerts":
            self.send_error(404)
            return

        length = int(self.headers.get("Content-Length", "0"))
        body = self.rfile.read(length)

        try:
            payload = json.loads(body)
        except json.JSONDecodeError:
            self.send_error(400, "Invalid JSON")
            return

        REPORT_DIR.mkdir(exist_ok=True)
        timestamp = datetime.now(timezone.utc).isoformat()

        with LOG_FILE.open("a", encoding="utf-8") as log:
            log.write(f"{timestamp} {json.dumps(payload)}\n")

        print(f"Received alert at {timestamp}", flush=True)
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"OK\n")

    def log_message(self, format, *args):
        return


if __name__ == "__main__":
    server = ThreadingHTTPServer(("127.0.0.1", 5001), AlertHandler)
    print("Alert webhook listening on http://127.0.0.1:5001/alerts", flush=True)
    server.serve_forever()
