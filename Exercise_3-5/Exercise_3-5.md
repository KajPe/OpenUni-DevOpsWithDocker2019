# Exercise 3.5

We use the same image during the build stage and final image, but by seperating the builds, we
can copy the dist folder to the final image and reduce the final image size as it dont contain any
source code.

## Build image
<pre>
<b>$ docker build -t myfront:alpine-2 -f Dockerfile.alpine .</b>
</pre>

We can test the image is working by starting it:
<pre>
<b>$ docker run --rm -p 5000:5000 myfront:alpine-2</b>
</pre>
Now we can open http://localhost:5000 with a browser.


Image sizes compared to orginal alpine based:
<pre>
<b>$ docker images</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED             SIZE
myfront                                alpine                ad6ea1d4538b        23 minutes ago      218MB
myfront                                alpine-2              64631cf80cce        7 seconds ago       90MB

<b>$ docker history myfront:alpine-2</b>
IMAGE               CREATED              CREATED BY                                      SIZE                COMMENT
64631cf80cce        About a minute ago   /bin/sh -c #(nop)  CMD ["serve" "-s" "-l" "5…   0B
6f6c75d73564        About a minute ago   /bin/sh -c #(nop) WORKDIR /app/frontend         0B
20c7a7b28ca4        About a minute ago   /bin/sh -c #(nop)  EXPOSE 5000                  0B
27d9e00a59b0        About a minute ago   /bin/sh -c #(nop)  USER www-data                0B
45a94a4328f4        About a minute ago   /bin/sh -c cd /app     && addgroup -S www-da…   2.72MB
b34be23e73e7        About a minute ago   /bin/sh -c npm install -g serve     && npm c…   4MB
1106b18a2880        About a minute ago   /bin/sh -c #(nop) COPY dir:7757f9ae068926657…   2.72MB
074d0cbb7738        About an hour ago    /bin/sh -c #(nop)  ENV API_URL=http://localh…   0B
d32bf7fc7d5f        11 days ago          /bin/sh -c #(nop)  CMD ["node"]                 0B
&lt;missing&gt;           11 days ago          /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B
&lt;missing&gt;           11 days ago          /bin/sh -c #(nop) COPY file:238737301d473041…   116B
&lt;missing&gt;           11 days ago          /bin/sh -c apk add --no-cache --virtual .bui…   5.35MB
&lt;missing&gt;           11 days ago          /bin/sh -c #(nop)  ENV YARN_VERSION=1.21.1      0B
&lt;missing&gt;           11 days ago          /bin/sh -c addgroup -g 1000 node     && addu…   69.6MB
&lt;missing&gt;           11 days ago          /bin/sh -c #(nop)  ENV NODE_VERSION=10.18.0     0B
&lt;missing&gt;           11 days ago          /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
&lt;missing&gt;           11 days ago          /bin/sh -c #(nop) ADD file:36fdc8cb08228a870…   5.59MB
</pre>
