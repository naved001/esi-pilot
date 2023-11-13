#!/bin/sh

openstack baremetal node undeploy oct10-04
openstack baremetal node undeploy oct10-05
openstack baremetal node undeploy oct10-06
openstack port delete overcloud-controller-0-ctlplane
openstack port delete overcloud-controller-1-ctlplane
openstack port delete overcloud-controller-2-ctlplane
