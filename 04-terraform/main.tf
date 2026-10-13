terraform {
	required_providers {
		local = {
			source = "hashicorp/local"
			version = "~> 2.0"
		}
	}
}

resource "local_file" "sre_hello" {
	filename = "${path.module}/hello.txt"
	content = "hello from Terraform! This filr was created by SRE code."
}
