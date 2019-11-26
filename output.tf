output private_ip {
  value = "${aws_instance.trader-system-w2k8.private_ip}"
}

output public_ip {
  value = "${aws_instance.trader-system-w2k8.public_ip}"
}
