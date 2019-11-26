resource "aws_instance" "trader-system-w2k8" {
  # ami           = "ami-0499f7700e0d63cf7"  # Microsoft Windows Server 2008 R2 Base - us-east-2
  ami           = "ami-0a34f585544c9dc85"  # Microsoft Windows Server 2008 R2 Base - sa-east-1
  # instance_type = "t3.medium"  # 2 vCPU, 4 GB RAM
  instance_type = "t3.small"  # 2 vCPU, 2 GB RAM
  key_name = "${aws_key_pair.trader-tf.id}"
  subnet_id = "${var.subnet_id}"

  depends_on = ["aws_security_group.sg_trader"]
  vpc_security_group_ids = ["${aws_security_group.sg_trader.id}",]

  associate_public_ip_address = true
  # user_data = "${file("./startup-script.ps1")}"
  user_data = <<EOF
<powershell>

mkdir c:\temp
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
iwr -Uri "${var.s3-download-file}" -OutFile C:\temp\modaltrader.exe

</powershell>
EOF

  # aws --profile alessander s3 presign s3://ftp-s3-repo/modaltrader.exe

  tags {
    Name = "Trader System"
  }

}
