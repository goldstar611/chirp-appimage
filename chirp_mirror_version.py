import logging
import sys

import boto3

logger = logging.getLogger(__name__)


files = {}

# Initialize the S3 resource.
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
s3 = boto3.client(
    's3',
    endpoint_url='https://s3.us-east-005.backblazeb2.com',
    # These are read-only credentials for the public bucket, so it's safe to include them here
    aws_access_key_id="0058b2a3056cdad0000000002",
    aws_secret_access_key="K005TuW2ByjRCxqZEcjEOSFa+C72t/A"
)
# Specify your bucket name
bucket_name = 'chirp-next'

logger.debug(f"Listing files in bucket: {bucket_name}")

# List objects
response = s3.list_objects_v2(Bucket=bucket_name)

if 'Contents' in response:
    for obj in response['Contents']:
        logger.debug(obj['Key'])

        key = obj['Key']
        release_version = key.split('/')[0]
        if release_version not in files:
            files[release_version] = []
        files[release_version].append(key)
else:
    logger.debug("Bucket is empty or does not exist.")

releases_sorted = dict(sorted(files.items(), reverse=True))
latest_release = next(iter(releases_sorted))
logger.debug(f"Latest release: {latest_release}")

sys.stdout.write(latest_release)
