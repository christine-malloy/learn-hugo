aws iam create-user --user-name github-actions
aws iam attach-user-policy \
  --user-name github-actions \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess 
aws iam create-access-key --user-name github-actions