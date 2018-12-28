# Docker_LAMPP
Build LAMPP(Ubuntu/Apache/Mysql/PHP/PhpMyadmin) by Docker(Docker File, Docker Compose)

### DockerHub Image
https://hub.docker.com/r/oliguo/ubuntu-apache-php

## Helpful Tools
[Dockerfile Online Editor](https://dockerfile-editor.com/)

[Dockerfile Online Validator](https://www.fromlatest.io/#/)

[Docker-Compose Online Validator](https://codebeautify.org/yaml-validator/)

## SSL Modification
Edit -subj what you want
```
RUN mkdir /var/ssl && cd /var/ssl \
&& openssl req -x509 -newkey rsa:4096 \
  -subj "/C=HK/ST=HongKong/L=HongKong/O=Demo/CN=dockerlampp.com" \
  -keyout "/var/ssl/key.pem" \
  -out "/var/ssl/cert.pem" \
  -days 3650 -nodes -sha256
```

Run as cmd
```
docker-compose up -d
```

After build succesfully, will be like as below
```
#view all container
docker ps -a

#view all images
docker images
```
![Ubuntu Case](https://github.com/oliguo/Docker-LAMPP-Ubuntu/blob/master/Ubuntu-Case.png)

Visit:

PHP:

http://localhost:8080

https://localhost:4433

PhpMyadmin:

http://localhost:9090

