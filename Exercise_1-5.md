# Exercise 1.5

...


## Output

### Solution 1: Quick & dirty
Because the ubuntu image is missing the **curl** package we must add the installation commands as first commands.
<pre>
<b>$ docker run -it --rm ubuntu:16.04 sh -c 'apt-get update;apt-get install curl --yes;echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website;'</b>
Get:1 http://archive.ubuntu.com/ubuntu xenial InRelease [247 kB]
Get:2 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
Get:3 http://archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
Get:4 http://archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]
Get:5 http://archive.ubuntu.com/ubuntu xenial/main amd64 Packages [1558 kB]
...
Setting up curl (7.47.0-1ubuntu2.13) ...
Processing triggers for libc-bin (2.23-0ubuntu11) ...
Processing triggers for ca-certificates (20170717~16.04.2) ...
Updating certificates in /etc/ssl/certs...
148 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
</pre>

After curl installation, the script will start asking for input:
<pre>
Input website:
<b>helsinki.fi</b>
Searching..
&lt;!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN"&gt;
&lt;html&gt;&lt;head&gt;
&lt;title&gt;301 Moved Permanently&lt;/title&gt;
&lt;/head&gt;&lt;body&gt;
&lt;h1&gt;Moved Permanently&lt;/h1&gt;
&lt;p&gt;The document has moved &lt;a href="http://www.helsinki.fi/">here&lt;/a&gt;.&lt;/p&gt;
&lt;/body&gt;&lt;/html&gt;
</pre>

### Solution 2: Dockerfile & script
Create a **runme.sh** bash script with following content:
```
  #!/bin/sh  
  echo -n "Input website: http://"  
  read website  
  echo "Searching http://$website .."  
  sleep 1  
  curl http://$website  
```

Give the script execute permissions
<pre>
<b>$ chmod +x runme.sh</b>
</pre>

Create a Dockerfile with following content:
```
  FROM ubuntu:16.04
  RUN apt-get update && apt-get install curl --yes
  WORKDIR /app
  COPY runme.sh .
  CMD [ "sh", "/app/runme.sh" ]
```

Build the image and name the image as img15
<pre>
<b>$ docker build -t img15 .</b>
Sending build context to Docker daemon  35.33kB
Step 1/5 : FROM ubuntu:16.04
 ---> 5e13f8dd4c1a
Step 2/5 : RUN apt-get update && apt-get install curl --yes
 ---> Running in d5af13a41fd0
Get:1 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
Get:2 http://archive.ubuntu.com/ubuntu xenial InRelease [247 kB]
Get:3 http://archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
Get:4 http://security.ubuntu.com/ubuntu xenial-security/main amd64 Packages [924 kB]
Get:5 http://archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]
...
done.
Removing intermediate container d5af13a41fd0
 ---> df99c1f0f769
Step 3/5 : WORKDIR /app
 ---> Running in 59b7b4286fc2
Removing intermediate container 59b7b4286fc2
 ---> c70b335f657d
Step 4/5 : COPY runme.sh .
 ---> d0d518fbb5a4
Step 5/5 : CMD [ "sh", "/app/runme.sh" ]
 ---> Running in e0156e83a696
Removing intermediate container e0156e83a696
 ---> 6826ef72bb08
Successfully built 6826ef72bb08
Successfully tagged img15:latest
</pre>

Now the image can be used
<pre>
<b>$ docker run --rm -it img15</b>
Input website: http://<b>helsinki.fi</b>
Searching http://helsinki.fi ..
&lt;!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN"&gt;
&lt;html&gt;&lt;head&gt;
&lt;title&gt;301 Moved Permanently&lt;/title&gt;
&lt;/head&gt;&lt;body&gt;
&lt;h1&gt;Moved Permanently&lt;/h1&gt;
&lt;p&gt;The document has moved &lt;a href="http://www.helsinki.fi/"&gt;here&lt;/a&gt;.&lt;/p&gt;
&lt;/body&gt;&lt;/html&gt;
</pre>
