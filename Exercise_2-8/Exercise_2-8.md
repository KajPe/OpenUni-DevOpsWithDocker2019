# Exercise 2.8

Added nginx as reverse proxy for frontend and backend.
As nginx take care of communication the exposed ports can be removed from frontend and backend
as docker will see the containers inside it's network. The nginx itself exposes port 80.

<pre>
<b>$ docker-compose up</b>
</pre>

With a browser open page http://localhost (frontend answers) 
and http://localhost/api/ping (backend answers).
