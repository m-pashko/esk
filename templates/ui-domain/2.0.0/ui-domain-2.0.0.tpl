<@requirement.NODE 'web' 'sc-ui-${namespace}' 'sc-ui-standby-${namespace}' />

<@requirement.PARAM name='TAG' type='tag' value='' />
<@requirement.PARAM name='PUBLISHED_PORT' value='3000' required='false' type='port' />
<@requirement.PARAM name='API_URL' value='http://sc-gw-directory:8080' required='true' description='api url' />
<@requirement.PARAM name='MENU_URL_INVENTORY' required='false' description='http://localhost:8080/' />
<@requirement.PARAM name='MENU_URL_CONNECTION' required='false' description='http://localhost:8080/' />
<@requirement.PARAM name='MENU_URL_CONTROL' required='false' description='http://localhost:8080/' />
<@requirement.PARAM name='LOGO_URL_BIG' required='false' description='http://localhost:8080/' />
<@requirement.PARAM name='LOGO_URL_SMALL' required='false' description='http://localhost:8080/' />
<@requirement.PARAM name='VITE_PUBLIC_URL' value='/domain' required='true' description='http://localhost:8080/' />

<@img.TASK 'web-${namespace}' '172.25.6.89:8123/ui-domain:${PARAMS.TAG}'>
  <@img.NODE_REF 'web' />
  <@img.PORT PARAMS.PUBLISHED_PORT '3000' />
  <@img.CHECK_PORT '3000' />
  <@img.ENV 'API_URL' PARAMS.API_URL />
  <@img.ENV 'MENU_URL_INVENTORY' PARAMS.MENU_URL_INVENTORY />
  <@img.ENV 'MENU_URL_CONNECTION' PARAMS.MENU_URL_CONNECTION />
  <@img.ENV 'MENU_URL_CONTROL' PARAMS.MENU_URL_CONTROL />
  <@img.ENV 'LOGO_URL_BIG' PARAMS.LOGO_URL_BIG />
  <@img.ENV 'LOGO_URL_SMALL' PARAMS.LOGO_URL_SMALL />
  <@img.ENV 'VITE_PUBLIC_URL' PARAMS.VITE_PUBLIC_URL />
</@img.TASK>
