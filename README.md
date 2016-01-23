## Simple OpenSSH on Resin.io

docker run --name=diamondd-data -v /data alpine:latest chown 1000:1000 /data

docker cp ./blockchain diamondd-data:/data

docker run -d \
  --restart=always \
  --volumes-from diamondd-data \
  --name diamondd-node \
  -p 17771:17771 \
  -p 17772:17772 \
  diamondd-amd64 \
  bash /start.sh

docker cp diamondd-data:/data .


docker exec -d diamondd-node bash diamondd -datadir=/data getinfo


docker build --no-cache=false -t diamondd:jessie .


export DMDPW='@@diamonD91706!'
