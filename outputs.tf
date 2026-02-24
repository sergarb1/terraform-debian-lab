locals {
  credenciales_alumno = [
    for i in range(var.num_maquinas) :
    "${format("maquina%02d", i + 1)} | puerto:${2200 + i + 1} | alumno:${random_password.alumno[i].result}"
  ]

  credenciales_admin = [
    for i in range(var.num_maquinas) :
    "${format("maquina%02d", i + 1)} | puerto:${2200 + i + 1} | admin:${random_password.admin[i].result}"
  ]
}

resource "local_file" "alumno_file" {
  filename = "credenciales_alumno.txt"
  content  = join("\n", local.credenciales_alumno)
}

resource "local_file" "admin_file" {
  filename = "credenciales_admin.txt"
  content  = join("\n", local.credenciales_admin)
}

output "credenciales_alumno" {
  value     = local.credenciales_alumno
  sensitive = true
}

output "credenciales_admin" {
  value     = local.credenciales_admin
  sensitive = true
}