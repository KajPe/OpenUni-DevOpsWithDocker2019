# Exercise 3.6

Using the Dockerfile from exercise 1.14
The orginal dockerfile is named as <i>Dockerfile.orginal</i>.

As helping aid used the info from this page to build an optimized Dockerfile:
- https://medium.com/@lemuelbarango/ruby-on-rails-smaller-docker-images-bff240931332


## The Dockerfile
The main changes to the Dockerfile is:
- use multistage builds: build-stage and final stage
- run the final image as non-root
- use smaller alpine based ruby
- use /app as application folder

### The build stage
Use ruby:2.6.0-alpine as base image
<pre>
> FROM ruby:2.6.0-alpine as build-stage
</pre>

Configure bundle to use another directory where to store it's config
<pre>
> ENV BUNDLE_APP_CONFIG="/app/rails/.bundle"
</pre>

Run multiple commands to:
- update alpine itself
- add more packages needed during building the rail app
- clone the project itself to /app/rails folder
<pre>
> RUN apk update \
>   && apk upgrade \
>   # Add package dependecies
>   && apk add --update --no-cache \
>     git build-base curl-dev yaml-dev zlib-dev nodejs \
>     yarn sqlite sqlite-dev sqlite-libs tzdata \
>   # Clone project
>   && mkdir /app \
>   && cd /app \
>   && git clone https://github.com/docker-hy/rails-example-project.git rails
</pre>

Set workdir for the application to /app/rails
<pre>
> WORKDIR /app/rails
</pre>

Next lets build the rails application. We are doing multiple setups and changes to the build
process itself so that most is written under /app/rails folder. Anything written outside this
folder is not needed in the final build. After the build we also clean up files under the 
/app/rails folder which are not needed to run the application.
<pre>
> # Setup and install project
> RUN bundle config --global frozen 1 \
>   && bundle install --path=vendor/bundle \
>   && export SECRET_KEY_BASE=$(RAILS_ENV=production rake secret) \
>   && yarn install --production \
>   && rake assets:precompile \
>   && bin/rails db:migrate RAILS_ENV=production \
>   # Clean up (remove not needed files)
>   && rm -rf vendor/bundle/ruby/2.6.0/cache/*.gem \
>   && find vendor/bundle/ruby/2.6.0/gems/ -name "*.c" -delete \
>   && find vendor/bundle/ruby/2.6.0/gems/ -name "*.o" -delete \
>   && rm -rf node_modules tmp/cache app/assets vendor/assets spec .git .gitignore
</pre>

At this point we have a working ruby application under /app/rails.

### Final stage
We have a lot of unnecessary files in the build not needed to run the applicaton. We wont start cleaning those up, instead we will make another build and copy the files over.

We use the same ruby image as base image for the final stage
<pre>
> FROM ruby:2.6.0-alpine
</pre>

Again tell the system where the bundle config is
<pre>
> ENV BUNDLE_APP_CONFIG="/app/rails/.bundle"
</pre>

Set workdir
<pre>
> WORKDIR /app/rails
</pre>

Now from the build-stage copy over all files from the /app folder to this final stage /app folder.
<pre>
> COPY --from=build-stage /app /app
</pre>

Copy start script into place (we are in workdir so it's copying it there)
<pre>
> COPY start.sh .
</pre>

Run multiple command
- update the alpine system
- install a few needed packages
- Create a non-roow user <b>www-data</b> which will own everything under /app
<pre>
> RUN apk update \
>   && apk upgrade \
>   # Add package dependecies
>   && apk add --update --no-cache tzdata sqlite-libs nodejs \
>   # Make start.sh script runnable
>   && chmod +x start.sh \
>   #
>   # Set ownership
>   #
>   && cd /app \
>   # Create group www-data
>   && addgroup -S www-data \
>   # Create user www-data
>   && adduser -S www-data \
>   # Make www-data owner of everything under /app
>   && chown -R www-data:www-data * \
>   # Set sticky bit on all under /app
>   && chmod g+s .
</pre>

Change container to run as www-data user
<pre>
> USER www-data
</pre>

Expose port 3000
<pre>
> EXPOSE 3000
</pre>

And run start.sh con container start
<pre>
> CMD [ "./start.sh" ]
</pre>


## Building the image(s)

First let's build the orginal image for reference.
<pre>
<b>$ docker build -f Dockerfile.orginal -t myrails:1.0 .</b>
</pre>

Let's build the optizimed image.
<pre>
<b>$ docker build -t myrails:1.0-alpine .</b>
</pre>

Let's check the sizes
<pre>
<b>$ docker images</b>
REPOSITORY                             TAG                   IMAGE ID            CREATED              SIZE
myrails                                1.0-alpine            93886726094e        5 seconds ago        165MB
myrails                                1.0                   ddb8bc8d5cdf        6 minutes ago        1.13GB
</pre>

The image size reduced from 1.13GB to 165MB.

Let's check docker history for orginal Dockerfile
<pre>
<b>$ docker history myrails:1.0</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
ddb8bc8d5cdf        7 minutes ago       /bin/sh -c #(nop)  CMD ["./start.sh"]           0B
c01b160ff757        7 minutes ago       /bin/sh -c #(nop)  EXPOSE 3000                  0B
9032de444945        7 minutes ago       /bin/sh -c #(nop) COPY file:55f45839a25bdc01…   96B
d29d6a101582        7 minutes ago       /bin/sh -c bundle install   && export SECRET…   156MB
2e349df973d5        10 minutes ago      /bin/sh -c #(nop) WORKDIR /app/rails            0B
6c202ec84404        10 minutes ago      /bin/sh -c git clone https://github.com/dock…   107kB
21f0dc8244f1        10 minutes ago      /bin/sh -c #(nop) WORKDIR /app                  0B
574f99a6171f        10 minutes ago      /bin/sh -c apt-get update   && curl -sL http…   104MB
ef8778f370d5        11 months ago       /bin/sh -c #(nop)  CMD ["irb"]                  0B
&lt;missing&gt;           11 months ago       /bin/sh -c mkdir -p "$GEM_HOME" && chmod 777…   0B
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop)  ENV PATH=/usr/local/bundl…   0B
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop)  ENV BUNDLE_PATH=/usr/loca…   0B
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop)  ENV GEM_HOME=/usr/local/b…   0B
&lt;missing&gt;           11 months ago       /bin/sh -c set -ex   && buildDeps='   bison …   34.2MB
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop)  ENV RUBY_DOWNLOAD_SHA256=…   0B
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop)  ENV RUBY_VERSION=2.6.0       0B
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop)  ENV RUBY_MAJOR=2.6           0B
&lt;missing&gt;           11 months ago       /bin/sh -c mkdir -p /usr/local/etc  && {   e…   45B
&lt;missing&gt;           11 months ago       /bin/sh -c set -ex;  apt-get update;  apt-ge…   560MB
&lt;missing&gt;           11 months ago       /bin/sh -c apt-get update && apt-get install…   142MB
&lt;missing&gt;           11 months ago       /bin/sh -c set -ex;  if ! command -v gpg &gt; /…   7.81MB
&lt;missing&gt;           11 months ago       /bin/sh -c apt-get update && apt-get install…   23.2MB
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop)  CMD ["bash"]                 0B
&lt;missing&gt;           11 months ago       /bin/sh -c #(nop) ADD file:feb9fd29475961253…   101MB
</pre>

And history for optimized Dockerfile
<pre>
<b>$ docker history myrails:1.0-alpine</b>
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
93886726094e        2 minutes ago       /bin/sh -c #(nop)  CMD ["./start.sh"]           0B
f1baeadc8b93        2 minutes ago       /bin/sh -c #(nop)  EXPOSE 3000                  0B
050409424bd3        2 minutes ago       /bin/sh -c #(nop)  USER www-data                0B
dfb21ced244a        2 minutes ago       /bin/sh -c apk update   && apk upgrade   && …   79.2MB
7b11526905d5        3 minutes ago       /bin/sh -c #(nop) COPY file:55f45839a25bdc01…   96B
bacc7640aa2c        3 minutes ago       /bin/sh -c #(nop) COPY dir:7b926ec40d3116d87…   45.3MB
e055358403d9        3 minutes ago       /bin/sh -c #(nop) WORKDIR /app/rails            0B
3390ad435ca1        8 minutes ago       /bin/sh -c #(nop)  ENV BUNDLE_APP_CONFIG=/ap…   0B
04a129682918        11 months ago       /bin/sh -c #(nop)  CMD ["irb"]                  0B
&ltmissing&gt;           11 months ago       /bin/sh -c mkdir -p "$GEM_HOME" && chmod 777…   0B
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop)  ENV PATH=/usr/local/bundl…   0B
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop)  ENV BUNDLE_PATH=/usr/loca…   0B
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop)  ENV GEM_HOME=/usr/local/b…   0B
&ltmissing&gt;           11 months ago       /bin/sh -c set -ex   && apk add --no-cache -…   35.6MB
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop)  ENV RUBY_DOWNLOAD_SHA256=…   0B
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop)  ENV RUBY_VERSION=2.6.0       0B
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop)  ENV RUBY_MAJOR=2.6           0B
&ltmissing&gt;           11 months ago       /bin/sh -c mkdir -p /usr/local/etc  && {   e…   45B
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
&ltmissing&gt;           11 months ago       /bin/sh -c #(nop) ADD file:91fb97ea3549e52e7…   4.41MB
</pre>

## Starting the container

Start the container as detached from the image (named as rails). Also map port 3000 inside the container.
<pre>
<b>$ docker run -d --name rails-alpine -p 3000:3000 myrails:1.0-alpine</b>
=> Booting Puma
=> Rails 5.2.2.1 application starting in production
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.0 (ruby 2.6.0-p0), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: production
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
</pre>

Now navigate with a browser to the frontend url http://localhost:3000
