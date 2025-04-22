<@requirement.NODE 'sc-eureka' 'sc-eureka-${namespace}' 'sc-eureka-standby-${namespace}' />

<@requirement.PARAM name='EUREKA_PUBLISHED_PORT' type='port' value='' required='false' scope='global' />

<@requirement.PARAM name='JAVA_OPTS' value='' required='false' scope='global' />
<@requirement.PARAM name='JMX_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_SUSPEND_ON_START' values='n,y' required='false' type='select' />

<@requirement.PARAM name='TAG' value='' type='tag' />

<@requirement.PARAM name='ES_URL' required='false' description='URL ElasticSearch' />
<@requirement.PARAM name='LS_JAVA_OPTS' value='-Xms1g -Xmx1g -Dnetworkaddress.cache.ttl=10' depends='ES_URL' description='Параметры JVM для LogStash' />
<@requirement.PARAM name='ES_USERNAME' required='false' value='' depends='ES_URL' description='Имя пользователя ElasticSearch' />
<@requirement.PARAM name='ES_PASSWORD' required='false' type='password' depends='ES_URL' description='Пароль ElasticSearch' />
<@requirement.PARAM name='ROLL_OVER_SIZE_GB' value='25' depends='ES_URL' description='Запускает rollover, когда индекс достигает определенного размера' />
<@requirement.PARAM name='ROLL_OVER_DAYS' value='1' depends='ES_URL' description='Запускает rollover по истечении максимального времени, прошедшего с момента создания индекса' />
<@requirement.PARAM name='DELETE_DAYS' value='30' depends='ES_URL' description='Очистка данных мониторинга по истечении заданного количества дней' />

<@img.TASK 'sc-eureka-${namespace}' 'registry:5000/eureka:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-eureka' />
  <@img.PORT PARAMS.EUREKA_PUBLISHED_PORT '8761' />
  <@img.PORT PARAMS.JMX_PORT PARAMS.JMX_PORT />
  <@img.PORT PARAMS.DEBUGGER_PORT '8000' />
  <@img.VOLUME '/tmp' />
  <@img.STOP_GRACE_PERIOD '60s' />

  <@img.ENV 'JAVA_OPTS' PARAMS.JAVA_OPTS />
  <@img.ENV 'JMX_PORT' PARAMS.JMX_PORT />
  <@img.ENV 'DEBUGGER_PORT' PARAMS.DEBUGGER_PORT />
  <@img.ENV 'DEBUGGER_SUSPEND_ON_START' PARAMS.DEBUGGER_SUSPEND_ON_START />

  <#if PARAMS.ES_URL?has_content>
    <@img.ENV 'LOGSTASH_HOST' 'logstash-sc-eureka-${namespace}:4560' />
  </#if>

  <@img.CHECK_PORT '8761' />

</@img.TASK>

<#if PARAMS.ES_URL?has_content>
  <@img.TASK 'logstash-sc-eureka-${namespace}' 'imagenarium/logstash:7.17.1'>
    <@img.NODE_REF 'sc-eureka' />
    <@img.ENV 'ELASTICSEARCH_URL' PARAMS.ES_URL />
    <@img.ENV 'ELASTICSEARCH_USERNAME' PARAMS.ES_USERNAME />
    <@img.ENV 'ELASTICSEARCH_PASSWORD' PARAMS.ES_PASSWORD />
    <@img.ENV 'LS_JAVA_OPTS' PARAMS.LS_JAVA_OPTS />
    <@img.ENV 'NODE_NAME' 'logstash-sc-eureka-${namespace}' />
    <@img.ENV 'NUMBER_OF_REPLICAS' '0' />
    <@img.ENV 'INDEX_NAME' 'sc-eureka' />
    <@img.ENV 'ROLL_OVER_SIZE_GB' PARAMS.ROLL_OVER_SIZE_GB />
    <@img.ENV 'ROLL_OVER_DAYS' PARAMS.ROLL_OVER_DAYS />
    <@img.ENV 'DELETE_DAYS' PARAMS.DELETE_DAYS />
    <@img.CHECK_PORT '4560' />
  </@img.TASK>
</#if>
