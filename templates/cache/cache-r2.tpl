<@requirement.NODE 'sc-cache' 'sc-cache-${namespace}' 'sc-cache-standby-${namespace}' />

<@requirement.PARAM name='CACHE_USER' value='' />
<@requirement.PARAM name='CACHE_PASS' value='' type='password' />
<@requirement.PARAM name='PUBLISHED_PORT' required='false' value='11222' type='port' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-cache-${namespace}' 'registry:5000/cache:${PARAMS.TAG}'>
  <@img.PORT PARAMS.PUBLISHED_PORT '11222' />
  <@img.NODE_REF 'sc-cache' />
  <@img.ENV 'USER' PARAMS.CACHE_USER />
  <@img.ENV 'PASS' PARAMS.CACHE_PASS />
  <@img.CHECK_PORT '11222' />
</@img.TASK>
