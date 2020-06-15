# How it works

This projects helps to use docker-compose with your PHP application like Drupal, Symfony, Laravel.

Follow instructions to start project correctly:

1. Copy and rename **.env_dist** in **.env** and edit it using your settings
2. Copy and rename **config/php/example-php.ini** in **config/php/php.ini** and edit it using your config
3. Copy and rename **config/vhost/example.default.conf** in **config/vhost/default.conf** to create your virtual host
4. If you want override some docker-composer's parameters copy and rename **docker-compose.override.yml.dist** 
**docker-compose.override.yml** (use default as an example)
5. Use init-db/ to store sql or sh file you want execute immediately after mysql container is inizialized
6. Run `docker-compose build && docker-compose up` (`-d if you prefer background mode) from terminal
7. Visit [http://localhost](http://localhost) to test.
