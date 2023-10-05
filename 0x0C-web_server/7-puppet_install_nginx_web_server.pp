# Script to install nginx and configure redirection using Puppet

package { 'nginx':
  ensure => 'present',
}

exec { 'install':
  command  => 'sudo apt-get update ; sudo apt-get -y install nginx',
  provider => shell,
}

exec { 'Hello':
  command  => 'echo "Hello World!" | sudo tee /var/www/html/index.html',
  provider => shell,
}

exec { 'configure_redirect':
  command  => 'sudo sed -i "s/listen 80 default_server;/listen 80 default_server;\\n\\tlocation \\/redirect_me {\\n\\t\\treturn 301 https:\\/\\/youtube.com\\/\\@Conerstoneassembly?si=nTZbSVZ2N-4k16ah;\\n\\t}/" /etc/nginx/sites-available/default && sudo service nginx restart',
  provider => shell,
}
