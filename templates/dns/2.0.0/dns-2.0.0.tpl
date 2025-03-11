<@requirement.NODE 'sc-dns' 'sc-dns-${namespace}' 'sc-dns-standby-${namespace}' />
<@requirement.PARAM name='FORWARD_ZONES' value='somedom.example.com=192.168.1.2' type='textarea' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-dns-${namespace}' '172.25.6.89:8123/dns:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-dns' />
  <@img.ENV 'FORWARD_ZONES' PARAMS.FORWARD_ZONES />
  <@img.PORT '53' '53' 'global' 'udp' />
  <@img.PORT '53' '53' 'global' 'tcp' />
</@img.TASK>
