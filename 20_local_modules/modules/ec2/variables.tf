variable "instance_type" {}

variable "security_guroup_ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [80, 443]
}
