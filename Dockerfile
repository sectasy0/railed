FROM ruby:3.3.0-alpine3.18 as base
RUN addgroup -S app && adduser -S app -G app
RUN apk update && apk add --update alpine-sdk openssl vim less busybox-suid git
ENV APP_DIR /home/app/build


FROM base as nginx
WORKDIR /home/app

RUN apk add --no-cache openssl openssl-dev pcre zlib libgcc libstdc++ g++ make build-base \
    linux-headers ca-certificates automake autoconf git talloc talloc-dev gd-dev \
    libtool pcre-dev zlib-dev binutils gnupg cmake go mercurial libxslt libxslt-dev tini


# Install BoringSSL
RUN git clone https://boringssl.googlesource.com/boringssl && \
    cd boringssl && \
    mkdir -p build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE .. && \
    make && \
    make install && \
    cd ../..


# Install Nginx with BoringSSL and HTTP/3 support
ARG NGINX_VERSION=1.25.3
RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar xvf nginx-${NGINX_VERSION}.tar.gz && rm nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_v3_module \
    --with-http_realip_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_auth_request_module \
    --with-http_stub_status_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_image_filter_module \
    --with-http_secure_link_module \
    --with-http_degradation_module \
    --with-http_slice_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_realip_module \
    --with-stream_ssl_preread_module \
    --with-compat \
    --with-pcre-jit && \
    make && \
    make install && \
    cd .. && \
    rm -rf nginx-${NGINX_VERSION} && \
    rm -rf boringssl


RUN chown -R app:app /usr/local/nginx

USER app
COPY --chown=app:app .proxy/nginx.conf /etc/nginx/nginx.conf
COPY --chown=app:app .proxy/default.conf /etc/nginx/sites-enabled/default.conf
COPY --chown=app:app entrypoints/nginx-entrypoint.sh nginx-entrypoint.sh
RUN mkdir log && touch log/nginx.access.log log/nginx.error.log
RUN mkdir log/nginx && touch log/nginx/error.log
COPY --chown=app:app .proxy/localhost.crt localhost.crt
COPY --chown=app:app .proxy/private.key private.key
ENTRYPOINT ["sh", "nginx-entrypoint.sh"]

USER root

FROM base as app
RUN mkdir $APP_DIR
ENV BUNDLER_VERSION=2.4.7
RUN chown -R app:app $APP_DIR

RUN apk add binutils-gold file g++ gcc git libffi-dev libc-dev libxml2-dev \
    libgcrypt-dev make netcat-openbsd nodejs npm tzdata python3 yarn \
    postgresql-dev imagemagick

# Give the nessesary permissions to run the cron
RUN chmod u+s /usr/sbin/crond
RUN touch $APP_DIR/crontab
RUN chmod 0644 $APP_DIR/crontab

USER app

RUN gem install bundler -v 2.4.7

WORKDIR $APP_DIR
COPY --chown=app:app Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

COPY --chown=app:app . ./

ENTRYPOINT ["sh", "./entrypoints/docker-entrypoint.sh"]
