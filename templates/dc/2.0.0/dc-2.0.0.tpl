<@requirement.NODE 'sc-dc' 'sc-dc-${namespace}' 'sc-dc-standby-${namespace}' />

<@requirement.PARAM name='SELENGA_LDAP_URL' value='ldap://:389' />
<@requirement.PARAM name='SELENGA_BIND_DN' value='cn=Directory Manager' />
<@requirement.PARAM name='SELENGA_BIND_PW' value='' type='password' />
<@requirement.PARAM name='DC_LDAP_URL' value='ldap://:389' />
<@requirement.PARAM name='DC_BIND_DN' value='administrator@example.com' />
<@requirement.PARAM name='DC_BIND_PW' value='' type='password' />
<@requirement.PARAM name='BASE_DOMAIN_DN' value='dc=com' />
<@requirement.PARAM name='SELENGA_DC_PW' value='' type='password' />
<@requirement.PARAM name='DC_MODE' value='provision' values='provision,join' type='select' />
<@requirement.PARAM name='IF_NAME' value='eth0' />
<@requirement.PARAM name='DC_DOMAIN' value='example.com' />
<@requirement.PARAM name='DNS_IP' value='' />
<@requirement.PARAM name='DNS_FORWARDER' value='' />
<@requirement.PARAM name='DC_NAME' value='dc1' />
<@requirement.PARAM name='REGISTRY' value='172.25.6.89:8123' />
<@requirement.PARAM name='IPADRESS' required='true' value='' scope='global' description='' />
<@requirement.PARAM name='PORT' required='true' value='7522' scope='global' description=''/>
<@requirement.PARAM name='PRIVATE_KEY' type='textarea' required='true' value=''scope='global' description='' />
<@requirement.PARAM name='MQ_SERVER' value='' />
<@requirement.PARAM name='MQ_PORT' value='5672' />
<@requirement.PARAM name='MQ_USER' value='' />
<@requirement.PARAM name='MQ_PASS' value='' type='password' />
<@requirement.PARAM name='TAG_SYNC' value='' type='tag' />
<@requirement.PARAM name='TAG_DC_LAUNCHER' value='' type='tag' />
<@requirement.PARAM name='TAG_UNISON_CLIENT' value='' type='tag' />
<@requirement.PARAM name='LOG_LEVEL' value='3 passdb:5 auth:10 winbind:2' />

<@img.TASK 'sc-dc-${namespace}' '172.25.6.89:8123/dc-launcher:${PARAMS.TAG_DC_LAUNCHER}'>
  <@img.NODE_REF 'sc-dc' />
  <@img.VOLUME '/mnt' 'local' 1 />
  <@img.ENV 'SELENGA_DC_PW' PARAMS.SELENGA_DC_PW />
  <@img.ENV 'DC_MODE' PARAMS.DC_MODE />
  <@img.ENV 'IF_NAME' PARAMS.IF_NAME />
  <@img.ENV 'DC_DOMAIN' PARAMS.DC_DOMAIN />
  <@img.ENV 'DNS_IP' PARAMS.DNS_IP />
  <@img.ENV 'DNS_FORWARDER' PARAMS.DNS_FORWARDER />
  <@img.ENV 'DC_NAME' PARAMS.DC_NAME />
  <@img.ENV 'REGISTRY' PARAMS.REGISTRY />
  <@img.ENV 'LOG_LEVEL' PARAMS.LOG_LEVEL />
</@img.TASK>

<@img.TASK 'sc-sync-${namespace}' '172.25.6.89:8123/sync:${PARAMS.TAG_SYNC}'>
  <@img.NODE_REF 'sc-dc' />
  <@img.SHARED_VOLUME '/etc/samba' 'vol1-sc-${namespace}' 'local' />
  <@img.SHARED_VOLUME '/var/lib/samba' 'vol2-sc-${namespace}' 'local' />
  <@img.ENV 'SELENGA_LDAP_URL' PARAMS.SELENGA_LDAP_URL />
  <@img.ENV 'SELENGA_BIND_DN' PARAMS.SELENGA_BIND_DN />
  <@img.ENV 'SELENGA_BIND_PW' PARAMS.SELENGA_BIND_PW />
  <@img.ENV 'DC_LDAP_URL' PARAMS.DC_LDAP_URL />
  <@img.ENV 'DC_BIND_DN' PARAMS.DC_BIND_DN />
  <@img.ENV 'DC_BIND_PW' PARAMS.DC_BIND_PW />
  <@img.ENV 'BASE_DOMAIN' PARAMS.BASE_DOMAIN_DN />
  <@img.ENV 'DC_NAME' PARAMS.DC_NAME />
  <@img.ENV 'DC_DOMAIN' PARAMS.DC_DOMAIN />
  <@img.ENV 'DNS_IP' PARAMS.DNS_IP />
  <@img.ENV 'MQ_SERVER' PARAMS.MQ_SERVER />
  <@img.ENV 'MQ_PORT' PARAMS.MQ_PORT />
  <@img.ENV 'MQ_USER' PARAMS.MQ_USER />
  <@img.ENV 'MQ_PASS' PARAMS.MQ_PASS />
</@img.TASK>

<@img.TASK 'unison-launcher-${namespace}' '172.25.6.89:8123/unison-client:${PARAMS.TAG_UNISON_CLIENT}'>
  <@img.NODE_REF 'sc-dc' />
  <@img.SHARED_VOLUME '/data/' 'vol2-sc-${namespace}' 'local' />
  <@img.VOLUME '/root' 'local' '128' />
  <@img.ENV 'DC_MODE' PARAMS.DC_MODE />
  <@img.ENV 'IPADRESS' PARAMS.IPADRESS />
  <@img.ENV 'PORT' PARAMS.PORT />
  <@img.ENV 'PRIVATE_KEY' PARAMS.PRIVATE_KEY />
</@img.TASK>

