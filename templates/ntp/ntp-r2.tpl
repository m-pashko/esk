<@requirement.NODE 'sc-ntp' 'sc-ntp-${namespace}' 'sc-ntp-standby-${namespace}' />

<@requirement.PARAM name='NTP_SERVER_CONFIG' value='pool.ntp.org' type='textarea' />
<@requirement.PARAM name='CTRL_USER' value='' required='true' description='Имя пользователя для управления NTP сервером' />
<@requirement.PARAM name='CTRL_PASS' value='' required='true' type='password' description='Пароль пользователя NTP сервера' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-ntp-${namespace}' '172.25.6.89:8123/ntp:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-ntp' />
  <@img.ENV 'NTP_SERVER_CONFIG' PARAMS.NTP_SERVER_CONFIG />
  <@img.ENV 'CTRL_USER' PARAMS.CTRL_USER />
  <@img.ENV 'CTRL_PASS' PARAMS.CTRL_PASS />
  <@img.PORT '123' '123' 'global' 'udp' />
  <@img.PORT '1123' '1123' 'global' 'tcp' />
  <@img.VOLUME '/etc/chrony.d' />
</@img.TASK>
