# Exercise 3.4

## Build images
<pre>
<b>$ docker build -t myfront:ubuntu frontendopt/.</b>
<b>$ docker build -t myback:ubuntu backendopt/.</b>
<b>$ docker build -t myfront:alpine -f frontendopt/Dockerfile.alpine .</b>
<b>$ docker build -t myback:alpine -f backendopt/Dockerfile.alpine .</b>
</pre>

There is a docker-compose.yml file which is for the alpine based setup.
<pre>
<b>$ docker-compose up</b>
</pre>


## Orginal image sizes - Ubuntu based

<pre>
<b>$ docker images</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED             SIZE
myfront                                ubuntu                05cc57867e01        16 hours ago        318MB
myback                                 ubuntu                8ec3b6425ebe        16 hours ago        407MB

<b>$ docker history myfront:ubuntu</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
05cc57867e01        16 hours ago        /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
add40abd166e        16 hours ago        /bin/sh -c #(nop) WORKDIR /app/backend          0B
1c1aefdba3ba        16 hours ago        /bin/sh -c #(nop)  EXPOSE 8000                  0B
f82201730231        16 hours ago        /bin/sh -c #(nop)  USER www-data                0B
a91bbfc2287b        16 hours ago        /bin/sh -c apt-get update     && apt-get ins…   198MB
5e481b74d809        19 hours ago        /bin/sh -c #(nop)  ENV FRONT_URL=http://loca…   0B
5e13f8dd4c1a        5 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
&lt;missing&gt;           5 months ago        /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B
&lt;missing&gt;           5 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' &gt; /…   745B
&lt;missing&gt;           5 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B
&lt;missing&gt;           5 months ago        /bin/sh -c #(nop) ADD file:603693e48cdc7f0c5…   120MB

<b>$ docker history myback:ubuntu</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
8ec3b6425ebe        16 hours ago        /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
bde017668cec        16 hours ago        /bin/sh -c #(nop) WORKDIR /app/frontend         0B
148428b73166        16 hours ago        /bin/sh -c #(nop)  EXPOSE 5000                  0B
b6cd91f342c2        16 hours ago        /bin/sh -c #(nop)  USER www-data                0B
0da41bf2dce0        16 hours ago        /bin/sh -c apt-get update     && apt-get ins…   287MB
7982006e7dcd        17 hours ago        /bin/sh -c #(nop)  ENV API_URL=http://localh…   0B
5e13f8dd4c1a        5 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
&lt;missing&gt;           5 months ago        /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B
&lt;missing&gt;           5 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' &gt; /…   745B
&lt;missing&gt;           5 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B
&lt;missing&gt;           5 months ago        /bin/sh -c #(nop) ADD file:603693e48cdc7f0c5…   120MB
</pre>


## Image sizes - Alpine based

<pre>
<b>$ docker images</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED             SIZE
myfront                                alpine                ad6ea1d4538b        23 minutes ago      218MB
myback                                 alpine                caa83e71d797        15 minutes ago      129MB

<b>$ $ docker history myfront:alpine</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
ad6ea1d4538b        24 minutes ago      /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
88c4e3b3b511        24 minutes ago      /bin/sh -c #(nop) WORKDIR /app/frontend         0B
6db4bcabd4a2        24 minutes ago      /bin/sh -c #(nop)  EXPOSE 5000                  0B
e5bf3528644f        24 minutes ago      /bin/sh -c #(nop)  USER www-data                0B
168445ef40ec        24 minutes ago      /bin/sh -c apk --no-cache add git     && mkd…   137MB
dc3fe6ab241e        2 hours ago         /bin/sh -c #(nop)  ENV API_URL=http://localh…   0B
d32bf7fc7d5f        11 days ago         /bin/sh -c #(nop)  CMD ["node"]                 0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop) COPY file:238737301d473041…   116B
&lt;missing&gt;           11 days ago         /bin/sh -c apk add --no-cache --virtual .bui…   5.35MB
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  ENV YARN_VERSION=1.21.1      0B
&lt;missing&gt;           11 days ago         /bin/sh -c addgroup -g 1000 node     && addu…   69.6MB
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  ENV NODE_VERSION=10.18.0     0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop) ADD file:36fdc8cb08228a870…   5.59MB
</b>

<b>$ docker history myback:alpine</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
caa83e71d797        16 minutes ago      /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
2b5a27fa0ceb        16 minutes ago      /bin/sh -c #(nop) WORKDIR /app/backend          0B
b70ed6bc5067        16 minutes ago      /bin/sh -c #(nop)  EXPOSE 8000                  0B
105da69848d1        16 minutes ago      /bin/sh -c #(nop)  USER www-data                0B
d5653306a361        16 minutes ago      /bin/sh -c apk --no-cache add git     && mkd…   48.5MB
c7e7a4ce2185        17 minutes ago      /bin/sh -c #(nop)  ENV FRONT_URL=http://loca…   0B
d32bf7fc7d5f        11 days ago         /bin/sh -c #(nop)  CMD ["node"]                 0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop) COPY file:238737301d473041…   116B
&lt;missing&gt;           11 days ago         /bin/sh -c apk add --no-cache --virtual .bui…   5.35MB
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  ENV YARN_VERSION=1.21.1      0B
&lt;missing&gt;           11 days ago         /bin/sh -c addgroup -g 1000 node     && addu…   69.6MB
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  ENV NODE_VERSION=10.18.0     0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
&lt;missing&gt;           11 days ago         /bin/sh -c #(nop) ADD file:36fdc8cb08228a870…   5.59MB
</pre>
