# Exercise 1.3

* Start image devopsdockeruh/pull_exercise with flags -it like so:  
  **docker run -it devopsdockeruh/pull_exercise**  
  It will wait for your input. Navigate through docker hub to find the docs and Dockerfile that was used to create the image.
* Read the Dockerfile and/or docs to learn what input will get the application to answer a “secret message”.
* Submit the secret message and command(s) given to get it as your answer.

## Output
Navigating to docker hub and doing a search for **devopsdockeruh/pull_exercise** will give one match.
This leads to:  
  https://hub.docker.com/r/devopsdockeruh/pull_exercise
  
From there a link to source repository points to:  
  https://github.com/docker-hy/docs-exercise
  
**README.md** states to enter **basics** as password.
Also checking **Dockerfile** we note that when the container starts it runs:

>  node index.js

Examining **index.js** we find the **KNOWN_INPUTS**, where the **basics** input will print out
the secret message.


So let's try it out:
<pre>
<b>$ docker run -it devopsdockeruh/pull_exercise</b>
Unable to find image 'devopsdockeruh/pull_exercise:latest' locally
latest: Pulling from devopsdockeruh/pull_exercise
8e402f1a9c57: Pull complete
5e2195587d10: Pull complete
6f595b2fc66d: Pull complete
165f32bf4e94: Pull complete
67c4f504c224: Pull complete
Digest: sha256:7c0635934049afb9ca0481fb6a58b16100f990a0d62c8665b9cfb5c9ada8a99f
Status: Downloaded newer image for devopsdockeruh/pull_exercise:latest
Give me the password: <b>basics</b>
You found the correct password. Secret message is:
"This is the secret message"
</pre>

So the password is *basics* and the secret message *"This is the secret message"*
