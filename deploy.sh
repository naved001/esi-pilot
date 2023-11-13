#!/bin/sh

openstack overcloud deploy --stack overcloud \
		--templates /usr/share/openstack-tripleo-heat-templates \
		--networks-file custom_network_data.yaml \
		--vip-file custom_vip_data.yaml \
		--baremetal-deployment overcloud_baremetal_deploy.yaml \
		--roles-file roles_data.yaml \
		-e containers-prepare-parameter.yaml \
		-e /usr/share/openstack-tripleo-heat-templates/environments/memcached-use-ips.yaml \
		-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ml2-ansible.yaml \
		-e /usr/share/openstack-tripleo-heat-templates/environments/services/neutron-ovs.yaml \
		-e enable-tls.yaml \
		-e tls-endpoints-public-dns.yaml \
		-e cloudname.yaml \
		-e esi-custom.yaml \
		-e templates/template_file.yaml \
		#-e sso_extraconfig.yaml \
		#-e sso_vars.yaml \
		--overcloud-ssh-user tripleo-admin \
		--overcloud-ssh-key ~/.ssh/id_rsa
