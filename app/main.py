import os
import hvac
from flask import Flask, jsonify

app = Flask(__name__)

VAULT_ADDR = os.getenv("VAULT_ADDR", "http://127.0.0.1:8200")
VAULT_TOKEN = os.getenv("VAULT_TOKEN", "")
MOUNT = "secret"
PATH = "app/database"


def get_client():
    client = hvac.Client(url=VAULT_ADDR, token=VAULT_TOKEN)
    if not client.is_authenticated():
        raise RuntimeError("Vault authentication failed")
    return client


@app.get("/health")
def health():
    return jsonify({"status": "ok", "vault": VAULT_ADDR})


@app.get("/secrets/db")
def db_secret():
    if not VAULT_TOKEN:
        return jsonify({"error": "VAULT_TOKEN not set"}), 503
    client = get_client()
    secret = client.secrets.kv.v2.read_secret_version(
        path=PATH, mount_point=MOUNT
    )
    data = secret["data"]["data"]
    return jsonify({
        "username": data.get("username"),
        "host": data.get("host"),
        "password": "***" if data.get("password") else None,
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
