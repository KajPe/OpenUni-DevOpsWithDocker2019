# Exercise 1.6

...

## Output

Searching docker hub for **devopsdockeruh/overwrite_cmd_exercise** we found the link to the source code at:

**https://github.com/docker-hy/overwrite_cmd_exercise**

Checking the Dockerfile tells it has an ENTRYPOINT of ./start.sh , so this script is always started when the container is run.
Checking the script we see that it starts **index.js** with two commandline arguments (if provided).
Again, checking the index.js we get some info about the commandline arguments. Starting the clock requires an argument of -c 
and optional time, which we will set as zero.  

So we end up with a Dockerfile as:  
```
FROM devopsdockeruh/overwrite_cmd_exercise

CMD [ "-c", "0" ]
```

The CMD will append the arguments to the ENTRYPOINT so basically the container will start with <b>./start.sh -c 0</b>.

We make a new image named docker-clock by running:
<pre>
<b>$ docker build -t docker-clock .</b>
</pre>

After that we can run it
<pre>
<b>$ docker run docker-clock</b>
1
2
3
4
...
</pre>

Why didn't we just run the orginal image and check what it did? Rule number one, dont run unknown images.
