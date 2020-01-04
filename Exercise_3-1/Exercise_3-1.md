# Exercise 3.1

## Frontend

### Frontend before optimizing
<pre>
<b>$ docker build -t frontend frontend/.</b>

<b>$ docker images frontend</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED             SIZE
frontend                               latest                8bfb01b4cd18        34 minutes ago      1.09GB

<b>$ docker history frontend</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
8bfb01b4cd18        38 minutes ago      /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
233cc440e38e        38 minutes ago      /bin/sh -c #(nop)  EXPOSE 5000                  0B
cd78ea49af60        38 minutes ago      /bin/sh -c npm install && npm run build         179MB
2d8c86cf8670        40 minutes ago      /bin/sh -c #(nop) WORKDIR /app/frontend         0B
e3661e133d48        40 minutes ago      /bin/sh -c git clone https://github.com/dock…   570kB
33b36893adc3        41 minutes ago      /bin/sh -c #(nop) WORKDIR /app                  0B
32ea9e17998a        41 minutes ago      /bin/sh -c #(nop)  ENV API_URL=http://localh…   0B
fa0699832a2a        4 months ago        /bin/sh -c #(nop)  CMD ["node"]                 0B
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop) COPY file:238737301d473041…   116B
&lt;missing&gt;           4 months ago        /bin/sh -c set -ex   && for key in     6A010…   5.47MB
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  ENV YARN_VERSION=1.17.3      0B
&lt;missing&gt;           4 months ago        /bin/sh -c ARCH= && dpkgArch="$(dpkg --print…   66.6MB
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  ENV NODE_VERSION=12.9.1      0B
&lt;missing&gt;           4 months ago        /bin/sh -c groupadd --gid 1000 node   && use…   333kB
&lt;missing&gt;           4 months ago        /bin/sh -c set -ex;  apt-get update;  apt-ge…   562MB
&lt;missing&gt;           4 months ago        /bin/sh -c apt-get update && apt-get install…   142MB
&lt;missing&gt;           4 months ago        /bin/sh -c set -ex;  if ! command -v gpg &gt; /…   7.81MB
&lt;missing&gt;           4 months ago        /bin/sh -c apt-get update && apt-get install…   23.2MB
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  CMD ["bash"]                 0B
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop) ADD file:b9b24bd862a79bf6c…   101MB
</pre>


### Frontend after optimizing
<pre>
<b>$ docker build -t frontendopt frontendopt/.</b>

<b>$ docker images frontendopt</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED             SIZE
frontendopt                            latest                d3ed84439750        29 minutes ago      407MB

<b>$ docker history frontendopt</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
d3ed84439750        33 minutes ago      /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
dbc2683f72cb        33 minutes ago      /bin/sh -c #(nop) WORKDIR /app/frontend         0B
e8056649c74d        33 minutes ago      /bin/sh -c #(nop)  EXPOSE 5000                  0B
561e550c8d48        33 minutes ago      /bin/sh -c apt-get update     && apt-get ins…   287MB
87289998f52d        38 minutes ago      /bin/sh -c #(nop)  ENV API_URL=http://localh…   0B
5e13f8dd4c1a        5 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
&lt;missing&gt;           5 months ago        /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B
&lt;missing&gt;           5 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' &gt; /…   745B
&lt;missing&gt;           5 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B
&lt;missing&gt;           5 months ago        /bin/sh -c #(nop) ADD file:603693e48cdc7f0c5…   120MB
</pre>


## Backend

### Backend before optimizing
<pre>
<b>$ docker build -t backend backend/.</b>

<b>$ docker images backend</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED             SIZE
backend                                latest                c53628d4b7a2        28 minutes ago      967MB

<b>$ docker history backend</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
c53628d4b7a2        33 minutes ago      /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
7e94eec73e24        33 minutes ago      /bin/sh -c #(nop)  EXPOSE 8000                  0B
34306687a490        33 minutes ago      /bin/sh -c npm install                          58.4MB
52b974c32fc2        34 minutes ago      /bin/sh -c #(nop) WORKDIR /app/backend          0B
92bb54b256c5        34 minutes ago      /bin/sh -c git clone https://github.com/dock…   577kB
b4ac03b2abbc        34 minutes ago      /bin/sh -c #(nop) WORKDIR /app                  0B
856916ba2c74        34 minutes ago      /bin/sh -c #(nop)  ENV FRONT_URL=http://loca…   0B
fa0699832a2a        4 months ago        /bin/sh -c #(nop)  CMD ["node"]                 0B
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop) COPY file:238737301d473041…   116B
&lt;missing&gt;           4 months ago        /bin/sh -c set -ex   && for key in     6A010…   5.47MB
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  ENV YARN_VERSION=1.17.3      0B
&lt;missing&gt;           4 months ago        /bin/sh -c ARCH= && dpkgArch="$(dpkg --print…   66.6MB
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  ENV NODE_VERSION=12.9.1      0B
&lt;missing&gt;           4 months ago        /bin/sh -c groupadd --gid 1000 node   && use…   333kB
&lt;missing&gt;           4 months ago        /bin/sh -c set -ex;  apt-get update;  apt-ge…   562MB
&lt;missing&gt;           4 months ago        /bin/sh -c apt-get update && apt-get install…   142MB
&lt;missing&gt;           4 months ago        /bin/sh -c set -ex;  if ! command -v gpg &gt; /…   7.81MB
&lt;missing&gt;           4 months ago        /bin/sh -c apt-get update && apt-get install…   23.2MB
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop)  CMD ["bash"]                 0B
&lt;missing&gt;           4 months ago        /bin/sh -c #(nop) ADD file:b9b24bd862a79bf6c…   101MB
</pre>


### Backend after optimizing
<pre>
<b>$ docker build -t backendopt backendopt/.</b>

<b>$ docker images backendopt</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED             SIZE
backendopt                             latest                3988f228d46e        25 minutes ago      318MB

<b>$ docker history backendopt</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
3988f228d46e        30 minutes ago      /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
0381af170d41        30 minutes ago      /bin/sh -c #(nop) WORKDIR /app/backend          0B
f5ac763f20c4        30 minutes ago      /bin/sh -c #(nop)  EXPOSE 8000                  0B
4ffe16ff3cd4        30 minutes ago      /bin/sh -c apt-get update     && apt-get ins…   198MB
52a375b5b08c        33 minutes ago      /bin/sh -c #(nop)  ENV FRONT_URL=http://loca…   0B
5e13f8dd4c1a        5 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B
&lt;missing&gt;           5 months ago        /bin/sh -c mkdir -p /run/systemd && echo 'do…   7B
&lt;missing&gt;           5 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' &gt; /…   745B
&lt;missing&gt;           5 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B
&lt;missing&gt;           5 months ago        /bin/sh -c #(nop) ADD file:603693e48cdc7f0c5…   120MB
</pre>
