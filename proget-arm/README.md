Use the following commands to create a local `Proget` server on raspberry pi:

`docker network create proget`

`docker run -d -v /etc/localtime:/etc/localtime:ro -v /var/proget/db:/var/lib/postgresql/data --net=proget --name=proget-postgres --restart=unless-stopped szb640/postgres-arm:9.4`

`docker run -d -v /etc/localtime:/etc/localtime:ro -v /var/proget/packages:/var/proget/packages -v /var/proget/extensions:/var/proget/extensions -p 80:80 --net=proget --name=proget --restart=unless-stopped szb640/proget-arm`