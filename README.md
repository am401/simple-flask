# Intro
This repo relates to the following Udemy course: [Ultimate Guide to Deploying Flask to AWS](https://www.udemy.com/course/ultimate-guide-to-deploying-flask-to-aws/). The course looks to have been originally published in 2021 and since then there has been much change on the AWS side of things.

My intention with this repo is to track some of those changes that I've made and to also expand on the course by implementing some of the solutions through the use of Terraform.

# Issues

- My AWS account is fairly vanilla so I am going to assume this is similar across the board, however a lot of older articles and courses do not factor in IMDSv2 (token based AWS Metadata Service interactions) as a default. What this meant for me was when setting up the instance, the Flask app was unable to retrieve the instance id from the Metadata Service [source](https://aws.amazon.com/about-aws/whats-new/2024/03/set-imdsv2-default-new-instance-launches/)
- The course uses AWS CodeCommit to store the files in. As of July 25th, 2024 CodeCommit has been marked for deprecation and new repo's cannot be created [source](https://aws.amazon.com/blogs/devops/how-to-migrate-your-aws-codecommit-repository-to-another-git-provider/)
- Extra packages through Enterprise Linux (EPEL) are no longer available on the Amazon Linux 2023 distros that are used for EC2s, therefore this line had to be removed from the install script - [source](https://docs.aws.amazon.com/linux/al2023/ug/epel.html)
- While creating one of the test roles for a segment, it was noted that there is now a character limit and this would mean the role would need to be split up. For the main application this role was not necessary so not including it here.

# Changes
- [x] Updated `scripts/userdata.sh` to remove the line about EPEL
- [x] When setting up EC2s via the UI ensure that `IMDSv2` is marked as _optional_
- [x] Update the script iwth the relevant S3 bucket address

# Terraform
I had been wanting to learn more about Terraform, therefore I decided to reproduce the setup using a Terraform plan. This took a bit of trial and error but was able to set it all up to reproduce the environment I was configuring in the AWS Console.

- I decided to re-use existing key pairs, security groups as well as the role rather than create new ones
- Set the `IMDSv2` setting as optional from Terraform
- Ensured I am able to log in as well as access the site over the internet

The Terraform plans are in the `/terraform/main.tf` file.
