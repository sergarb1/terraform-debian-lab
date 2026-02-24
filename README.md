# 🧑‍💻 Laboratorio Debian con Terraform 🚀

Bienvenido al **Laboratorio Debian con Terraform**! Este proyecto te permite aprovisionar rápidamente múltiples máquinas virtuales Debian aisladas (contenedores Docker) para fines educativos, prácticas o pruebas.

## ✨ Características

-   **Aprovisionamiento Automatizado:** Levanta múltiples contenedores Debian con un solo comando de Terraform.
-   **Acceso SSH:** Cada contenedor viene preconfigurado con `openssh-server`, permitiendo acceso seguro vía SSH.
-   **Gestión de Usuarios:** Crea automáticamente usuarios `alumno` y `administrador` con contraseñas generadas aleatoriamente para cada máquina.
-   **Credenciales Aisladas:** Las credenciales para `alumno` y `administrador` se almacenan en archivos separados (`credenciales_alumno.txt` y `credenciales_admin.txt`) para mantener roles claros:
    -   **`credenciales_alumno.txt`**: Ideal para que los estudiantes practiquen y experimenten sin afectar configuraciones críticas.
    -   **`credenciales_admin.txt`**: Diseñado para instructores o usuarios avanzados para gestionar problemas, solucionar errores o realizar tareas administrativas.
-   **Escalable:** Ajusta fácilmente el número de máquinas a crear usando una simple variable.

## 🚀 Cómo Empezar

### Prerequisitos

-   [Docker](https://docs.docker.com/get-docker/) instalado y en ejecución.
-   [Terraform](https://developer.hashicorp.com/terraform/downloads) instalado.

### Instalación y Configuración

1.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/sergarb1/terraform-debian-lab.git
    cd terraform-debian-lab
    ```
2.  **Inicializa Terraform:**
    ```bash
    terraform init
    ```
3.  **Revisa el plan (opcional pero recomendado):**
    ```bash
    terraform plan
    ```
    Esto te mostrará lo que Terraform va a crear.
4.  **Aplica la configuración:**
    ```bash
    terraform apply
    ```
    Escribe `yes` cuando se te pida para confirmar la creación.

### ⏳ Tiempo de Creación Inicial de la Imagen

La primera vez que ejecutes `terraform apply`, el proceso de creación de las imágenes Debian y la instalación de `openssh-server` dentro de cada contenedor **puede tardar un tiempo**. Esto se debe a que cada contenedor necesita descargar paquetes y configurar SSH.

Puedes monitorear el progreso de la instalación para cada contenedor ejecutando `docker logs <nombre_del_contenedor>` en una terminal separada. Por ejemplo, para revisar `maquina01`:

```bash
docker logs maquina01
```

Una vez que el comando `exec /usr/sbin/sshd -D` aparezca en los logs, el servidor SSH estará en funcionamiento y la máquina estará lista.

## 🔑 Acceso a tus Máquinas

Después de que `terraform apply` finalice, se generarán dos archivos en el directorio de tu proyecto:

-   `credenciales_alumno.txt`
-   `credenciales_admin.txt`

Estos archivos contienen los detalles de conexión SSH (nombre de la máquina, puerto y contraseña) para los usuarios `alumno` y `administrador` respectivamente.

**Ejemplo de contenido de `credenciales_alumno.txt`:**

```
maquina01 | puerto:2201 | alumno:rAnD0mP@ssw0rd1
maquina02 | puerto:2202 | alumno:aN0th3rP@ssw0rd
...
```

Puedes conectarte vía SSH usando el puerto y las credenciales proporcionadas. Por ejemplo, para conectarte a `maquina01` como `alumno`:

```bash
ssh alumno@localhost -p 2201
```

## 🧹 Limpieza

Para destruir todas las máquinas y recursos creados, ejecuta:

```bash
terraform destroy
```
Escribe `yes` cuando se te pida para confirmar la destrucción.

---

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

#fpinfor
