output "sg_allow_tls_id" {
    value = aws_security_group.allow_tls.id
}

output "sg_allow_bastian_id" {
    value = aws_security_group.allow_bastian.id
}

output "sg_allow_private_id" {
    value = aws_security_group.allow_private.id
}