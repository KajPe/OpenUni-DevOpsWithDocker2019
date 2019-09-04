# Exercise 1.7

...


## Output

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

Build the image and name the image as **curler**
<pre>
<b>$ docker build -t curler .</b>
Sending build context to Docker daemon  3.072kB
Step 1/5 : FROM ubuntu:16.04
 ---> 5e13f8dd4c1a
Step 2/5 : RUN apt-get update && apt-get install curl --yes
 ---> Running in 475ca0742279
Get:1 http://archive.ubuntu.com/ubuntu xenial InRelease [247 kB]
Get:2 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
Get:3 http://archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
Get:4 http://security.ubuntu.com/ubuntu xenial-security/main amd64 Packages [936 kB]
...
done.
Removing intermediate container 475ca0742279
 ---> 995eac762f51
Step 3/5 : WORKDIR /app
 ---> Running in 002bcd74f12f
Removing intermediate container 002bcd74f12f
 ---> 20f70b2ee70c
Step 4/5 : COPY runme.sh .
 ---> db6eb90bbaa1
Step 5/5 : CMD [ "sh", "/app/runme.sh" ]
 ---> Running in 1c271496b1a8
Removing intermediate container 1c271496b1a8
 ---> 31cd86dfd2a6
Successfully built 31cd86dfd2a6
Successfully tagged curler:latest
</pre>

Now the image can be used
<pre>
<b>$ docker run --rm -it curler</b>
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
