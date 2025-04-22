<@requirement.NODE 'sc-dataload' 'sc-dataload-${namespace}' 'sc-dataload-standby-${namespace}' />

<@requirement.PARAM name='USER_QUANTITY' value='100000' description='Количество генерируемых записей' />
<@requirement.PARAM name='BASE_DN' value='cn=Users,dc=example,dc=com' description='Целевой контейнер для генерируемых учетных записей пользователей' />
<@requirement.PARAM name='LDAP_URL' value='ldap://<ldap-server>:389' description='Адрес LDAP сервера целевого каталога' />
<@requirement.PARAM name='BIND_DN' value='cn=Directory Manager' description='DN пользователя для создания тестовых записей' />
<@requirement.PARAM name='BIND_PW' type='password' description='Пароль пользователя для создания тестовых записей' />
<@requirement.PARAM name='TLS_BEFORE_BIND' values='1,0' value='1' type='select' description='Включить шифрование TLS' />
<@requirement.PARAM name='TARGET_DIRECTORY_TYPE' values='DC,DS' value='DS' type='select' description='Тип каталога - DC-Domain Controller, DS-Directory Server' />
<@requirement.PARAM name='TAG' value='' type='tag' />

<@img.TASK 'sc-dataload-${namespace}' 'registry:5000/sc-dataload:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-dataload' />
  <@img.ENV 'USER_QUANTITY'   PARAMS.USER_QUANTITY />
  <@img.ENV 'BASE_DN' PARAMS.BASE_DN />
  <@img.ENV 'LDAP_URL'  PARAMS.LDAP_URL />
  <@img.ENV 'BIND_DN'  PARAMS.BIND_DN />
  <@img.ENV 'BIND_PW' PARAMS.BIND_PW />
  <@img.ENV 'TLS_BEFORE_BIND' PARAMS.TLS_BEFORE_BIND />
  <@img.ENV 'TARGET_DIRECTORY' PARAMS.TARGET_DIRECTORY_TYPE />
</@img.TASK> 
