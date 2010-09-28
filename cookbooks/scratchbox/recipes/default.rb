#
# Cookbook Name:: scratchbox
# Recipe:: default
#
# Copyright 2010, Ilkka Laukkanen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
bash "disable-vdso-in-sysctl-conf" do
  code "(sysctl vm.vdso_enabled|grep -q '0' || (echo vm.vdso_enabled = 0 >> /etc/sysctl.conf && sysctl -p))"
end

bash "set-mmap-min-addr-in-sysctl-conf" do
  code "(sysctl vm.mmap_min_addr|grep -q '0' || (echo vm.mmap_min_addr = 0 >> /etc/sysctl.conf && sysctl -p))"
end

remote_file '/tmp/maemo-scratchbox-install_5.0.sh' do
  source 'http://repository.maemo.org/stable/5.0/maemo-scratchbox-install_5.0.sh'
  mode '0755'
end

remote_file '/tmp/maemo-sdk-install_5.0.sh' do
  source 'http://repository.maemo.org/stable/5.0/maemo-sdk-install_5.0.sh'
  mode '0755'
end

bash 'install-scratchbox' do
  code '(test -d /scratchbox || /tmp/maemo-scratchbox-install_5.0.sh -u vagrant)'
end

bash 'install-sdk' do
  code '((sudo -u vagrant /scratchbox/login dpkg --get-selections|grep maemo-sdk) || sudo -u vagrant /tmp/maemo-sdk-install_5.0.sh)'
end

# setup shared sb directories
bash "mount-bind-vagrant-share-into-scratchbox" do
  code "(mkdir -p /scratchbox/users/vagrant/home/vagrant/work && chown vagrant:vagrant /scratchbox/users/vagrant/home/vagrant/work; mount -B /vagrant /scratchbox/users/vagrant/home/vagrant/work)"
end

