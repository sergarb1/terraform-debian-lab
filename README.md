# 🧑‍💻 Terraform Debian Lab 🚀

Welcome to the **Terraform Debian Lab**! This project allows you to quickly provision multiple isolated Debian virtual machines (Docker containers) for educational purposes, practice, or testing.

## ✨ Features

-   **Automated Provisioning:** Spin up multiple Debian containers with a single Terraform command.
-   **SSH Access:** Each container is pre-configured with `openssh-server`, allowing secure shell access.
-   **User Management:** Automatically creates `alumno` (student) and `administrador` (admin) users with randomly generated passwords for each machine.
-   **Isolated Credentials:** Credentials for `alumno` and `administrador` are stored in separate files (`credenciales_alumno.txt` and `credenciales_admin.txt`) to maintain clear roles:
    -   **`credenciales_alumno.txt`**: Ideal for students to practice and experiment without affecting critical configurations.
    -   **`credenciales_admin.txt`**: Designed for instructors or advanced users to manage problems, troubleshoot, or perform administrative tasks.
-   **Scalable:** Easily adjust the number of machines to create using a simple variable.

## 🚀 Getting Started

### Prerequisites

-   [Docker](https://docs.docker.com/get-docker/) installed and running.
-   [Terraform](https://developer.hashicorp.com/terraform/downloads) installed.

### Installation and Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/sergarb1/terraform-debian-lab.git
    cd terraform-debian-lab
    ```
2.  **Initialize Terraform:**
    ```bash
    terraform init
    ```
3.  **Review the plan (optional but recommended):**
    ```bash
    terraform plan
    ```
    This will show you what Terraform intends to create.
4.  **Apply the configuration:**
    ```bash
    terraform apply
    ```
    Type `yes` when prompted to confirm the creation.

### ⏳ Initial Image Creation Time

The first time you run `terraform apply`, the process of creating the Debian images and installing `openssh-server` within each container **may take some time**. This is because each container needs to download packages and configure SSH.

You can monitor the installation progress for each container by running `docker logs <container_name>` in a separate terminal. For example, to check `maquina01`:

```bash
docker logs maquina01
```

Once the `exec /usr/sbin/sshd -D` command appears in the logs, the SSH server is running and the machine is ready.

## 🔑 Accessing Your Machines

After `terraform apply` completes, two files will be generated in your project directory:

-   `credenciales_alumno.txt`
-   `credenciales_admin.txt`

These files contain the SSH connection details (machine name, port, and password) for the `alumno` and `administrador` users respectively.

**Example content from `credenciales_alumno.txt`:**

```
maquina01 | puerto:2201 | alumno:rAnD0mP@ssw0rd1
maquina02 | puerto:2202 | alumno:aN0th3rP@ssw0rd
...
```

You can connect via SSH using the provided port and credentials. For example, to connect to `maquina01` as `alumno`:

```bash
ssh alumno@localhost -p 2201
```

## 🧹 Cleaning Up

To destroy all the created machines and resources, run:

```bash
terraform destroy
```
Type `yes` when prompted to confirm the destruction.

---
