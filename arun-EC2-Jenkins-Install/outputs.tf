output "public_ip" {
    value = "${aws_instance.Jenkins_Ec2_app_server.public_ip}"
}