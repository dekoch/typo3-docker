# typo3-docker

typo3 + nginx + php

```
git clone https://github.com/dekoch/typo3-docker.git

sudo docker build -t typo3 typo3-docker/.

sudo docker volume create typo3_data

sudo docker run --name=typo3 -p 8080:80 -d --restart=always -v typo3_data:/usr/share/nginx/html typo3
```

### typo3 10 LTS

Version: 10.4.9

Release Date: 2020-09-29


## Known Issues

- php running with old config

fix:
```
service php7.3-fpm restart
```