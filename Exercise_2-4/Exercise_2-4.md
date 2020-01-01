# Exercise 2.4

The delay on compute module can be seen via the function
<b>await simpleWait(3000 + (Math.random() * 1000))</b>
which makes a wait between 3000-3999 ms for each calculation.

From the calculator module we can see that the total time for the test is 30 seconds,
during which time 10 queries is placed. This means that each response should take at
most 3 seconds.

But as the response can take 4 seconds, we need to scale compute=2 to be able to
response in time as the average response time is (4 seconds / 2) = 2 seconds.

So the scale is set as
<pre>
<b>$ docker-compose up --scale compute=2</b>
</pre>
