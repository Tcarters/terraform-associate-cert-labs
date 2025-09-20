terraform {

 // cloud {  # disabled HCP remote state to use local state
 //    organization = "prod-tdmund-tf"

 //    workspaces {
 //      name = "lab03-spotify-tf"
 //    }
//}

  required_providers {
    spotify = {
      version = "~> 0.2.7"
      source  = "conradludgate/spotify"
    }
  }
} 

provider "spotify" {
  auth_server = var.spotify_auth_server
  api_key     = "g2_jp1bG5lwJBG6rHp_8sU4CnaxGAcYoDeO2mz<REDACTED>usgccgDKGVTy9TsOhH1mocv" //var.spotify_api_key
  token_id = "QLpcuBM_Oz9GTzmdP9vReGNgzS475bNxmDS4v4rQrGxw9wfCv?<REDACTED>qJF6NoAVX8N"
}