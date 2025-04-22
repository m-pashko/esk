<@requirement.NODE 'sc-automation-api' 'sc-automation-api-${namespace}' 'sc-automation-api-standby-${namespace}' />

<@requirement.PARAM name='AUTOMATION_API_PUBLISHED_PORT' type='port' value='' required='false' scope='global' />


<@requirement.PARAM name='JAVA_OPTS' value='' required='false' scope='global' />
<@requirement.PARAM name='JMX_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_SUSPEND_ON_START' values='n,y' required='false' type='select' />

<@requirement.PARAM name='LOG_LEVEL_ROOT' values='TRACE,DEBUG,INFO,WARN,ERROR' value='INFO' type='select' />
<@requirement.PARAM name='LOG_LEVEL_APPLICATION' values='TRACE,DEBUG,INFO,WARN,ERROR' value='ERROR' type='select' />

<@requirement.PARAM name='TAG' value='' type='tag' />


<@img.TASK 'sc-automation-api-${namespace}' 'registry:5000/automation-api:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-automation-api' />
  <@img.PORT PARAMS.AUTOMATION_API_PUBLISHED_PORT '8090' />
  <@img.PORT PARAMS.JMX_PORT PARAMS.JMX_PORT />
  <@img.PORT PARAMS.DEBUGGER_PORT '8000' />
  <@img.VOLUME '/tmp' />
  <@img.STOP_GRACE_PERIOD '60s' />

  <@img.ENV 'EUREKA_URI' 'http://sc-eureka-${namespace}:8761/eureka' />

  <@img.ENV 'LOG_LEVEL_ROOT' PARAMS.LOG_LEVEL_ROOT />
  <@img.ENV 'LOG_LEVEL_APPLICATION' PARAMS.LOG_LEVEL_APPLICATION />

  <@img.ENV 'JAVA_OPTS' PARAMS.JAVA_OPTS />
  <@img.ENV 'JMX_PORT' PARAMS.JMX_PORT />
  <@img.ENV 'DEBUGGER_PORT' PARAMS.DEBUGGER_PORT />
  <@img.ENV 'DEBUGGER_SUSPEND_ON_START' PARAMS.DEBUGGER_SUSPEND_ON_START />


  <#if PARAMS.ES_URL?has_content>
    <@img.ENV 'LOGSTASH_HOST' 'logstash-sc-automation-api-${namespace}:4560' />
  </#if>

  <@img.CHECK_PORT '8090' />

</@img.TASK>

<#if PARAMS.ES_URL?has_content>
  <@img.TASK 'logstash-sc-automation-api-${namespace}' 'imagenarium/logstash:7.17.1'>
    <@img.NODE_REF 'sc-automation-api' />
    <@img.ENV 'ELASTICSEARCH_URL' PARAMS.ES_URL />
    <@img.ENV 'ELASTICSEARCH_USERNAME' PARAMS.ES_USERNAME />
    <@img.ENV 'ELASTICSEARCH_PASSWORD' PARAMS.ES_PASSWORD />
    <@img.ENV 'LS_JAVA_OPTS' PARAMS.LS_JAVA_OPTS />
    <@img.ENV 'NODE_NAME' 'logstash-sc-automation-api-${namespace}' />
    <@img.ENV 'NUMBER_OF_REPLICAS' '0' />
    <@img.ENV 'INDEX_NAME' 'sc-automation-api' />
    <@img.ENV 'ROLL_OVER_SIZE_GB' PARAMS.ROLL_OVER_SIZE_GB />
    <@img.ENV 'ROLL_OVER_DAYS' PARAMS.ROLL_OVER_DAYS />
    <@img.ENV 'DELETE_DAYS' PARAMS.DELETE_DAYS />
    <@img.CHECK_PORT '4560' />
  </@img.TASK>
</#if>
