FROM ruby:3.1.2

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
RUN apt-get update                                                                                                                      \
  && apt-get install                                                                                                                    \
    openssl                                                                                                                             \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash -                                                                            \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -                                                                  \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list                                      \
  && wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb                                                                   \
  && DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.22-1_all.deb                                                           \
  && apt-get update                                                                                                                     \
  && apt-get remove -y                                                                                                                  \
    libmariadbclient18                                                                                                                  \
    libmariadbclient-dev-compat                                                                                                         \
    libmariadbclient-dev                                                                                                                \
  && apt-get install -y --allow-unauthenticated                                                                                         \
    libmysqlclient-dev                                                                                                                  \
    mysql-client                                                                                                                        \
    libxml2-dev                                                                                                                         \
    libxslt-dev                                                                                                                         \
    libc6-dev                                                                                                                           \
    nodejs                                                                                                                              \
    yarn                                                                                                                                \
    zip                                                                                                                                 \
  && gem install foreman                                                                                                                \
  && apt-get clean

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
