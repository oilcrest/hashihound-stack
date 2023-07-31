#TODO: This has issues assigning the correct IPs to the instances. Fix that.

domain   = 'test.hiddenhound.com'
AutoNetwork.default_pool = '192.168.0.0/24'

nodes = [
  { :hostname => 'node1',   :ip => '192.168.0.141', :box => 'generic/alpine38' },
  { :hostname => 'node2',   :ip => '192.168.0.142', :box => 'generic/alpine38' },
  { :hostname => 'node3',   :ip => '192.168.0.143', :box => 'generic/alpine38' },
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = "generic/alpine38"
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, :auto_network => true      
      #nodeconfig.vm.network :private_network, ip: node[:ip]
      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :libvirt do |vb|
      end
    end
  end
end
