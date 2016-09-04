
desc 'Creates Docker containers (with required names for docker-compose.yml)'
task :dockerize do
  system 'cd RandomNumberServiceContainer/ && docker build -t random-number-service .'
  system 'cd WebAppContainer/ && docker build -t random-number-web-app .'
end

desc 'Runs web-app on localhost on port 8080'
task run_with_docker_compose: :dockerize do
  system 'docker-compose run -d -p 8080:8080 web-app'
end

desc 'Runs application locally'
task :run_locally do
  puts 'Run manually with (process cleanup issues exist running with Rake): sh ./run_locally.sh'
end

task default: :run_with_docker_compose
