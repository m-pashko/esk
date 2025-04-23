<@requirement.NODE 'sc-dns' 'sc-dns-${namespace}' 'sc-dns-standby-${namespace}' />
<@requirement.PARAM name='FORWARD_ZONES' value='somedom.example.com=192.168.1.2' type='textarea' />
<@requirement.PARAM name='DNS_ZONE_NAME' value='somedom.example.com' type='textarea' />
<@requirement.PARAM name='DNS_FORWARDER_IP' value='192.168.1.2' type='textarea' />
<@requirement.PARAM name='MONITORING_PORT' required='false' type='port' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-dns-${namespace}' '172.25.6.89:8123/dns:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-dns' />
  <@img.ENV 'FORWARD_ZONES' PARAMS.FORWARD_ZONES />
  <@img.ENV 'DNS_ZONE_NAME' PARAMS.DNS_ZONE_NAME />
  <@img.ENV 'DNS_FORWARDER_IP' PARAMS.DNS_FORWARDER_IP />
  <@img.PORT '53' '53' 'global' 'udp' />
  <@img.PORT '53' '53' 'global' 'tcp' />
  <@img.PORT PARAMS.MONITORING_PORT '19102' 'global' />
</@img.TASK>
