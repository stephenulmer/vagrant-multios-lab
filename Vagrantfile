# -*- mode: ruby -*-
# vi: set ft=ruby :

windows_managed_nodes = 3
windows_vagrant_box = "slu/windows-11-arm64"

linux_managed_nodes = 0
linux_vagrant_box = "slu/rhel-9.4"

Vagrant.configure("2") do |config|

  config.vm.define "control" do |control|
    control.vm.box = "slu/rhel-9.4+ansible_core"
    control.vm.box_check_update = false
    control.vm.hostname = "control"
    config.vm.communicator = "ssh"
    config.vm.guest = :linux
    control.vm.provider "parallels" do |prl|
      prl.name = "control"
      prl.update_guest_tools = false
    end
    control.ssh.forward_agent = true
  end

  (1..windows_managed_nodes).each do |n|
    config.vm.define "win#{n}" do |node|
      node.vm.box = windows_vagrant_box
      node.vm.box_check_update = false
      node.vm.hostname = "win#{n}"
      node.vm.communicator = "winssh"      # Windows
      node.vm.guest = :windows             # Windows
      node.vm.provider "parallels" do |prl|
        prl.name = "win#{n}"
        prl.update_guest_tools = false
      end
    end
  end

  (1..linux_managed_nodes).each do |n|
    config.vm.define "lin#{n}" do |node|
      node.vm.box = linux_vagrant_box
      node.vm.box_check_update = false
      node.vm.hostname = "lin#{n}"
      node.vm.communicator = "ssh"
      node.vm.guest = :linux
      node.vm.provider "parallels" do |prl|
        prl.name = "lin#{n}"
        prl.update_guest_tools = false
      end
    end
  end

  config.trigger.after :up, type: :action do |trigger|
    trigger.info = "Adding injected ssh keys to ssh agent."
    trigger.run = { path: "ssh_agent_add_boxes.sh" }
  end
end
