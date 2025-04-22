<@requirement.NODE 'sc-auth' 'sc-auth-${namespace}' 'sc-auth-standby-${namespace}' />

<@requirement.PARAM name='TOKEN_LIFETIME' value='3600'  description='Время жизни токена в секундах' />

<@requirement.PARAM name='LDAP_HOST' value='sc-ds-directory' />
<@requirement.PARAM name='LDAP_PORT' value='389' />
<@requirement.PARAM name='LDAP_USER' value='cn=Directory Manager' />
<@requirement.PARAM name='LDAP_PASSWORD' value='' type='secret' />
<@requirement.PARAM name='LDAP_USE_SSL' value='false' values='true,false' type='select'  />
<@requirement.PARAM name='LDAP_USER_SEARCH_FILTER' value='(&(objectClass=inetOrgPerson)(uid={0}))'  />
<@requirement.PARAM name='LDAP_BASE_DN' value='' required='false' />

<@requirement.PARAM name='CACHE_HOST' value='sc-cache-directory' />
<@requirement.PARAM name='CACHE_PORT' value='11222' />
<@requirement.PARAM name='CACHE_USER' value='' />
<@requirement.PARAM name='CACHE_PASS' value='' type='password' />

<@requirement.PARAM name='PUBLISHED_PORT' type='port' value='' required='false' scope='global' />

<@requirement.PARAM name='JAVA_OPTS' value='' required='false' scope='global' />
<@requirement.PARAM name='JMX_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_PORT' value='' required='false' type='port' />
<@requirement.PARAM name='DEBUGGER_SUSPEND_ON_START' values='n,y' required='false' type='select' />

<@requirement.PARAM name='SPRING_BOOT_ADMIN_CLIENT_ENABLED' value='false' values='true,false' type='select' />
<@requirement.PARAM name='SPRING_BOOT_ADMIN_CLIENT_URL' value='http://localhost:9090' />
<@requirement.PARAM name='LOG_LEVEL_ROOT' values='DEBUG,INFO,WARN,ERROR' value='ERROR' type='select' />
<@requirement.PARAM name='LOG_LEVEL_APPLICATION' values='DEBUG,INFO,WARN,ERROR' value='ERROR' type='select' />

<@requirement.PARAM name='TAG' value='' type='tag'/>

<@requirement.PARAM name='ES_URL' required='false' description='ElasticSearch URL' />
<@requirement.PARAM name='LS_JAVA_OPTS' value='-Xms1g -Xmx1g -Dnetworkaddress.cache.ttl=10' depends='ES_URL' description='Параметры JVM для LogStash' />
<@requirement.PARAM name='ES_USERNAME' required='false' value='elastic' depends='ES_URL' description='Имя пользователя ElasticSearch' />
<@requirement.PARAM name='ES_PASSWORD' required='false' type='password' depends='ES_URL' description='Пароль ElasticSearch' />
<@requirement.PARAM name='ROLL_OVER_SIZE_GB' value='25' depends='ES_URL' description='Запускает rollover, когда индекс достигает определенного размера' />
<@requirement.PARAM name='ROLL_OVER_DAYS' value='1' depends='ES_URL' description='Запускает rollover по истечении максимального времени, прошедшего с момента создания индекса' />
<@requirement.PARAM name='DELETE_DAYS' value='30' depends='ES_URL' description='Очистка данных мониторинга по истечении заданного количества дней' />

<@img.TASK 'sc-auth-${namespace}' 'registry:5000/auth:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-auth' />
  <@img.PORT PARAMS.PUBLISHED_PORT '8081' />
  <@img.PORT PARAMS.JMX_PORT PARAMS.JMX_PORT />
  <@img.PORT PARAMS.DEBUGGER_PORT '8000' />

  <@img.ENV 'TOKEN_LIFETIME' PARAMS.TOKEN_LIFETIME />

  <@img.ENV 'EUREKA_URI' 'http://sc-eureka-${namespace}:8761/eureka' />

  <@img.ENV 'LDAP_HOST' PARAMS.LDAP_HOST />
  <@img.ENV 'LDAP_PORT' PARAMS.LDAP_PORT />
  <@img.ENV 'LDAP_USER' PARAMS.LDAP_USER />
  <@img.ENV 'LDAP_PASSWORD' PARAMS.LDAP_PASSWORD />
  <@img.ENV 'LDAP_USE_SSL' PARAMS.LDAP_USE_SSL />
  <@img.ENV 'LDAP_USER_SEARCH_FILTER' PARAMS.LDAP_USER_SEARCH_FILTER />
  <@img.ENV 'LDAP_BASE_DN' PARAMS.LDAP_BASE_DN />

  <@img.ENV 'CACHE_HOST' PARAMS.CACHE_HOST />
  <@img.ENV 'CACHE_PORT' PARAMS.CACHE_PORT />
  <@img.ENV 'CACHE_USER' PARAMS.CACHE_USER />
  <@img.ENV 'CACHE_PASS' PARAMS.CACHE_PASS />

  <@img.VOLUME '/tmp' />
  <@img.STOP_GRACE_PERIOD '60s' />
  <@img.ENV 'JAVA_OPTS' PARAMS.JAVA_OPTS />
  <@img.ENV 'JMX_PORT' PARAMS.JMX_PORT />
  <@img.ENV 'DEBUGGER_PORT' PARAMS.DEBUGGER_PORT />
  <@img.ENV 'DEBUGGER_SUSPEND_ON_START' PARAMS.DEBUGGER_SUSPEND_ON_START />

  <#if PARAMS.ES_URL?has_content>
    <@img.ENV 'LOGSTASH_HOST' 'logstash-sc-auth-${namespace}:4560' />
  </#if>

  <@img.CHECK_PORT '8081' />

</@img.TASK>

<#if PARAMS.ES_URL?has_content>
  <@img.TASK 'logstash-sc-auth-${namespace}' 'imagenarium/logstash:7.17.1'>
  <@img.NODE_REF 'sc-auth' />
    <@img.ENV 'ELASTICSEARCH_URL' PARAMS.ES_URL />
    <@img.ENV 'ELASTICSEARCH_USERNAME' PARAMS.ES_USERNAME />
    <@img.ENV 'ELASTICSEARCH_PASSWORD' PARAMS.ES_PASSWORD />
    <@img.ENV 'LS_JAVA_OPTS' PARAMS.LS_JAVA_OPTS />
    <@img.ENV 'NODE_NAME' 'logstash-sc-auth-${namespace}' />
    <@img.ENV 'NUMBER_OF_REPLICAS' '0' />
    <@img.ENV 'INDEX_NAME' 'sc-auth' />
    <@img.ENV 'ROLL_OVER_SIZE_GB' PARAMS.ROLL_OVER_SIZE_GB />
    <@img.ENV 'ROLL_OVER_DAYS' PARAMS.ROLL_OVER_DAYS />
    <@img.ENV 'DELETE_DAYS' PARAMS.DELETE_DAYS />
    <@img.CHECK_PORT '4560' />
  </@img.TASK>
</#if>
