<h1 align="center">Your nightmare</h1>
<br>
<p align="center">
<img width="400" src="images/problems.jpg">
</p>
<p align="center">
You are in charge of servers.<br><br>
You get a call that the eCommerce site went down when they made an emergency update.<br><br>
They can’t revert the code.<br><br>
You check the server and notice that you need to update the libraries to fix the issue.<br>
But updating the libraries breaks the other services. So, you need to bring up a new server,<br>
get approvals from your boss and call your wife you will be late for dinner.
</p>

<br><br>

<h1 align="center">Introducing Docker</h1>
<br>
<p align="center">
<img width="400" src="images/horizontal-logo-monochromatic-white.png">
</p>
<p align="center">
With Docker you can just go home because you won’t ever get hit with this kind of problems.<br>
<br>
Running different libraries on the same server is no problem at all as everything<br>
an application need is in the container. No need to think about how to run<br>
different versions of an application at the same server.<br>
<br>
One container usually contains one application, for example a nginx web server.<br>
A web server again might need to communicate with a php container.<br><br>
What if a zero-day vulnerability came up on the nginx server?<br>
You just need to update the nginx containers, and not worry about other containers.
</p>

<br><br>

<h1 align="center">But it worked on my machine</h1>
<br>
<p align="center">
<img width="400" src="images/itworks.jpg">
</p>
<p align="center">
If the container works on your development machine, then it truly will work on<br>
the server without a glitch. Making docker images need a change in thinking<br>
about how to deploy software. As everything must be in the container you force<br>
the developers to not assume anything about the server's setup.
</p>

<br><br>

<h1 align="center">Test in production</h1>
<br>
<p align="center">
<img width="400" src="images/inproduction.jpg">
</p>
<p align="center">
Even if everything is tested before production you might want to slowly push out the new code.<br>
With load balancing you can define that only 1% of your users will get the new code<br>
and monitor for any problems. As the new and old containers can run at the same time<br>
you can easily orchestrate containers with an application like Kubernetes.<br>
</p>
