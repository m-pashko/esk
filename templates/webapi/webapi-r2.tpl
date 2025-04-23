<@requirement.NODE 'sc-webapi' 'sc-webapi-${namespace}' 'sc-webapi-standby-${namespace}' />

<@requirement.PARAM name='TOKEN_LIFETIME' value='3600'  description='Время жизни токена в секундах' />
<@requirement.PARAM name='CACHE_EXPIRE_TIME' value='3000'  description='Время жизни записи в кэше в секундах' />
<@requirement.PARAM name='CACHE_MAXIMUM_SIZE' value='10000'  description='Максимальное количество записей в кэше' />

<@requirement.PARAM name='LDAP_HOST' value='sc-ds-directory' />
<@requirement.PARAM name='LDAP_PORT' value='389' />
<@requirement.PARAM name='LDAP_USE_SSL' value='false' values='true,false' type='select'  />

<@requirement.PARAM name='RESTART_HOST' value='sc-directory-server' />
<@requirement.PARAM name='RESTART_PORT' value='55555' />

<@requirement.PARAM name='PUBLISHED_PORT' type='port' value='' required='false' scope='global' />

<@requirement.PARAM name='JAVA_OPTS' value='' required='false' scope='global' />
<@requirement.PARAM name='JMX_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_SUSPEND_ON_START' values='n,y' required='false' type='select' />

<@requirement.PARAM name='SPRING_BOOT_ADMIN_CLIENT_ENABLED' value='false' values='true,false' type='select' />
<@requirement.PARAM name='SPRING_BOOT_ADMIN_CLIENT_URL' value='http://localhost:9090' />
<@requirement.PARAM name='LOG_LEVEL_ROOT' values='DEBUG,INFO,WARN,ERROR' value='ERROR' type='select' />
<@requirement.PARAM name='LOG_LEVEL_APPLICATION' values='DEBUG,INFO,WARN,ERROR' value='ERROR' type='select' />
<@requirement.PARAM name='LOG_LEVEL_DEFAULT_SCHEMA_MANAGER' values='DEBUG,INFO,WARN,ERROR' value='ERROR' type='select' />

<@requirement.PARAM name='TAG' value='' type='tag' />

<@requirement.PARAM name='ES_URL' required='false' description='ElasticSearch URL' />
<@requirement.PARAM name='LS_JAVA_OPTS' value='-Xms1g -Xmx1g -Dnetworkaddress.cache.ttl=10' depends='ES_URL' description='Параметры JVM для LogStash' />
<@requirement.PARAM name='ES_USERNAME' required='false' value='elastic' depends='ES_URL' description='Имя пользователя ElasticSearch' />
<@requirement.PARAM name='ES_PASSWORD' required='false' type='password' depends='ES_URL' description='Пароль ElasticSearch' />
<@requirement.PARAM name='ROLL_OVER_SIZE_GB' value='25' depends='ES_URL' description='Запускает rollover, когда индекс достигает определенного размера' />
<@requirement.PARAM name='ROLL_OVER_DAYS' value='1' depends='ES_URL' description='Запускает rollover по истечении максимального времени, прошедшего с момента создания индекса' />
<@requirement.PARAM name='DELETE_DAYS' value='30' depends='ES_URL' description='Очистка данных мониторинга по истечении заданного количества дней' />

<@requirement.PARAM name='MQ_ADDRESSES' value='' required='false' description='MQ сервера, разделенные запятой' />
<@requirement.PARAM name='MQ_SERVER' value='' description='URL MQ сервера' />
<@requirement.PARAM name='MQ_PORT' value='5672' description='Порт MQ сервера' />
<@requirement.PARAM name='MQ_USER' value='' description='Имя пользователя MQ сервера' />
<@requirement.PARAM name='MQ_PASS' value='' type='password' description='Пароль пользователя MQ сервера' />

<@requirement.PARAM name='IMAGENARIUM_API_URI' value='http://clustercontrol:5555/api/v4/components' description='URI API консоли управления' />
<@requirement.PARAM name='IMAGENARIUM_API_USER' value='' description='Имя пользователя для подключения к API консоли управления' />
<@requirement.PARAM name='IMAGENARIUM_API_PASSWORD' value='' type='password' description='Пароль пользователя для подключения к API консоли управления' />

<@requirement.PARAM name='LDAP_ADMIN_USERNAME' value='cn=Directory Manager' description='Имя администратора' />
<@requirement.PARAM name='LDAP_ADMIN_PASSWORD' value='' type='password' description='Пароль администратора' />

<@img.TASK 'sc-webapi-${namespace}' '172.25.6.89:8123/web:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-webapi' />
  <@img.PORT PARAMS.PUBLISHED_PORT '8082' />
  <@img.PORT PARAMS.JMX_PORT PARAMS.JMX_PORT />
  <@img.PORT PARAMS.DEBUGGER_PORT '8000' />

  <@img.ENV 'TOKEN_LIFETIME' PARAMS.TOKEN_LIFETIME />

  <@img.ENV 'EUREKA_URI' 'http://sc-eureka-${namespace}:8761/eureka' />

  <@img.ENV 'LDAP_HOST' PARAMS.LDAP_HOST />
  <@img.ENV 'LDAP_PORT' PARAMS.LDAP_PORT />
  <@img.ENV 'LDAP_USE_SSL' PARAMS.LDAP_USE_SSL />
  <@img.ENV 'RESTART_HOST' PARAMS.RESTART_HOST />
  <@img.ENV 'RESTART_PORT' PARAMS.RESTART_PORT />

  <@img.ENV 'MQ_ADDRESSES' PARAMS.MQ_ADDRESSES />
  <@img.ENV 'MQ_SERVER' PARAMS.MQ_SERVER />
  <@img.ENV 'MQ_PORT' PARAMS.MQ_PORT />
  <@img.ENV 'MQ_USER' PARAMS.MQ_USER />
  <@img.ENV 'MQ_PASS' PARAMS.MQ_PASS />

  <@img.ENV 'IMAGENARIUM_API_URI' PARAMS.IMAGENARIUM_API_URI />
  <@img.ENV 'IMAGENARIUM_API_USER' PARAMS.IMAGENARIUM_API_USER />
  <@img.ENV 'IMAGENARIUM_API_PASSWORD' PARAMS.IMAGENARIUM_API_PASSWORD />

  <@img.VOLUME '/tmp' />
  <@img.STOP_GRACE_PERIOD '60s' />
  <@img.ENV 'JAVA_OPTS' PARAMS.JAVA_OPTS />
  <@img.ENV 'JMX_PORT' PARAMS.JMX_PORT />
  <@img.ENV 'DEBUGGER_PORT' PARAMS.DEBUGGER_PORT />
  <@img.ENV 'DEBUGGER_SUSPEND_ON_START' PARAMS.DEBUGGER_SUSPEND_ON_START />

  <@img.ENV 'LDAP_ADMIN_USERNAME' PARAMS.LDAP_ADMIN_USERNAME />
  <@img.ENV 'LDAP_ADMIN_PASSWORD' PARAMS.LDAP_ADMIN_PASSWORD />

  <#if PARAMS.ES_URL?has_content>
    <@img.ENV 'LOGSTASH_HOST' 'logstash-sc-webapi-${namespace}:4560' />
  </#if>

  <@img.CHECK_PORT '8082' />

</@img.TASK>

<#if PARAMS.ES_URL?has_content>
  <@img.TASK 'logstash-sc-webapi-${namespace}' 'imagenarium/logstash:7.17.1'>
  <@img.NODE_REF 'sc-webapi' />
    <@img.ENV 'ELASTICSEARCH_URL' PARAMS.ES_URL />
    <@img.ENV 'ELASTICSEARCH_USERNAME' PARAMS.ES_USERNAME />
    <@img.ENV 'ELASTICSEARCH_PASSWORD' PARAMS.ES_PASSWORD />
    <@img.ENV 'LS_JAVA_OPTS' PARAMS.LS_JAVA_OPTS />
    <@img.ENV 'NODE_NAME' 'logstash-sc-webapi-${namespace}' />
    <@img.ENV 'NUMBER_OF_REPLICAS' '0' />
    <@img.ENV 'INDEX_NAME' 'sc-webapi' />
    <@img.ENV 'ROLL_OVER_SIZE_GB' PARAMS.ROLL_OVER_SIZE_GB />
    <@img.ENV 'ROLL_OVER_DAYS' PARAMS.ROLL_OVER_DAYS />
    <@img.ENV 'DELETE_DAYS' PARAMS.DELETE_DAYS />
    <@img.CHECK_PORT '4560' />
  </@img.TASK>
</#if>
