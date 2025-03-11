<@requirement.NODE 'sc-gw' 'sc-gw-${namespace}' 'sc-gw-standby-${namespace}' />

<@requirement.PARAM name='GW_PUBLISHED_PORT' type='port' value='' required='false' scope='global' />

<@requirement.PARAM name='CACHE_HOST' value='sc-cache-directory' />
<@requirement.PARAM name='CACHE_PORT' value='11222' />
<@requirement.PARAM name='CACHE_USER' value='' />
<@requirement.PARAM name='CACHE_PASS' value='' type='password' />

<@requirement.PARAM name='JAVA_OPTS' value='-Xms256m -Xmx256m -Djava.awt.headless=true' scope='global' />
<@requirement.PARAM name='JMX_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_SUSPEND_ON_START' values='n,y' required='false' type='select' />

<@requirement.PARAM name='SPRING_BOOT_ADMIN_CLIENT_ENABLED' value='false' values='true,false' type='select' />
<@requirement.PARAM name='SPRING_BOOT_ADMIN_CLIENT_URL' value='http://localhost:9090' />
<@requirement.PARAM name='LOG_LEVEL_ROOT' values='INFO,WARN,ERROR' value='ERROR' type='select' />
<@requirement.PARAM name='LOG_LEVEL_APPLICATION' values='INFO,WARN,ERROR' value='ERROR' type='select' />

<@requirement.PARAM name='TAG' value='' type='tag' />

<@requirement.PARAM name='ES_URL' required='false' description='ElasticSearch URL' />
<@requirement.PARAM name='LS_JAVA_OPTS' value='-Xms1g -Xmx1g -Dnetworkaddress.cache.ttl=10' depends='ES_URL' description='Параметры JVM для LogStash' />
<@requirement.PARAM name='ES_USERNAME' required='false' value='elastic' depends='ES_URL' description='Имя пользователя ElasticSearch' />
<@requirement.PARAM name='ES_PASSWORD' required='false' type='password' depends='ES_URL' description='Пароль ElasticSearch' />
<@requirement.PARAM name='ROLL_OVER_SIZE_GB' value='25' depends='ES_URL' description='Запускает rollover, когда индекс достигает определенного размера' />
<@requirement.PARAM name='ROLL_OVER_DAYS' value='1' depends='ES_URL' description='Запускает rollover по истечении максимального времени, прошедшего с момента создания индекса' />
<@requirement.PARAM name='DELETE_DAYS' value='30' depends='ES_URL' description='Очистка данных мониторинга по истечении заданного количества дней' />
<@requirement.PARAM name='INVENTORY_URL' value='http://localhost' required='false' description='URL до бэкенда Inventory' />

<@img.TASK 'sc-gw-${namespace}' '172.25.6.89:8123/gateway:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-gw' />
  <@img.PORT PARAMS.GW_PUBLISHED_PORT '8080' />
  <@img.PORT PARAMS.JMX_PORT PARAMS.JMX_PORT />
  <@img.PORT PARAMS.DEBUGGER_PORT '8000' />
  <@img.VOLUME '/tmp' />
  <@img.STOP_GRACE_PERIOD '60s' />

  <@img.ENV 'EUREKA_URI' 'http://sc-eureka-${namespace}:8761/eureka' />

  <@img.ENV 'CACHE_HOST' PARAMS.CACHE_HOST />
  <@img.ENV 'CACHE_PORT' PARAMS.CACHE_PORT />
  <@img.ENV 'CACHE_USER' PARAMS.CACHE_USER />
  <@img.ENV 'CACHE_PASS' PARAMS.CACHE_PASS />

  <@img.ENV 'JAVA_OPTS' PARAMS.JAVA_OPTS />
  <@img.ENV 'JMX_PORT' PARAMS.JMX_PORT />
  <@img.ENV 'DEBUGGER_PORT' PARAMS.DEBUGGER_PORT />
  <@img.ENV 'DEBUGGER_SUSPEND_ON_START' PARAMS.DEBUGGER_SUSPEND_ON_START />
  <@img.ENV 'INVENTORY_URL' PARAMS.INVENTORY_URL />

  <#if PARAMS.ES_URL?has_content>
    <@img.ENV 'LOGSTASH_HOST' 'logstash-sc-gw-${namespace}:4560' />
  </#if>

  <@img.CHECK_PORT '8080' />

</@img.TASK>

<#if PARAMS.ES_URL?has_content>
  <@img.TASK 'logstash-sc-gw-${namespace}' 'imagenarium/logstash:7.17.1'>
    <@img.NODE_REF 'sc-gw' />
    <@img.ENV 'ELASTICSEARCH_URL' PARAMS.ES_URL />
    <@img.ENV 'ELASTICSEARCH_USERNAME' PARAMS.ES_USERNAME />
    <@img.ENV 'ELASTICSEARCH_PASSWORD' PARAMS.ES_PASSWORD />
    <@img.ENV 'LS_JAVA_OPTS' PARAMS.LS_JAVA_OPTS />
    <@img.ENV 'NODE_NAME' 'logstash-sc-gw-${namespace}' />
    <@img.ENV 'NUMBER_OF_REPLICAS' '0' />
    <@img.ENV 'INDEX_NAME' 'sc-gw' />
    <@img.ENV 'ROLL_OVER_SIZE_GB' PARAMS.ROLL_OVER_SIZE_GB />
    <@img.ENV 'ROLL_OVER_DAYS' PARAMS.ROLL_OVER_DAYS />
    <@img.ENV 'DELETE_DAYS' PARAMS.DELETE_DAYS />
    <@img.CHECK_PORT '4560' />
  </@img.TASK>
</#if>
