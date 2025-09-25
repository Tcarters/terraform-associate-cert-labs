

# Copy files to s3 buckets
aws s3 cp modules/aws-s3-static-website-bucket/www/ s3://$(terraform output -raw website_bucket_name)/ --recursive


# Delete all files in buckets
aws s3 rm s3://$(terraform output -raw website_bucket_name)/ --recursive

aws s3 rm s3://lab05bucket-444111-dev --recursive


