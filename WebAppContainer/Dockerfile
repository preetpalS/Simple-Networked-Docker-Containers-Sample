
FROM ubuntu:16.04

# Update available packages
RUN apt-get update

# Install development environment for Ruby
RUN apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

# Install Ruby
RUN apt-get -y install ruby ruby-dev ruby-bundler

# Create user with home directory and copy over local app directory
RUN mkdir -p /home/app/app
RUN useradd -d /home/app app
ADD ./app /home/app/app
RUN chown -R app:users /home/app

# Switch over to created user and run bundler
USER app
RUN cd /home/app/app &&  bundle --deployment

# Run application as created user
WORKDIR /home/app/app
CMD ["bundle", "exec", "rake"]
EXPOSE 8080
