<@requirement.NODE 'sc-ui-automation' 'sc-ui-automation-${namespace}' 'sc-ui-automation-standby-${namespace}' />

<@requirement.PARAM name='TAG' value='' type='tag' />
<@requirement.PARAM name='PUBLISHED_PORT' value='7001' required='false' type='port' />
<@requirement.PARAM name='PUBLIC_URL' value='/automation' required='true' description='automation context' />

<@img.TASK 'sc-ui-automation-${namespace}' '172.25.6.89:8123/repository/image-smart-control/microfrontends/ui-automation:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-ui-automation' />
  <@img.PORT PARAMS.PUBLISHED_PORT '7001' />
  <@img.CHECK_PORT '7001' />

  <@img.ENV 'PUBLIC_URL' PARAMS.PUBLIC_URL />

</@img.TASK>
