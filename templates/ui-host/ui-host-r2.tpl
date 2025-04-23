<@requirement.NODE 'sc-ui-host' 'sc-ui-host-${namespace}' 'sc-ui-host-standby-${namespace}' />

<@requirement.PARAM name='TAG' type='tag' value='' />
<@requirement.PARAM name='PUBLISHED_PORT' value='7000' required='false' type='port' />
<@requirement.PARAM name='REMOTE_URLS' value='domain_http://sc-ui-domain-ui:7002, automation_http://sc-ui-automation-ui:7001' required='true'
<@requirement.PARAM name='API_URL' value='http://sc-gw-directory:8080' required='true' description='api url' />
<@requirement.PARAM name='KEYCLOACK_SCOPE' value='openid' required='false' description='Scope for OIDC' />
<@requirement.PARAM name='KEYCLOACK_CLIENT_ID' value='smart-control' required='false' description='Client ID in OIDC Provider' />
<@requirement.PARAM name='KEYCLOACK_CLIENT_SECRET' value='' required='false' type="password" description='Client secret in OIDC Provider' />

<@img.TASK 'sc-ui-host-${namespace}' '172.25.6.89:8123/repository/image-smart-control/microfrontends/ui-host:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-ui-host' />
  <@img.PORT PARAMS.PUBLISHED_PORT '7000' />
  <@img.CHECK_PORT '7000' />
  <@img.ENV 'REMOTE_URLS' PARAMS.REMOTE_URLS />
  <@img.ENV 'API_URL' PARAMS.API_URL />
  <@img.ENV 'KEYCLOACK_SCOPE' PARAMS.KEYCLOACK_SCOPE />
  <@img.ENV 'KEYCLOACK_CLIENT_ID' PARAMS.KEYCLOACK_CLIENT_ID />
  <@img.ENV 'KEYCLOACK_CLIENT_SECRET' PARAMS.KEYCLOACK_CLIENT_SECRET />

</@img.TASK>