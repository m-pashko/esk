<@requirement.NODE 'sc-ntp' 'sc-ntp-${namespace}' 'sc-ntp-standby-${namespace}' />

<@requirement.PARAM name='NTP_SERVER_CONFIG' value='pool.ntp.org' type='textarea' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-ntp-${namespace}' '172.25.6.89:8123/ntp:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-ntp' />
  <@img.ENV 'NTP_SERVER_CONFIG' PARAMS.NTP_SERVER_CONFIG />
  <@img.PORT '123' '123' 'global' 'udp' />
</@img.TASK>
