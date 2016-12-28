FROM ubuntu:14.04.5

RUN apt-get update

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y --no-install-recommends curl openssl git libmysqlclient-dev

# Install RVM, Ruby
RUN apt-get install -y --no-install-recommends libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN echo insecure >> ~/.curlrc
RUN \curl -sSL https://get.rvm.io | bash
RUN bash -c "source /etc/profile.d/rvm.sh && rvm install ruby-1.9.3-p484"

# RUN echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc 

# Install apt based dependencies required to run Rails as 
# well as RubyGems. As the Ruby image itself is based on a 
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \ 
  build-essential \ 
  nodejs \
  imagemagick

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Copy the main application.
COPY . ./

# Install bundler and application gems
RUN bash -l -c "gem install bundler --no-ri --no-rdoc && bundle install"

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000

# for http requests
EXPOSE 80

# Configure an entry point, so we don't need to specify 
# "bundle exec" for each of our commands.
# ENTRYPOINT ["/bin/bash", "-l", "-i", "-c", "bundle", "exec"]

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
# CMD ["rails", "server", "-b", "0.0.0.0"]
