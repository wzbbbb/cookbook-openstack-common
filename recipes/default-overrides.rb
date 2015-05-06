# Test lab overrides


# Prod Env analogs
# Networking: 
#  - Ports: eth1 -> bond1.2001 (LCP)
#  -        bond0 -> bond1.2004 (tunnel interface)
#  -        eth3 -> bond1.2002 (Data Plane!!)


# debugs
node.override["openstack"]["network"]["debug"] = "True"
node.override["openstack"]["network"]["verbose"] =  "True"
node.override["openstack"]["compute"]["debug"] = "True"
node.override["openstack"]["compute"]["verbose"] =  "True"

# ML2 and L3 agent plugins
node.override["openstack"]["network"]["core_plugin"] = "neutron.plugins.ml2.plugin.Ml2Plugin"
node.override["openstack"]["network"]["service_plugins"] = ["neutron.services.l3_router.l3_router_plugin.L3RouterPlugin"]
node.override["openstack"]["network"]["interface_driver_map"] = {
   "ovsinterfacedriver" => "ml2",
   "bridgeinterfacedriver" => "linuxbridge",
   "ml2interfacedriver" => "ml2"
}
node.override["openstack"]["network"]["ml2"]["type_drivers"] = "local,flat,vlan,gre,vxlan"
node.override["openstack"]["network"]["ml2"]["tenant_network_types"] = "gre"
node.override["openstack"]["compute"]["network"]["plugins"] = ["openvswitch"]
node.override["openstack"]["network"]["ml2"]["mechanism_drivers"] = "openvswitch,l2population"
node.override["openstack"]["network"]["ml2"]["tunnel_id_ranges"] = "1:32000"
node.override["openstack"]["network"]["ml2"]["integration_bridge"] = "br-int"
node.override["openstack"]["network"]["ml2"]["tunnel_bridge"] = "br-tun"
node.override["openstack"]["network"]["ml2"]["enable_tunneling"] = "True"
node.override["openstack"]["network"]["ml2"]["fw_driver"] = "neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver"
node.override["openstack"]["network"]["ml2"]["local_ip_interface"] = "bond1.2004@bond1"
#node.override['openstack']['network']['openvswitch']['local_ip_interface'] = "eth1" 
# L3 external bridge binding
node.override["openstack"]["network"]["l3"]["external_network_bridge_interface"] = "bond1.2002@bond1"
# Openvswitch 
node.override["openstack"]["network"]["openvswitch"]["local_ip_interface"] = "bond1.2004@bond1"
node.override["openstack"]["network"]["openvswitch"]["tunnel_id_ranges"] = "1:32000"
node.override["openstack"]["network"]["openvswitch"]["enable_tunneling"] = "True"
node.override["openstack"]["network"]["openvswitch"]["tenant_network_type"] = "gre"
# Nova network type (agent)
node.override["openstack"]["compute"]["network"]["service_type"] = "neutron"
# Vagrant / virtual box - related changes
node.override["openstack"]["compute"]["libvirt"]["virt_type"] = "kvm"
