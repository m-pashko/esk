<@requirement.NODE 'sc-mq' 'sc-mq-${namespace}' 'sc-mq-standby-${namespace}' />

<@requirement.PARAM name='VIRTUAL_VOLUME' value='false' type='boolean' />
<@requirement.PARAM name='VIRTUAL_VOLUME_SIZE_MB' values='128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576' value='1024' type='select' depends='VIRTUAL_VOLUME' />
<@requirement.PARAM name='PUBLISHED_PORT' required='false' type='port' value='5672' />
<@requirement.PARAM name='MONITORING_PORT' required='false' type='port' value='15692' />
<@requirement.PARAM name='MQ_DEFAULT_USER' value='' />
<@requirement.PARAM name='MQ_DEFAULT_PASS' value='' type='password' />
<@requirement.PARAM name='CLUSTER_HOST' required='false' />
<@requirement.PARAM name='CLUSTER_SECRET' required='false' />
<@requirement.PARAM name='LOG_LEVEL' value='warning' required='false' type='select' values='debug,info,warning,error,critical,none' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-mq-${namespace}' '172.25.6.89:8123/mq:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-mq' />
  <@img.VOLUME '/var/lib/rabbitmq' PARAMS.VIRTUAL_VOLUME?boolean?then('virtual','local') PARAMS.VIRTUAL_VOLUME_SIZE_MB />
  <@img.ENV 'RABBITMQ_DEFAULT_USER' PARAMS.MQ_DEFAULT_USER />
  <@img.ENV 'RABBITMQ_DEFAULT_PASS' PARAMS.MQ_DEFAULT_PASS />
  <@img.ENV 'CLUSTER_HOST' PARAMS.CLUSTER_HOST />
  <@img.ENV 'CLUSTER_SECRET' PARAMS.CLUSTER_SECRET />
  <@img.ENV 'LOG_LEVEL' PARAMS.LOG_LEVEL />
  <@img.PORT PARAMS.PUBLISHED_PORT '5672' 'global' />
  <@img.PORT PARAMS.MONITORING_PORT '15692' 'global' />
  <@img.CHECK_PORT '5672' />
</@img.TASK>
