source $HOME/env_vars
yesterday=`date --date "-1 day" +%F`
# truncate the lines that we interrupted by the last restart of curl
cat sample*$yesterday* | perl -ne'print $_ if /}\s+$/;' | nice gzip -9 - > sample.$yesterday.json.gz
./s3cmd put sample.$yesterday.json.gz $S3_BUCKET
rm -f *$yesterday*
