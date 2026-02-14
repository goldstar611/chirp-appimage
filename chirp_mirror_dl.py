import logging
import os
import subprocess
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

os.makedirs("./s3downloads", exist_ok=True)

# Download latest release files
for key in files[latest_release]:
    filename = key.split('/')[-1]
    
    if not os.path.exists(f"./s3downloads/{filename}"):
        logger.debug(f"Downloading {key} from bucket {bucket_name}...")
        s3.download_file(bucket_name, key, f"./s3downloads/{filename}")
    else:
        logger.debug(f"File {filename} already exists, skipping download.")

# Verify SHA1 checksum
os.chdir("./s3downloads")
subprocess.run(["sha1sum", "--ignore-missing", "-c", f"SHA1SUM"], capture_output=True, text=True, check=True)

sys.stdout.write(latest_release)
