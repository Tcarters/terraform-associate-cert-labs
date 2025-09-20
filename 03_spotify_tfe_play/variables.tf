
variable "spotify_api_key" {
  type        = string
  description = "Set this as the APIKey that the authorization proxy server outputs"
}


variable "spotify_auth_server" {
    type = string
    default = "http://192.168.64.4:27228"  # Replace <VM_IP> with the VM's actual IP "

    //"https://a5794f66ba77.ngrok-free.app"
    #"http://192.168.64.4:27228"  # Replace <VM_IP> with the VM's actual IP "
}