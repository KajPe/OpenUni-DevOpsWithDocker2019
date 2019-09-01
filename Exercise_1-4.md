# Exercise 1.4

* Start image **devopsdockeruh/exec_bash_exercise**, it will start a container with clock-like features and create a log.  
* Go inside the container and use  
  **tail -f ./logs.txt**  
  to follow the logs. Every 15 seconds the clock will send you a “secret message”.
* Submit the secret message and command(s) given as your answer.

## Output

Create and start the container (naming the container **ex14**):
<pre>
<b>$ docker run -d --name ex14 devopsdockeruh/exec_bash_exercise</b>
Unable to find image 'devopsdockeruh/exec_bash_exercise:latest' locally
latest: Pulling from devopsdockeruh/exec_bash_exercise
741437d97401: Pull complete
34d8874714d7: Pull complete
0a108aa26679: Pull complete
7f0334c36886: Pull complete
65c95cb8b3be: Pull complete
a36b708560f8: Pull complete
4090f912e6c7: Pull complete
ce5fe2607c2e: Pull complete
9400f5f657d6: Pull complete
c4919883f7fa: Pull complete
Digest: sha256:c463832132d1fb0b8b3b60348a6fc36fda7512a4ef2d1050e8bea7b6a6d7a2f3
Status: Downloaded newer image for devopsdockeruh/exec_bash_exercise:latest
166e9b56166664a1e2799d7bdd68a6e44b954780e74620b8e85f1a77dd04a56c
</pre>

Check it's running:
<pre>
<b>$ docker ps</b>
CONTAINER ID        IMAGE                               COMMAND             CREATED             STATUS              PORTS               NAMES
166e9b561666        devopsdockeruh/exec_bash_exercise   "node index"        8 minutes ago       Up 8 minutes                            ex14
</pre>

Interact with the container by starting bash inside it.
<pre>
<b>$ docker exec -it ex14 bash</b>
root@166e9b561666:/usr/app#
</pre>

We are now inside the container. Check the logs.txt files.
<pre>
<b># tail -f ./logs.txt</b>
Sun, 01 Sep 2019 21:06:51 GMT
Secret message is:
"Docker is easy"
Sun, 01 Sep 2019 21:06:57 GMT
Sun, 01 Sep 2019 21:07:00 GMT
Sun, 01 Sep 2019 21:07:03 GMT
Sun, 01 Sep 2019 21:07:06 GMT
Secret message is:
"Docker is easy"
</pre>

Stop **tail** with CTRL+C.

We are still inside the container. Type:

>  exit  

and we are back on the host.

So the secret message is "Docker is easy"
