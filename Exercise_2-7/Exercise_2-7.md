# Exercise 2.7

The docker-compose.yml for machine learning contains 3 services: frontend, backend and training.
Each service build is linked to the github page.

Front-end exposes port 3000 and depends on backend to start before. Also restart: unless-stopped is defined.

Backend exposes port 5000 and maps volume <b>models</b> to <b>/src/model</b>. Also restart: unless-stopped is defined.

Training maps two volumes:
- <b>models</b> (which is shared with backend) and maps to <b>/src/model</b>
- <b>images</b> which maps to <b>/src/imgs</b>

The container depends on backend to start before. No restart is defined as the container is defined to stop when the training code ends.

Two volumes is therefore introduced: <b>models</b> and <b>images</b>.

<pre>
<b>$ docker-compose up</b>
Creating volume "ex27_images" with default driver
Creating volume "ex27_models" with default driver
Creating mlback ...
Creating mlback ... done
Creating mltrain ...
Creating mlfront ...
Creating mltrain
Creating mlfront ... done
Attaching to mlback, mltrain, mlfront
mlfront     | INFO: Accepting connections at http://localhost:3000
mlback      | Using TensorFlow backend.
mlback      | Backend starting
mlback      | No 'kurkkumopotin.sav' model in the model volume. Waiting for training service to provide one.
mltrain     | Using TensorFlow backend.
mltrain     | gathering cucumbers...
mltrain     | gathering mopeds...
mltrain     | Epoch 1/5
mltrain     |
mltrain     | 14/14 [==============================] - 2s 132ms/step - loss: 1.1511 - acc: 0.3571
mltrain     | Epoch 2/5
mltrain     |
mltrain     | 14/14 [==============================] - 1s 63ms/step - loss: 0.5775 - acc: 0.7143
mltrain     | Epoch 3/5
mltrain     |
mltrain     | 14/14 [==============================] - 1s 70ms/step - loss: 0.2048 - acc: 0.9286
mltrain     | Epoch 4/5
mltrain     |
mltrain     | 14/14 [==============================] - 1s 72ms/step - loss: 0.2435 - acc: 0.9286
mltrain     | Epoch 5/5
mltrain     |
mltrain     | 14/14 [==============================] - 1s 65ms/step - loss: 0.1020 - acc: 1.0000
mltrain     |
mltrain     | 8/8 [==============================] - 0s 29ms/step
mltrain exited with code 0

...
</pre>

We can now open the webpage at http://localhost:3000
