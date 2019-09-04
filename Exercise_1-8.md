# Exercise 1.8

...

Pull the image
<pre>
<b>$ docker pull devopsdockeruh/first_volume_exercise</b>
Using default tag: latest
latest: Pulling from devopsdockeruh/first_volume_exercise
...
Status: Downloaded newer image for devopsdockeruh/first_volume_exercise:latest
docker.io/devopsdockeruh/first_volume_exercise:latest
</pre>

Because the logs.txt file is written into /usr/app where the actual script files resides, we
need to map the logs.txt file only. First we need to create the logs.txt file, otherwise docker will try to create 
a folder named logs.txt which wont map to a file and cause an error.

<pre>
<b>$ touch logs.txt</b>
</pre>

Now we can run the image and map the host logs.txt file inside the container to /usr/app/logs.txt
<pre>
<b>$ docker run -v $(pwd)/logs.txt:/usr/app/logs.txt devopsdockeruh/first_volume_exercise</b>
(node:1) ExperimentalWarning: The fs.promises API is experimental
Wrote to file /usr/app/logs.txt
Wrote to file /usr/app/logs.txt
Wrote to file /usr/app/logs.txt
Wrote to file /usr/app/logs.txt
^CClosing file
</pre>

After a while we can stop the container with CTRL + C and check the logs.txt file.
<pre>
<b>$ cat logs.txt</b>
Wed, 04 Sep 2019 21:13:27 GMT
Wed, 04 Sep 2019 21:13:30 GMT
Wed, 04 Sep 2019 21:13:33 GMT
Wed, 04 Sep 2019 21:13:36 GMT
</pre>