source "amazon-ebs" "myami" {
  region        = "ap-south-1"
  source_ami    = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  ami_name      = "packer_AWS_{{timestamp}}"
}
build {
  name    = "packer"
  sources = ["source.amazon-ebs.myami"]

  provisioner "shell" {
    script = "service.sh"
  }
  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }
  provisioner "shell" {
    inline = [
      "sudo cp /tmp/index.html /var/www/html/"
    ]
  }
}

