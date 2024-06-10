variable "instance_name" {
    description = "my terraform instance"
    type = string
    default = "Minecraft Server"
}
variable "private_key" {
  description = "/Users/matt/minecraft_server/id_rsa"
  type        = string
}
variable "public_key" {
  description = "/Users/matt/minecraft_server/id_rsa.pub"
  type        = string
}
