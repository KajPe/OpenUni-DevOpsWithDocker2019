# Exercise 1.17

...

This Dockerfile package is built to run php-fpm for development purposes. The
setup was mainly built for running Laravel with Vue.js, but can also be used for 
other setup's.

The image contains preinstalled npm and composer which Laravel and Vue.js needs. The code itself
is stored on the host via volume mapping.

## Building the image
<pre>
<b>$ docker build -t laravel-pack:1.0 .</b>
Sending build context to Docker daemon  33.79kB
Step 1/13 : FROM php:7.3.13-fpm-buster
7.3.13-fpm-buster: Pulling from library/php
8ec398bc0356: Downloading [=======>                                           ]  3.943MB/27.09MB
85cf4fc86478: Download complete
970dadf4ccb6: Downloading [==>                                                ]  3.767MB/76.65MB

...

Step 12/13 : WORKDIR /var/www/html
 ---> Running in 3a35898cafe0
Removing intermediate container 3a35898cafe0
 ---> 99dcc27fd0c9
Step 13/13 : CMD [ "/app/run_php.sh"]
 ---> Running in 09d8bc5ab8b6
Removing intermediate container 09d8bc5ab8b6
 ---> 305dc207142c
Successfully built 305dc207142c
Successfully tagged laravel-pack:1.0
</pre>

Note! During the image build there is an error about unsupported version of npm with node.js.
This is normal and the npm is updated during the process.

## Creating the container

First create two (empty) directories - html and php - on the host where the php configuration files and php -code is stored.
Dont forget to set the sticky bit with chmod, otherwise root will own everything (as the container is running as root)
and you have to fix the ownership manually.
<pre>
<b>$ mkdir -p {html,php}</b>
<b>$ chmod +t {html,php}</b>
</pre>

Next create the container from the image, we will name the container as laravel1.
<pre><b>$ docker create \
  --name laravel1 \
  -v $(pwd)/html:/var/www/html:rw \
  -v $(pwd)/php:/usr/local/etc/php:rw \
  -p 8000:8000 \
  -e "PHP=development" \
  laravel-pack:1.0</b>
5e2cdd48b9ae535acc5d513aa2f724196d8fe71753a0bd29eaf00b0c41dd4542
</pre>

Let's check it get created.
<pre>
<b>$ docker ps -a</b>
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
5e2cdd48b9ae        laravel-pack:1.0    "docker-php-entrypoi…"   35 seconds ago      Created                                 laravel1
</pre>

Next start the container
<pre>
<b>$ docker start laravel1</b>
</pre>

And check it's running
<pre>
<b>$ docker ps</b>
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                       NAMES
5e2cdd48b9ae        laravel-pack:1.0    "docker-php-entrypoi…"   5 minutes ago       Up 5 seconds        0.0.0.0:8000->8000/tcp, 9000/tcp            laravel1
</pre>

## Install Laravel with composer
There are several ways to install Laravel. Here's only one way is shown, but once you get the idea how to run composer and commands inside the container you can use whatever option you want.

Note that the project name is normally put at the end, here we are using . (dot). This will install the Laravel project in the main directory and not in a subdirectory. This will simplify the use of the artisan command, but if you prefer to install the project into a subdirectory the you are free to go with it.
<pre>
<b>$ docker exec -it laravel1 composer create-project --prefer-dist laravel/laravel .</b>
Installing laravel/laravel (v6.8.0)
  - Installing laravel/laravel (v6.8.0): Downloading (100%)
Created project in blog
> @php -r "file_exists('.env') || copy('.env.example', '.env');"
Loading composer repositories with package information
Updating dependencies (including require-dev)
Package operations: 85 installs, 0 updates, 0 removals
  - Installing symfony/polyfill-ctype (v1.13.1): Downloading (100%)
  - Installing phpoption/phpoption (1.7.2): Downloading (100%)

...

Discovered Package: nesbot/carbon
Discovered Package: nunomaduro/collision
Package manifest generated successfully.
> @php artisan key:generate --ansi
Application key set successfully.
</pre>

If you now check the host html directory you will find Laravel files installed. Let's run the <i>artisan serve</i> command.
<pre>
<b>$ docker exec -it laravel1 ./artisan serve</b>
Laravel development server started: http://127.0.0.1:8000
</pre>
Note that it will take a while and you wont get the control back as the development server starts. You can stop it with CTRL+C at any time and return to command line.

Test to open the Laravel site as http://127.0.0.1:8000

### Coding with Vue.js
You can run the npm command in the same way. Install npm packages
<pre>
<b>$ docker exec -it laravel1 npm install</b>
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.11 (node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.11: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})
added 1005 packages from 484 contributors and audited 17215 packages in 83.803s
25 packages are looking for funding
  run `npm fund` for details
found 0 vulnerabilities
</pre>

Run the npm watch
<pre>
<b>$ docker exec -it laravel1 npm run watch</b>
 DONE  Compiled successfully in 3339ms                                                                                                                            7:20:49 PM

       Asset     Size   Chunks             Chunk Names
/css/app.css  0 bytes  /js/app  [emitted]  /js/app
  /js/app.js  591 KiB  /js/app  [emitted]  /js/app
</pre>

You can open another commandline and run <i>artisan serve</i> at the same time.

### VirtualBox or VMware users
If you are running a linux virtual server serving docker then <i>artisan serve</i> will start but the page will not open.
This is due to the virtual environment docker opening the connection only to the host. In this case run it like this:
<pre>
<b>$ docker exec -it laravel1 ./artisan serve --host 0.0.0.0</b>
Laravel development server started: http://0.0.0.0:8000
</pre>
You can now open the Laravel page with the virtual server IP address at port 8000
(for example http://192.168.153.100:8000)
