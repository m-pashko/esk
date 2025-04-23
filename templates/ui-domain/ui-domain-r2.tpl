<@requirement.NODE 'sc-ui-domain' 'sc-ui-domain-${namespace}' 'sc-ui-domain-standby-${namespace}' />

<@requirement.PARAM name='TAG' type='tag' value='' />
<@requirement.PARAM name='PUBLISHED_PORT' value='7002' required='false' type='port' />
<@requirement.PARAM name='MONITORING_PORT' value='19108' required='false' type='port' />
<@requirement.PARAM name='PUBLIC_URL' value='/domain' required='true' description='http://localhost:7002/' />

<@img.TASK 'sc-ui-domain-${namespace}' '172.25.6.89:8123/ui-domain:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-ui-domain' />
  <@img.PORT PARAMS.PUBLISHED_PORT '7002' />
  <@img.PORT PARAMS.MONITORING_PORT '19108' />
  <@img.ENV 'MONITORING_PORT' PARAMS.MONITORING_PORT />
  <@img.CHECK_PORT '7002' />
  <@img.ENV 'PUBLIC_URL' PARAMS.PUBLIC_URL />
</@img.TASK>
