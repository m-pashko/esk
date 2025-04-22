<@requirement.NODE 'sc-platform-update' 'sc-platform-update-${namespace}' 'sc-platform-update-standby-${namespace}' />

<@requirement.PARAM name='UPDATE_CONFIG_URL' value='http://<external-web-server>/versions.json' description='Адрес для получения конфигурации обновления ПО' />
<@requirement.PARAM name='UPDATE_INTERVAL' value='60' description='Временной интервал проверки наличия обновлений (в минутах)' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-platform-update-${namespace}' 'registry:5000/platform-update:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-platform-update' />
  <@img.ENV 'UPDATE_CONFIG_URL' PARAMS.UPDATE_CONFIG_URL />
  <@img.ENV 'UPDATE_INTERVAL' PARAMS.UPDATE_INTERVAL />
</@img.TASK> 
