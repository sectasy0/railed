# Railed - Ruby On Rails production-ready starter kit 💎

![Ruby](https://img.shields.io/badge/ruby%203.3-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails%207-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![TailwindCSS](https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=for-the-badge&logo=tailwind-css&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)

Welcome to Railed, a Ruby On Rails boilerplate project designed for production use. This boilerplate comes pre-configured with Nginx, HTTP/2, and QUIC (HTTP/3) support to ensure optimal performance and security. Additionally, Railed contains a carefully curated list of pre-installed must-have Rails gems, streamlining the development process for building robust and feature-rich applications.

For exact list of ruby gems installed please check `Gemfile`.


## Features ✨:

* ***Nginx with HTTP/2 and QUIC Support***: Industry-standard web server known for its high performance, stability, and efficient handling of static and dynamic content. Take advantage of HTTP/2 for faster communication and embrace the future of the web with QUIC, a next-generation transport layer protocol designed to enhance speed and security.

* ***Docker and Docker-Compose***: Easily manage and deploy your application using Docker containers, with a separate docker-compose.yml file for each environment (development, testing, and production).

* ***Stimulus and Turbo***: Leverage the power of Stimulus for lightweight and modern JavaScript controllers, and Turbo to enhance the user experience by enabling seamless, fast navigation between pages.

* ***Tailwind CSS with Flowbite UI Components***: Utilize the flexibility and utility-first approach of Tailwind CSS, along with the Flowbite UI components, to expedite the styling process and ensure a modern, responsive design.

# Setting things up 🛠️
You don't have to touch `Dockerfile` because all system libraries for gems are already installed unless you added some gems that requires install some system c libs or something.

### Setting up application

1. Generate new `master key` by simply running `bin/rails runner 'puts ActiveSupport::EncryptedFile.generate_key` and put this key into `.env`.
2. Fill up things in `credentials.yml.enc` like in `config/credentials.yml.example`
3. Open `.env` and fill rest of the things expect `DATABASE_HOST` and `REDIS_HOST` unless you know what you're doing.

### Setting up database

1. Open `init.sql` and fill the init script with user and password that you will refer later in you application. TODO: read `.env` in `init.sql` to keep everything in `.env`

After that your app should run without any problems. If you experience any problems with this boilerplate please open an issue and describe everything, I'll try to help you out!

### Nginx Configuration:
The Nginx configuration files are located in the `./proxy` directory. Adjust the settings according to your production environment. Replace the default localhost.crt and private.key files with your own SSL/TLS certificate and private key.

### Run application

```sh
docker-compose -f docker-compose.dev.yml up
```

### Run tests in development env
```sh
docker-compose exec -e RAILS_ENV=test app bin/rspec
```

# Acknowledgments:
Special thanks to the Ruby on Rails, Nginx, Stimulus, Turbo, Tailwind CSS, and Docker communities for their invaluable contributions.

Happy coding with Railed! 🚀
