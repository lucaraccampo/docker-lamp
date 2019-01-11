# How it works

This projects helps to use docker-compose with your application.

Follow instructions to start project correctly:

1. Copy and rename **.env_dist** in **.env** and edit it using your settings
2. If you want override some docker-composer's parameters copy and rename **docker-compose.override.yml.dist** **docker-compose.override.yml** (use default as an example)
3. Use init-db/ to store sql or sh file you want execute immediately after mysql container is inizialized
4. Run `docker-compose build && docker-compose up` (`-d if you prefer background mode) from terminal
5. Visit [http://localhost](http://localhost) to test.