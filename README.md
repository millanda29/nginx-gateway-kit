# 🚀 NGINX API Gateway Boilerplate

> 🧑‍💻 Developed and maintained by [Isaac Llanda]([millanda29](https://github.com/millanda29)) — this is a personal, community-driven boilerplate for API Gateway setups using **NGINX** and **Docker**, optimized for local and production use.

A modular API Gateway powered by **NGINX**, designed for routing, load balancing, security, caching, and more — deployable in both **local development** and **production**. Includes optional CI/CD via **GitHub Actions** and example use case.

---

## 🔧 Key Features

- ✅ Pre-built NGINX templates for common gateway use cases:
  - Reverse proxy
  - Weighted load balancing
  - JWT validation
  - Rate limiting
  - Path-based routing
  - Caching
  - HTTPS with SSL
- 🐳 Fully containerized setup using Docker
- 🔁 Templates dynamically injected with environment variables via `envsubst`
- 📦 Includes real-world working example in `example/`
- 🚀 CI/CD workflow with GitHub Actions and EC2-ready deploy script
- 🧩 Designed for extensibility and contributions

---

## 📁 Project Structure

```plaintext
nginx-gateway-kit/
│
├── .github/
│   └── workflows/
│       └── deploy.yml               # Main CI/CD pipeline
│
├── example/                         # ✅ Working example
│   ├── .env                         # Sample environment
│   ├── docker-compose.yml          # Runs the gateway with this config
│   ├── nginx/
│   │   ├── Dockerfile
│   │   ├── entrypoint.sh
│   │   └── default.template.conf
│   └── .github/
│       └── workflows/
│           └── deploy.yml
│
├── nginx/
│   ├── Dockerfile                   # Base NGINX image
│   ├── entrypoint.sh                # Generates nginx.conf using envsubst
│   ├── default.template.conf        # Base gateway config (customizable)
│   └── templates/                   # Alternate templates
│       ├── default.basic.conf
│       ├── default.loadbalance.conf
│       ├── default.path-routing.conf
│       ├── default.jwt-auth.conf
│       ├── default.rate-limit.conf
│       ├── default.cache.conf
│       └── default.ssl.conf
│
├── .env.example                    # Template for local development
├── docker-compose.yml             # Docker Compose (manual/custom use)
├── .gitignore                     # Ignore sensitive and build files
└── README.md                      # You're here 🎉
````

---

## 🧪 Local Development

You can launch the gateway in **two ways**:

### ✅ Option 1: Quickstart with `example/`

```bash
# Clone this repository
git clone https://github.com/millanda29/nginx-gateway-kit.git
cd nginx-gateway-kit

# Optionally, use the working example
cd example
cp .env.example .env
docker-compose up --build -d

```

Access it at: [http://localhost](http://localhost)

### 🛠 Option 2: Custom setup from root

1. Create a `.env` file based on `.env.example`:

```env
SERVICE1_HOST=host.docker.internal
SERVICE1_PORT=3001
SERVICE2_HOST=host.docker.internal
SERVICE2_PORT=3002
SERVICE3_HOST=host.docker.internal
SERVICE3_PORT=3003
SERVICE4_HOST=host.docker.internal
SERVICE4_PORT=3004
```

2. Run the gateway:

```bash
docker-compose up --build -d
```

---

## ⚙️ How It Works

* The gateway uses `default.template.conf` as a base and injects environment variables like `${SERVICE1_HOST}` via `envsubst`.
* The `entrypoint.sh` generates the final `nginx.conf` dynamically before starting NGINX.
* The structure allows easy switching between preconfigured templates.

---

## ☁️ CI/CD Deployment with GitHub Actions

This repo includes a ready-to-go GitHub Actions deployment workflow.

### ✅ Prerequisites

| Requirement    | Description                          |
| -------------- | ------------------------------------ |
| Ubuntu server  | With SSH access                      |
| GitHub Secrets | Add all env vars and SSH credentials |

Required secrets:

* `EC2_HOST`, `EC2_USER`, `EC2_SSH_KEY`
* `SERVICE1_HOST`, `SERVICE1_PORT`, etc.

### 🔁 Workflow Triggers

* `push` to `dev`, `qa`, `test`
* `pull_request` to `main`
* Manual via GitHub UI (`workflow_dispatch`)

### What It Does

* Connects to server over SSH
* Installs Docker + Compose if missing
* Deploys using `docker-compose` with secrets as environment variables

📄 See: [`deploy.yml`](.github/workflows/deploy.yml)

---

## 🔄 NGINX Config Templates

Switch templates to match your use case:

| Template File               | Use Case                         |
| --------------------------- | -------------------------------- |
| `default.basic.conf`        | Basic round-robin load balancing |
| `default.loadbalance.conf`  | Weighted upstreams               |
| `default.path-routing.conf` | Route by path prefix             |
| `default.jwt-auth.conf`     | JWT-based authentication         |
| `default.rate-limit.conf`   | Rate limiting for clients        |
| `default.cache.conf`        | Response caching                 |
| `default.ssl.conf`          | HTTPS support with certs         |

Example:

```bash
cp nginx/templates/default.ssl.conf nginx/default.template.conf
docker-compose restart
```

---

## 🛠 Useful Docker Commands

```bash
docker logs api-gateway             # View logs
docker-compose down                # Stop and remove containers
docker-compose up --build -d       # Rebuild and run
```

---

## 🔐 Security Best Practices

* Use `.env.example` for public structure — don’t commit real `.env` files.
* Use **GitHub Secrets** for production environments.
* Backend services must listen on `0.0.0.0` to be reachable from the gateway.
* SSL certs (for `default.ssl.conf`) must be mounted to `/etc/nginx/certs`.

---

## 💡 Tips & Extensions

* Run multiple environments (dev, test, prod) with different `.env` and templates.
* Use gzip, compression, cache-control headers for performance.
* Integrate with [Certbot](https://certbot.eff.org/) to automate SSL certificates.
* Connect to observability tools: Prometheus, Fluentd, Fail2Ban, etc.

---

## 🤝 Contributing

This project is open to contributions — new templates, issues, pull requests, and improvements are welcome!

Fork it, try it, and share what works best for your stack 🚀

---

## 📜 License

MIT License © 2025 — Maintained by [Isaac Llanda](https://github.com/your-username)

---

Happy gatewaying! 🌐✨
