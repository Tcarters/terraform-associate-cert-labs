

provider "aws" {
    region    = var.aws_region
}

resource "random_pet" "petname" {
    length    = 5
    separator = "-"
}

resource "aws_s3_bucket" "mybucket_01" {
    bucket  = random_pet.petname.id

  tags = {
    public_bucket = false
}