Started by user admin
Obtained Jenkinsfile from git https://github.com/Khessie/Third-Semester-Exam.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/deploying
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified

> git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/deploying/.git # timeout=10
> Fetching changes from the remote Git repository
> git config remote.origin.url https://github.com/Khessie/Third-Semester-Exam.git # timeout=10
> Fetching upstream changes from https://github.com/Khessie/Third-Semester-Exam.git
> git --version # timeout=10
> git --version # 'git version 2.34.1'
> git fetch --tags --force --progress -- https://github.com/Khessie/Third-Semester-Exam.git +refs/heads/_:refs/remotes/origin/_ # timeout=10
> git rev-parse refs/remotes/origin/main^{commit} # timeout=10
> Checking out Revision bf13a8e087628a1ea9dc8909354e874776a2c79b (refs/remotes/origin/main)
> git config core.sparsecheckout # timeout=10
> git checkout -f bf13a8e087628a1ea9dc8909354e874776a2c79b # timeout=10
> Commit message: "edit"
> git rev-list --no-walk 516717292bd3739ce8c6ae5108afd8070b89e8db # timeout=10
> [Pipeline] }
> [Pipeline] // stage
> [Pipeline] withEnv
> [Pipeline] {
> [Pipeline] withCredentials
> Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
> [Pipeline] {
> [Pipeline] withEnv
> [Pipeline] {
> [Pipeline] stage
> [Pipeline] { (Create nginx-conroller)
> [Pipeline] script
> [Pipeline] {
> [Pipeline] dir
> Running in /var/lib/jenkins/workspace/deploying/nginx-controller
> [Pipeline] {
> [Pipeline] sh

- aws eks --region us-east-1 update-kubeconfig --name demo
  Updated context arn:aws:eks:us-east-1:104697772276:cluster/demo in /var/lib/jenkins/.kube/config
  [Pipeline] sh
- terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m

- Reusing previous version of gavinbunney/kubectl from the dependency lock file
- Reusing previous version of hashicorp/helm from the dependency lock file
- Reusing previous version of hashicorp/time from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Using previously-installed hashicorp/time v0.9.1
- Using previously-installed hashicorp/aws v4.59.0
- Using previously-installed hashicorp/kubernetes v2.18.1
- Using previously-installed gavinbunney/kubectl v1.14.0
- Using previously-installed hashicorp/helm v2.9.0

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] sh

- terraform apply -auto-approve
  [0m[1mdata.aws_eks_cluster_auth.demo_auth: Reading...[0m[0m
  [0m[1mdata.aws_eks_cluster.demo: Reading...[0m[0m
  [0m[1mdata.aws_eks_cluster_auth.demo_auth: Read complete after 0s [id=demo_auth][0m
  [0m[1mdata.aws_eks_cluster.demo: Read complete after 0s [id=demo][0m
  [0m[1mtime_sleep.wait_for_kubernetes: Refreshing state... [id=2023-03-22T21:05:09Z][0m
  [0m[1mkubernetes_namespace.nginx-namespace: Refreshing state... [id=nginx-ingress][0m
  [0m[1mhelm_release.ingress_nginx: Refreshing state... [id=ingress-nginx][0m

[0m[1m[32mNo changes.[0m[1m Your infrastructure matches the configuration.[0m

[0mTerraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
[0m[1m[32m
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[0m
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Create prometheus)
[Pipeline] script
[Pipeline] {
[Pipeline] dir
Running in /var/lib/jenkins/workspace/deploying/prometheus
[Pipeline] {
[Pipeline] sh

- terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m

- Reusing previous version of gavinbunney/kubectl from the dependency lock file
- Reusing previous version of hashicorp/helm from the dependency lock file
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Reusing previous version of hashicorp/time from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed gavinbunney/kubectl v1.14.0
- Using previously-installed hashicorp/helm v2.9.0
- Using previously-installed hashicorp/kubernetes v2.18.1
- Using previously-installed hashicorp/time v0.9.1
- Using previously-installed hashicorp/aws v4.59.0

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] sh

- terraform apply -auto-approve
  [0m[1mdata.aws_eks_cluster_auth.demo_auth: Reading...[0m[0m
  [0m[1mdata.aws_eks_node_group.eks-node-group: Reading...[0m[0m
  [0m[1mdata.aws_eks_cluster_auth.demo_auth: Read complete after 0s [id=demo_auth][0m
  [0m[1mdata.aws_eks_cluster.demo: Reading...[0m[0m
  [0m[1mdata.aws_eks_cluster.demo: Read complete after 0s [id=demo][0m
  [0m[1mtime_sleep.wait_for_kubernetes: Refreshing state... [id=2023-03-22T21:06:47Z][0m
  [0m[1mdata.aws_eks_node_group.eks-node-group: Read complete after 0s [id=demo:private-nodes][0m
  [0m[1mkubernetes_namespace.kube-namespace: Refreshing state... [id=prometheus][0m
  [0m[1mhelm_release.prometheus: Refreshing state... [id=prometheus][0m

[0m[1m[32mNo changes.[0m[1m Your infrastructure matches the configuration.[0m

[0mTerraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
[0m[1m[32m
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[0m
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Deploy voting-app to EKS)
[Pipeline] script
[Pipeline] {
[Pipeline] dir
Running in /var/lib/jenkins/workspace/deploying/voting-app
[Pipeline] {
[Pipeline] sh

- kubectl apply -f voting-app.yaml
  deployment.apps/azure-vote-back unchanged
  service/azure-vote-back unchanged
  deployment.apps/azure-vote-front configured
  service/azure-vote-front unchanged
  [Pipeline] }
  [Pipeline] // dir
  [Pipeline] }
  [Pipeline] // script
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Deploy sock-shop to EKS)
  [Pipeline] script
  [Pipeline] {
  [Pipeline] dir
  Running in /var/lib/jenkins/workspace/deploying/sock-shop
  [Pipeline] {
  [Pipeline] sh
- kubectl apply -f complete-deployment.yaml
  namespace/sock-shop unchanged
  deployment.apps/carts unchanged
  service/carts unchanged
  deployment.apps/carts-db unchanged
  service/carts-db unchanged
  deployment.apps/catalogue unchanged
  service/catalogue unchanged
  deployment.apps/catalogue-db unchanged
  service/catalogue-db unchanged
  deployment.apps/front-end unchanged
  service/front-end unchanged
  deployment.apps/orders unchanged
  service/orders unchanged
  deployment.apps/orders-db unchanged
  service/orders-db unchanged
  deployment.apps/payment unchanged
  service/payment unchanged
  deployment.apps/queue-master unchanged
  service/queue-master unchanged
  deployment.apps/rabbitmq unchanged
  service/rabbitmq unchanged
  deployment.apps/session-db unchanged
  service/session-db unchanged
  deployment.apps/shipping unchanged
  service/shipping unchanged
  deployment.apps/user unchanged
  service/user unchanged
  deployment.apps/user-db unchanged
  service/user-db unchanged
  [Pipeline] }
  [Pipeline] // dir
  [Pipeline] }
  [Pipeline] // script
  [Pipeline] }
  [Pipeline] // stage
  [Pipeline] stage
  [Pipeline] { (Deploy ingress rule to EKS)
  [Pipeline] script
  [Pipeline] {
  [Pipeline] dir
  Running in /var/lib/jenkins/workspace/deploying/ingress-rule
  [Pipeline] {
  [Pipeline] sh
- terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m

- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Using previously-installed hashicorp/aws v4.59.0
- Using previously-installed hashicorp/kubernetes v2.16.1

[33m[33m╷[0m[0m
[33m│[0m [0m[1m[33mWarning: [0m[0m[1mVersion constraints inside provider configuration blocks are deprecated[0m
[33m│[0m [0m
[33m│[0m [0m[0m on provide.tf line 19, in provider "kubernetes":
[33m│[0m [0m 19: version = [4m"2.16.1"[0m[0m
[33m│[0m [0m
[33m│[0m [0mTerraform 0.13 and earlier allowed provider version constraints inside the
[33m│[0m [0mprovider configuration block, but that is now deprecated and will be
[33m│[0m [0mremoved in a future version of Terraform. To silence this warning, move the
[33m│[0m [0mprovider version constraint into the required_providers block.
[33m╵[0m[0m
[0m[0m
[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] sh

- terraform apply -auto-approve
  [0m[1mdata.aws_eks_cluster.demo: Reading...[0m[0m
  [0m[1mdata.aws_eks_cluster_auth.demo_auth: Reading...[0m[0m
  [0m[1mdata.aws_eks_cluster_auth.demo_auth: Read complete after 0s [id=demo_auth][0m
  [0m[1mdata.aws_eks_cluster.demo: Read complete after 1s [id=demo][0m
  [0m[1mkubernetes_ingress_v1.micro-ingress: Refreshing state... [id=sock-shop/sock-shop][0m
  [0m[1mkubernetes_ingress_v1.voting-ingress: Refreshing state... [id=default/azure-vote-front][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
[33m~[0m update in-place[0m

Terraform will perform the following actions:

[1m # kubernetes_ingress_v1.micro-ingress[0m will be updated in-place
[0m [33m~[0m[0m resource "kubernetes_ingress_v1" "micro-ingress" {
id = "sock-shop/sock-shop"
[90m# (1 unchanged attribute hidden)[0m[0m

      [33m~[0m[0m spec {
          [33m~[0m[0m rule {
              [33m~[0m[0m host = "sock-shop.nwokolo.live" [33m->[0m[0m "sock-shop.khessie.live"

                [90m# (1 unchanged block hidden)[0m[0m
            }
        }

        [90m# (1 unchanged block hidden)[0m[0m
    }

[1m # kubernetes_ingress_v1.voting-ingress[0m will be updated in-place
[0m [33m~[0m[0m resource "kubernetes_ingress_v1" "voting-ingress" {
id = "default/azure-vote-front"
[90m# (1 unchanged attribute hidden)[0m[0m

      [33m~[0m[0m spec {
          [33m~[0m[0m rule {
              [33m~[0m[0m host = "voting.nwokolo.live" [33m->[0m[0m "voting.khessie.live"

                [90m# (1 unchanged block hidden)[0m[0m
            }
        }

        [90m# (1 unchanged block hidden)[0m[0m
    }

[1mPlan:[0m 0 to add, 2 to change, 0 to destroy.
[0m[0m[1mkubernetes_ingress_v1.voting-ingress: Modifying... [id=default/azure-vote-front][0m[0m
[0m[1mkubernetes_ingress_v1.micro-ingress: Modifying... [id=sock-shop/sock-shop][0m[0m
[0m[1mkubernetes_ingress_v1.micro-ingress: Modifications complete after 2s [id=sock-shop/sock-shop][0m
[0m[1mkubernetes_ingress_v1.voting-ingress: Modifications complete after 2s [id=default/azure-vote-front][0m
[33m╷[0m[0m
[33m│[0m [0m[1m[33mWarning: [0m[0m[1mVersion constraints inside provider configuration blocks are deprecated[0m
[33m│[0m [0m
[33m│[0m [0m[0m on provide.tf line 19, in provider "kubernetes":
[33m│[0m [0m 19: version = [4m"2.16.1"[0m[0m
[33m│[0m [0m
[33m│[0m [0mTerraform 0.13 and earlier allowed provider version constraints inside the
[33m│[0m [0mprovider configuration block, but that is now deprecated and will be
[33m│[0m [0mremoved in a future version of Terraform. To silence this warning, move the
[33m│[0m [0mprovider version constraint into the required_providers block.
[33m╵[0m[0m
[0m[1m[32m
Apply complete! Resources: 0 added, 2 changed, 0 destroyed.
[0m
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
