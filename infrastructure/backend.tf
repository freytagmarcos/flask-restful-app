terraform {
  backend "s3" {
    bucket = "s3-marcos-freytag"
    key    = "rnp/tfstate.tfstate"
    region = "us-east-1"
  }
}