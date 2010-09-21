source $HOME/env_vars
curl -s -u $TWITTER_UID:$TWITTER_PWD http://stream.twitter.com/1/statuses/sample.json > sample.`date +%F`_`date +%H%M`.json &
