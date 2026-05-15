AWS Secrets manager

For my second project, I integrated AWS Secrets Manager into the Terraform configuration to properly secure RDS database credentials. Instead of hardcoding the password in variables or leaving it exposed in state files, I set up an automated process where a random, strong password is generated at deployment time.That password is then stored as a JSON secret in Secrets Manager, with a resource-based IAM policy that only allows the EC2 Auto Scaling group to retrieve it using an instance profile. The same secret is used to provision the RDS instance, so the credentials are always consistent and never appear in plaintext anywhere. This change eliminated a major security risk and brought the infrastructure in line with AWS best practices for secret management.





Lessons Learned. 

I learned to slow down and read the official AWS and Terraform documentation carefully — I initially misconfigured the IAM policy attachment because I skimmed instead of reading. I also learned to always test small changes first in a dev environment before running a full apply. Paying attention to error messages saved me hours of debugging. Most importantly, I learned that good infrastructure isn't just about making things work — it's about making them secure, maintainable, and well-documented for the next person.
