Vagrant.configure("2") do |config|
    config.vm.box = "bytepark/trusty-64"
    config.vm.network :private_network, ip: "10.0.0.5"
    config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
    config.vm.network :forwarded_port, guest: 443, host: 4443, auto_correct: true
    config.vm.provision "shell", path: ".provision/provision.sh"
    config.vm.synced_folder ".", "/vagrant", id: "vagrant-root",
        :nfs => true,
        :mount_options => ["intr", "noatime", "nolock"],
        :linux__nfs_options => ["all_squash", "async", "no_subtree_check", "rw"]
end