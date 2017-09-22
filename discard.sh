#/bin/bash
# Uncomment the if block to have a clean state of the repository
#if [ -d "./clickfuse.com" ]; then
#  echo 'clickfuse repository discarded'
#  rm -rf ./clickfuse.com
#fi
if [ ! -d "./clickfuse.com" ]; then
  git clone git@bitbucket.org:bandsintown/clickfuse.com.git
fi

docker-compose stop
yes | docker-compose rm
docker rmi dockerclickfuse_web
docker rmi dockerclickfuse_app
cp -R clickfuse.com/app/config/staging clickfuse.com/app/config/local
docker-compose up -d
docker-compose exec app php ../composer/composer.phar install
