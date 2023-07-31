#TODO: This has issues assigning the correct IPs to the instances. Fix that.

domain   = 'test.hiddenhound.com'

nodes = [
  { :hostname => 'node01', :ip => '192.168.0.141', :box => 'generic/alpine38' },
  { :hostname => 'node02', :ip => '192.168.0.142', :box => 'generic/alpine38' },
  { :hostname => 'node03', :ip => '192.168.0.143', :box => 'generic/alpine38' },
  { :hostname => 'node04', :ip => '192.168.0.144', :box => 'generic/alpine38' },
  { :hostname => 'node05', :ip => '192.168.0.145', :box => 'generic/alpine38' },
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]
      memory = node[:ram] ? node[:ram] : 1024;
      nodeconfig.vm.provider :libvirt do |vb|
        config.vm.provision "shell" do |s|
          ssh_pub_key = File.readlines("./inventory/localdev/.ssh/id_rsa.pub").first.strip
          s.inline = <<-SHELL
          mkdir -p /home/vagrant/.ssh
          mkdir -p /root/.ssh
          echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
          echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
          SHELL
        end
      end
    end
  end
end
