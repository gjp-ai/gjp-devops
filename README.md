# GJP DevOps

This repository contains the Ansible playbooks and shell script wrappers for deploying and managing the GJP (Gan Jianping) API ecosystem on remote Ubuntu servers.

## Project Structure

```text
ansible/ubuntu/
├── deploy-gjp-admin-api-boot.sh   # Build and deploy Admin API
├── deploy-gjp-open-api-boot.sh    # Build and deploy Open API
├── stop-gjp-open-api-boot.sh      # Stop Open API service
├── show_system_resources.sh       # Check CPU, Memory, and Disk usage
├── ping.sh                        # Test connection to the server
├── *_mysql_db.sh                  # Database management (Backup, Create, Init, Restore)
├── *_upload_folder.sh             # CMS folder management (Backup, Create)
└── playbook/                      # Ansible .yml playbooks
```

## Prerequisites

1. **Ansible**: Must be installed on your local control machine.
2. **Inventory**: Ensure your target server is defined in `~/.ansible/inventory/hosts` under the `[ubuntu_server]` group.
3. **Java 21**: The playbooks assume the target server has Java 21 installed.

## Usage Guide

### 1. Deployment

To build a fresh JAR locally and deploy it to the server:

```bash
cd ansible/ubuntu
./deploy-gjp-admin-api-boot.sh
# OR
./deploy-gjp-open-api-boot.sh
```

### 2. Service Management

To stop a running service without a full rebuild:

```bash
./stop-gjp-open-api-boot.sh
```

### 3. Monitoring

To view a live summary of CPU, Memory, and Disk usage on the remote server:

```bash
./show_system_resources.sh
```

### 4. Database Operations

| Script | description |
| :--- | :--- |
| `./create_mysql_db.sh` | Create the target database if it doesn't exist |
| `./init_mysql_db.sh` | Initialize the database schema with SQL scripts |
| `./backup_mysql_db.sh` | Export a `.sql` dump of the remote database to your local machine |
| `./restore_mysql_db.sh` | Restore a local `.sql` dump to the remote server |

### 5. CMS Uploads Management

| Script | description |
| :--- | :--- |
| `./create_upload_folder.sh` | Initialize all required CMS upload subdirectories |
| `./backup_upload_folder.sh` | Create a compressed backup of the remote upload folder |

---

## Configuration

* **`ansible.cfg`**: Located in `ansible/ubuntu/`, configures default behavior like silencing deprecation warnings.
* **`playbook/`**: Contains the raw YAML logic for all operations. If you need to change logic (e.g., service names or remote paths), edit the files here.
