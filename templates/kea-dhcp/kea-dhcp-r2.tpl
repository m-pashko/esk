<@requirement.NODE 'sc-kea-dhcp' 'sc-kea-dhcp-${namespace}' 'sc-kea-dhcp-standby-${namespace}' />

<@requirement.PARAM name='CTRL_PUBLISHED_PORT' required='false' value='8000' type='port' />
<@requirement.PARAM name='REGISTRY' value='registry:5000' />
<@requirement.PARAM name='REGISTRY_USER' required='false' value='' />
<@requirement.PARAM name='REGISTRY_PWD' required='false' value='' type='' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-kea-dhcp-${namespace}' '172.25.6.89:8123/kea-dhcp-launcher:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-kea-dhcp' />
  <@img.ENV 'CTRL_PUBLISHED_PORT' PARAMS.CTRL_PUBLISHED_PORT />
  <@img.ENV 'REGISTRY' PARAMS.REGISTRY />
  <@img.ENV 'REGISTRY_USER' PARAMS.REGISTRY_USER />
  <@img.ENV 'REGISTRY_PWD' PARAMS.REGISTRY_PWD />
</@img.TASK>
