resource "aws_s3_bucket_object" "ip" {
  bucket = "mostafa-pipeline-bucket"
  key    = "ip/bastian-ip.txt"
  content = var.bastian_instance_ip

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
 # etag = filemd5("path/to/file")
}