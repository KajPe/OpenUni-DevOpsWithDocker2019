# Exercise 1.16

...


## Install heroku client
<pre>
<b>$ snap install --classic heroku</b>
2019-12-27T22:43:52+02:00 INFO Waiting for restart...
heroku v7.35.1 from Heroku✓ installed
</pre>

## Prepare image
Pull image:
<pre>
<b>$ docker pull devopsdockeruh/heroku-example</b>
</pre>

List images:
<pre>
<b>$ docker images</b>
REPOSITORY                      TAG                   IMAGE ID            CREATED             SIZE
devopsdockeruh/heroku-example   latest                5221e4b03bc7        9 months ago        1.17GB
</pre>

Tag image for heroku:
<pre>
<b>$ docker tag devopsdockeruh/heroku-example:latest registry.heroku.com/kpeapp116/web</b>
</pre>

Check the new tagged image is found:
<pre>
<b>$ docker images</b>
REPOSITORY                          TAG                   IMAGE ID            CREATED             SIZE
devopsdockeruh/heroku-example       latest                5221e4b03bc7        9 months ago        1.17GB
registry.heroku.com/kpeapp116/web   latest                5221e4b03bc7        9 months ago        1.17GB
</pre>

## Login to heroku

Login via command line:
<pre>
<b>$ heroku login -i</b>
heroku: Enter your login credentials
Email [xxx.xxx@xxx.xxx]:
Password: *********
Logged in as xxx.xxx@xxx.xxx
</pre>

Login to heroku container:
<pre>
<b>$ heroku container:login</b>
Login Succeeded
</pre>

## Push image to heroku
<pre>
<b>$ docker push registry.heroku.com/kpeapp116/web</b>
The push refers to repository [registry.heroku.com/kpeapp116/web]
3ac96a6ba5b8: Pushed
4fd89569d353: Pushed
5f05d62a5f6d: Pushed
0c5e45eed8a0: Pushed
568cd074539f: Pushed
1e0f4e8ab9d2: Pushed
30157feee804: Pushed
8fcdbfe1b942: Pushed
33e4b5ecc45d: Pushed
50f1e13ab060: Pushed
56a89222b908: Pushed
a89464ad2a8f: Pushed
76dfa41f0a1d: Pushed
c240c542ed55: Pushed
badfbcebf7f8: Pushed
latest: digest: sha256:7b355fd5a666655eeed4fd8b7836824e240611e7916841cfffd02a4cd10a1ce4 size: 3479
</pre>

## Release to web
<pre>
<b>$ heroku container:release web -a kpeapp116</b>
Releasing images web to kpeapp116... done
</pre>

Page can be found at:
https://kpeapp116.herokuapp.com/

