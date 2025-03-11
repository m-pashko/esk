<@requirement.NODE 'ui-automation' 'sc-ui-automation-${namespace}' 'sc-ui-automation-standby-${namespace}' />

<@requirement.PARAM name='TAG' value='' type='tag' />
<@requirement.PARAM name='PUBLISHED_PORT' value='3002' required='false' type='port' />
<@requirement.PARAM name='PUBLIC_URL' value='/automation' required='true' description='automation context' />
<@requirement.PARAM name='REACT_APP_ALT_REMOTE_URL' value='http://localhost' required='true' description='app remote url' />
<@requirement.PARAM name='REACT_APP_API_ROOT' value='http://localhost' required='true' description='app root' />
<@requirement.PARAM name='REACT_APP_LOGO' value='https://4914339348.obj-storage.com/files/big/1860/1859468.jpg?d86f3c9bfb6953c42384a2ad195eaf43' required='true' description='app logo' />
<@requirement.PARAM name='REACT_APP_REMOTE_URL' value='http://localhost' required='true' description='app root' />
<@requirement.PARAM name='REACT_APP_TITLE' value='Ростелеком' required='true' description='app logo' />

<@img.TASK 'ui-automation-${namespace}' 'docker.t-rtk-it.ru/repository/image-smart-control/inventory/ui-automation:${PARAMS.TAG}'>
  <@img.NODE_REF 'ui-automation' />
  <@img.PORT PARAMS.PUBLISHED_PORT '80' />
  <@img.CHECK_PORT '80' />

  <@img.ENV 'PUBLIC_URL' PARAMS.PUBLIC_URL />
  <@img.ENV 'REACT_APP_ALT_REMOTE_URL' PARAMS.REACT_APP_ALT_REMOTE_URL />
  <@img.ENV 'REACT_APP_API_ROOT' PARAMS.REACT_APP_API_ROOT />
  <@img.ENV 'REACT_APP_LOGO' PARAMS.REACT_APP_LOGO />
  <@img.ENV 'REACT_APP_REMOTE_URL' PARAMS.REACT_APP_REMOTE_URL />
  <@img.ENV 'REACT_APP_TITLE' PARAMS.REACT_APP_TITLE />

</@img.TASK>
