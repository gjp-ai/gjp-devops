# os-setup

Automated macOS setup scripts for developer tooling.

These scripts are designed for modern macOS releases, including macOS 26.

## Prerequisites

- macOS
- Internet access
- A user account with `sudo` access

## Folder Structure

Each folder contains `install.sh`, `update.sh`, and `uninstall.sh` scripts.

```
mac-os/
├── install.sh           # Install ALL tools at once
├── update.sh            # Update ALL tools at once
├── uninstall.sh         # Uninstall ALL tools at once
├── lib/                 # Shared helper library (common.sh)
├── xcode-clt/          # Xcode Command Line Tools
├── xcode/              # Full Xcode app
├── homebrew/            # Homebrew package manager
├── languages/           # Programming languages & runtimes
│   ├── java/            #   OpenJDK 21
│   ├── nodejs/          #   nvm + Node.js
│   └── python/          #   uv + Python
├── databases/           # Database servers
│   ├── mariadb/         #   MariaDB
│   └── mysql/           #   MySQL
├── containers/          # Container platforms
│   └── docker/          #   Docker Desktop
├── build-tools/         # Build tools
│   └── gradle/          #   Gradle
├── environment/         # Environment variable management
└── applications/        # Desktop applications
    ├── dbeaver/         #   DBeaver Community
    ├── postman/         #   Postman
    └── openclaw/        #   OpenClaw
```

## Script List

### Xcode Command Line Tools

| Action | Script |
|---|---|
| Install | `mac-os/xcode-clt/install.sh` |
| Update | `mac-os/xcode-clt/update.sh` |
| Uninstall | `mac-os/xcode-clt/uninstall.sh` |

### Xcode

| Action | Script |
|---|---|
| Install | `mac-os/xcode/install.sh` |
| Update | `mac-os/xcode/update.sh` |
| Uninstall | `mac-os/xcode/uninstall.sh` |

### Homebrew

| Action | Script |
|---|---|
| Install | `mac-os/homebrew/install.sh` |
| Update | `mac-os/homebrew/update.sh` |
| Uninstall | `mac-os/homebrew/uninstall.sh` |

### Python (uv)

| Action | Script |
|---|---|
| Install | `mac-os/languages/python/install.sh` |
| Update | `mac-os/languages/python/update.sh` |
| Uninstall | `mac-os/languages/python/uninstall.sh` |

### Java (OpenJDK 21)

| Action | Script |
|---|---|
| Install | `mac-os/languages/java/install.sh` |
| Update | `mac-os/languages/java/update.sh` |
| Uninstall | `mac-os/languages/java/uninstall.sh` |

### Node.js (nvm)

| Action | Script |
|---|---|
| Install | `mac-os/languages/nodejs/install.sh` |
| Update | `mac-os/languages/nodejs/update.sh` |
| Uninstall | `mac-os/languages/nodejs/uninstall.sh` |

### MariaDB

| Action | Script |
|---|---|
| Install | `mac-os/databases/mariadb/install.sh` |
| Update | `mac-os/databases/mariadb/update.sh` |
| Uninstall | `mac-os/databases/mariadb/uninstall.sh` |

### MySQL

| Action | Script |
|---|---|
| Install | `mac-os/databases/mysql/install.sh` |
| Update | `mac-os/databases/mysql/update.sh` |
| Uninstall | `mac-os/databases/mysql/uninstall.sh` |

### Docker Desktop

| Action | Script |
|---|---|
| Install | `mac-os/containers/docker/install.sh` |
| Update | `mac-os/containers/docker/update.sh` |
| Uninstall | `mac-os/containers/docker/uninstall.sh` |

### Gradle

| Action | Script |
|---|---|
| Install | `mac-os/build-tools/gradle/install.sh` |
| Update | `mac-os/build-tools/gradle/update.sh` |
| Uninstall | `mac-os/build-tools/gradle/uninstall.sh` |

### DBeaver Community

| Action | Script |
|---|---|
| Install | `mac-os/applications/dbeaver/install.sh` |
| Update | `mac-os/applications/dbeaver/update.sh` |
| Uninstall | `mac-os/applications/dbeaver/uninstall.sh` |

### Postman

| Action | Script |
|---|---|
| Install | `mac-os/applications/postman/install.sh` |
| Update | `mac-os/applications/postman/update.sh` |
| Uninstall | `mac-os/applications/postman/uninstall.sh` |

### OpenClaw

| Action | Script |
|---|---|
| Install | `mac-os/applications/openclaw/install.sh` |
| Update | `mac-os/applications/openclaw/update.sh` |
| Uninstall | `mac-os/applications/openclaw/uninstall.sh` |

### Environment Variables

| Action | Script |
|---|---|
| Add | `mac-os/environment/add.sh VAR_NAME VAR_VALUE` |
| View | `mac-os/environment/view.sh [PATTERN]` |
| Remove | `mac-os/environment/remove.sh VAR_NAME` |

## Recommended Install Order

Install everything at once:

```bash
./mac-os/install.sh
```

Or run individual scripts from the repository root:

```bash
./mac-os/xcode-clt/install.sh
./mac-os/homebrew/install.sh
./mac-os/xcode/install.sh
./mac-os/languages/python/install.sh
./mac-os/languages/java/install.sh
./mac-os/languages/nodejs/install.sh
./mac-os/containers/docker/install.sh
```

## Quick Verification

```bash
xcode-select -p
xcodebuild -version
brew --version
uv --version
java -version
javac -version
node --version
npm --version
docker --version
```

## Notes

- Most scripts are idempotent and can be rerun safely.
- Some steps require `sudo`.
- For shell profile changes to apply, open a new terminal or run:

```bash
source ~/.zprofile
```
