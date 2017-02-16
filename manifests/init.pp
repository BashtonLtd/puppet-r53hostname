# Set a route 53 hostname for this instance
# By default sets hostname to $service.$
class r53hostname (
  $service       = $::profile,
  $zone          = "${::domain}.",
  $includeaz     = true,
  $includeregion = false,
  $ips           = [$::ipaddress],
  $ttl           = 60,
  $env           = $::envname,
  $includeenv    = false
  ) {

  if ($includeregion == true) {
    $record = "${service}.${::region}.${zone}"
  } elsif ($includeaz == true) {
    $record = "${service}.${::ec2_metadata['placement']['availability-zone']}.${zone}"
  } elsif ($includeenv == true) {
    $record = "${service}-${env}.${::region}.${zone}"
  } else {
    $record = "${service}.${zone}"
  }

  if ($::ec2_metadata['public-hostname']
      and $::ec2_metadata['public-hostname'] != '') {

    route53_cname_record { $record:
      ensure => 'present',
      zone   => $zone,
      ttl    => $ttl,
      values => $::ec2_metadata['public-hostname']
    }

  } else {

    route53_a_record { $record:
      ensure => 'present',
      zone   => $zone,
      ttl    => $ttl,
      values => $ips,
    }
  }
}
