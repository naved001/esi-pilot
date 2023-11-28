#!/bin/sh

# provisioning network
openstack network create --provider-network-type vlan --provider-segment 700 --provider-physical-network datacentre --share provisioning
openstack subnet create \
      --network provisioning \
      --subnet-range 192.168.11.0/24  \
      --ip-version 4 \
      --gateway 192.168.11.254 \
      --allocation-pool start=192.168.11.51,end=192.168.11.149 \
      --dns-nameserver 8.8.8.8 \
      --dhcp subnet-provisioning

# ctlplane network
openstack network create --provider-network-type flat --provider-physical-network  datacentre ctlplane
openstack subnet create --network ctlplane --subnet-range 192.168.24.0/24  --ip-version 4 --gateway 192.168.24.254 --no-dhcp ctlplane-subnet

# storage network
openstack network create --provider-network-type vlan --provider-segment 213 --provider-physical-network datacentre  --share storage
openstack subnet create \
          --network storage \
          --subnet-range 10.21.0.0/22  \
          --ip-version 4 \
          --gateway 10.21.0.1 \
          --allocation-pool start=10.21.0.160,end=10.21.0.200 \
          --dns-nameserver 8.8.8.8 \
          --dhcp subnet-storage

# external network
openstack network create --provider-network-type vlan --provider-segment 3801 --provider-physical-network datacentre  --external --share external
openstack subnet create \
          --network external \
          --subnet-range 128.31.20.0/22  \
          --ip-version 4 \
          --gateway 128.31.20.1 \
          --allocation-pool start=128.31.21.0,end=128.31.21.240 \
          --dns-nameserver 8.8.8.8 \
          --dhcp subnet-external

# provisioning router
openstack router create provisionrouter
openstack router add subnet provisionrouter subnet-provisioning
openstack router add subnet provisionrouter ctlplane-subnet
openstack router add subnet provisionrouter subnet-storage
openstack router set --external-gateway external provisionrouter
