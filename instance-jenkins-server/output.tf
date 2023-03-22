#public ip output
output "public_ip" {
  value = aws_instance.my-web.public_ip
}

# output "cluster_name" {
#   value = aws_eks_cluster.k8s.name
# }

# output "cluster_endpoint" {
#   value = aws_eks_cluster.k8s.endpoint
# }

# output "cluster_ca_certificate" {
#   value = aws_eks_cluster.k8s.certificate_authority[0].data
# }

