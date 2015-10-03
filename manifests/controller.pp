# == Class: calico
#
class calico::controller (
  $etcd_host = $calico::controller_etcd_host,
  $etcd_port = $calico::controller_etcd_port,
) {

  # Add calico-specific config to neutron.conf
  neutron_config {
    'calico/etcd_host': value => $etcd_host;
    'calico/etcd_port': value => $etcd_port;
  }

  package { $calico::controller_package:
    ensure => installed,
  }

  # Install the package, then notify the neutron service
  Package[$calico::controller_package] ~>
  Service[$calico::neutron_service]

}
