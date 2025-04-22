<@requirement.NODE 'sc-unison' 'sc-unison-server-${namespace}' 'sc-unison-server-standby-${namespace}' />
<@requirement.PARAM name='VIRTUAL_VOLUME' value='false' type='boolean' />
<@requirement.PARAM name='VIRTUAL_VOLUME_SIZE_MB' values='128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576' value='1024' type='select' depends='VIRTUAL_VOLUME' />
<@requirement.PARAM name='PUBLISHED_PORT' required='false' value='' />
<@requirement.PARAM name='PUBLIC_KEY' type='textarea' required='true' value='' scope='global' description='' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-unison-server-${namespace}' 'registry:5000/unison:${PARAMS.TAG}'>
 <@img.NODE_REF 'sc-unison' />
 <@img.ENV 'PUBLIC_KEY' PARAMS.PUBLIC_KEY />
 <@img.VOLUME '/data' PARAMS.VIRTUAL_VOLUME?boolean?then('virtual','local') PARAMS.VIRTUAL_VOLUME_SIZE_MB />
 <@img.VOLUME '/private' PARAMS.VIRTUAL_VOLUME?boolean?then('virtual','local') PARAMS.VIRTUAL_VOLUME_SIZE_MB />
 <@img.VOLUME '/root' 'local' '128' />
 <@img.PORT PARAMS.PUBLISHED_PORT '22' />
</@img.TASK>
