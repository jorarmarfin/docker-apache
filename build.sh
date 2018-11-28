docker build -t lfmc/iso-apache .

docker run --name srv-apache -d -p 8181:80 lfmc/iso-apache