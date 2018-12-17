docker build -t lfmc/iso-apache:7.2 .

docker run --name srv-apache -d -p 8181:80 lfmc/iso-apache