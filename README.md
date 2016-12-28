# docker-rails-mysql

## Ubuntu 

### Installation
  - install docker: https://docs.docker.com/engine/installation/linux/ubuntulinux/
  - install docker-compose: https://docs.docker.com/compose/install/

### Getting started
  - setting up the docker image and verify it's working:
    ```sh
    docker build -t demo .
    
    verification step: docker run -it -p 3000:3000 -v $PWD:/app demo bash -l
    ```
  - setting up the docker-compose service & container
    ```sh
    docker-compose build
    
    docker-compose up -d mysql

    docker-compose run app bash -l -c "rake db:create"
    
    docker-compose run app bash -l -c "rake db:migrate"

    docker-compose run app bash -l -c "rake db:seed"
    
    docker-compose up
    ```

### Starting the server
  ```sh
  docker-compose run -p 3000:3000 app
  ```

### Debug
  ```sh
  docker-compose run app bash -l
  ```

### Cleaning docker-compose
  ```sh
  docker-compose rm -f
  docker-compose pull
  docker-compose up --build -d
  ```
### Notes
  - installing ruby without rvm will save you the hassle of running bash everytime in login shell to be able to acess it
  - to get your docker environment variables run:

  ```sh 
  docker-compose run [service] env
  ```
  - exposing port 80 is needed for http requests, and 443 for https.
  - most of the latest mysql versions may raise error if primary key settings is not defined, if you faced it you will need to add this:
  
  ```ruby 
  # config/initializers/abstract_mysql2_adapter.rb  
   class ActiveRecord::ConnectionAdapters::Mysql2Adapter
     NATIVE_DATABASE_TYPES[:primary_key] = "int(11) auto_increment PRIMARY KEY"
   end
  ```
  
