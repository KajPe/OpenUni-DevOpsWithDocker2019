# Exercise 2.9

Changed postgres and redis to store their data (via volume mapping) on the host:
- postgres under ./database
- redis under ./redisdata

Before running create the logs.txt file and the folders
<pre>
<b>$ touch logs.txt</b>
<b>$ mkdir database</b>
<b>$ mkdir redisdata</b>
</pre>

Run it:
<pre>
<b>$ docker-compose up</b>
</pre>

With a browser open page http://localhost:5000

postgres and redis data can now be seen as files under the folders.
