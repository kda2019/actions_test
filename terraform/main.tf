provider "aws" {
  region = "us-east-1"
  access_key = "AKIA6L4CHPCMP6RBL5QG"
  secret_key = "tfgl6AagQqXyuWhR6R2jmsvMcflR65aHeLGVRwIT"
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "kravatest2"
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"

  # Встановлюємо ім'я бакету як змінну оточення для EC2 інстансу
  user_data = <<-EOF
              #!/bin/bash
              export BUCKET_NAME=${aws_s3_bucket.example_bucket.id}
              EOF

  # Створюємо новий тег для інстансу
  tags = {
    Name = "myinstance"
  }
}