
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, :inline => <<-HEREDOC
    ansible localhost -m apt -a 'name=software-properties-common state=latest' ||
      apt-get -y install software-properties-common
    ansible localhost -m apt_repository -a "repo='ppa:ansible/ansible' " || 
      apt-add-repository ppa:ansible/ansible
    ansible localhost -m apt -a 'name=ansible state=latest update_cache=yes' ||
       { apt-get update ; apt-get -y install ansible ; }
    ansible localhost -m apt -a 'name=python2.7 state=present'
    ansible localhost -m apt -a 'name=mercurial state=present'
    ansible localhost -m apt -a 'name=screen state=present'
    ansible localhost -m user -a '
      name=galaxy
      comment="Galaxy"
      shell=/bin/bash'
    ansible localhost -m shell -a '
      chdir=/home/galaxy/
      creates=galaxy-dist/
      su -c "hg clone https://bitbucket.org/galaxy/galaxy-dist/" galaxy'
    ansible localhost -m shell -a '
      chdir=/home/galaxy/galaxy-dist
      su -c "hg update stable" galaxy'
    ansible localhost -m shell -a "
      chdir=/home/galaxy/galaxy-dist/config/
      creates=galaxy.ini
      grep -v -e '^$' -e '^#' galaxy.ini.sample > galaxy.ini"
    ansible localhost -m lineinfile -a "
      dest=/home/galaxy/galaxy-dist/config/galaxy.ini
      insertafter='server:main'
      line='host = 0.0.0.0'"
    ansible localhost -m file -a "
      path=/home/galaxy/galaxy-dist/config/galaxy.ini
      owner=galaxy
      group=galaxy"
  HEREDOC
end

