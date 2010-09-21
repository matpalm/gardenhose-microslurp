#!/usr/bin/env bash
set -x
wget http://sourceforge.net/projects/s3tools/files/s3cmd/0.9.9.91/s3cmd-0.9.9.91.tar.gz
tar zxf s3cmd-0.9.9.91.tar.gz
ln -s s3cmd-0.9.9.91/s3cmd

set +x
read -p "s3 access_key? " access_key
read -p "s3 secret_key? " secret_key
cat > ~/.s3cfg <<EOF
[default]
access_key = $access_key
acl_public = False
bucket_location = US
cloudfront_host = cloudfront.amazonaws.com
cloudfront_resource = /2008-06-30/distribution
default_mime_type = binary/octet-stream
delete_removed = False
dry_run = False
encoding = UTF-8
encrypt = False
force = False
get_continue = False
gpg_command = /usr/bin/gpg
gpg_decrypt = %(gpg_command)s -d --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_encrypt = %(gpg_command)s -c --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_passphrase = 
guess_mime_type = True
host_base = s3.amazonaws.com
host_bucket = %(bucket)s.s3.amazonaws.com
human_readable_sizes = False
list_md5 = False
preserve_attrs = True
progress_meter = True
proxy_host = 
proxy_port = 0
recursive = False
recv_chunk = 4096
secret_key = $secret_key
send_chunk = 4096
simpledb_host = sdb.amazonaws.com
skip_existing = False
urlencoding_mode = normal
use_https = False
verbosity = WARNING
EOF

read -p "bucket for storing data? eg s3://matpalm/gardenhose_full/ " s3_bucket
echo "export S3_BUCKET=$s3_bucket" > ~/env_vars

read -p "twitter username? " twitter_uid
echo "export TWITTER_UID=$twitter_uid" >> ~/env_vars

read -p "twitter password? " twitter_pwd
echo "export TWITTER_PWD=$twitter_pwd" >> ~/env_vars

crontab - <<EOF
5 * * * * bash $HOME/start.sh 2>&1 >> $HOME/start.out
0 2 * * * bash $HOME/process_yesterday.sh 2>&1 >> $HOME/process_yesterday.out    
EOF
echo "installed crontab"
crontab -l


