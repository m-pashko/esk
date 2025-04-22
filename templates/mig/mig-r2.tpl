<@requirement.NODE 'sc-dc' 'sc-dc-${namespace}' 'sc-dc-standby-${namespace}' />

<@requirement.PARAM name='AD_SERVER_HOST' value='dc1.somedom.example.com' description='LDAP сервер исходного Active Directory (AD)' />
<@requirement.PARAM name='AD_SERVER_PORT' value='389' description='Номер порта LDAP сервера AD' />
<@requirement.PARAM name='AD_SERVER_SSL' values='True,False' value='False' type='select' description='Включить шифрование SSL' />
<@requirement.PARAM name='AD_SERVER_TLS' values='1,0' value='0' type='select' description='Включить шифрование TLS' />
<@requirement.PARAM name='AD_SERVER_USER' value='user1@somedom.example.com' description='Имя пользователя LDAP сервера AD' />
<@requirement.PARAM name='AD_SERVER_PASS' value='' type='password' description='Пароль пользователя LDAP сервера AD' />
<@requirement.PARAM name='AD_USER_CONTAINER' value='cn=Users,ou=MSK,dc=somedom,dc=example,dc=com' description='Исходный контейнер учетных записей пользователей для миграции' />
<@requirement.PARAM name='AD_USER_ATTRIBUTES' value='cn,displayName,givenName,initials,sn,userPrincipalName,sAMAccountName,objectSid' description='Атрибуты для миграции' />
<@requirement.PARAM name='AD_GROUP_CONTAINER' value='cn=Groups,ou=MSK,dc=somedom,dc=example,dc=com' description='Исходный контейнер учетных записей групп для миграции' />
<@requirement.PARAM name='SELENGA_SERVER_HOST'  value='ldap.sc-directory.ru' description='LDAP сервер целевого каталога SmartControl' />
<@requirement.PARAM name='SELENGA_SERVER_PORT' value='389' description='Номер порта LDAP сервера SmartControl' />
<@requirement.PARAM name='SELENGA_SERVER_SSL' values='True,False' value='False' type='select' description='Включить шифрование SSL' />
<@requirement.PARAM name='SELENGA_SERVER_TLS' values='1,0' value='1' type='select' description='Включить шифрование TLS' />
<@requirement.PARAM name='SELENGA_SERVER_USER' value='uid=admin,ou=system' description='Имя пользователя LDAP сервера SmartControl' />
<@requirement.PARAM name='SELENGA_SERVER_PASS' value='' type='password' description='Пароль пользователя LDAP сервера SmartControl' />
<@requirement.PARAM name='SELENGA_USER_CONTAINER' value='cn=Users,ou=HQ,dc=somedom,dc=sc-directory,dc=ru' description='Целевой контейнер учетных записей пользователей для миграции' />
<@requirement.PARAM name='SELENGA_GROUP_CONTAINER' value='cn=Groups,ou=HQ,dc=somedom,dc=sc-directory,dc=ru' description='Целевой контейнер учетных записей групп для миграции' />
<@requirement.PARAM name='TAG' value='' type='tag'/>
<@requirement.PARAM name='VOLNAME' value='vol2-selenga-domain' scope='global' />
<@requirement.PARAM name='DEFAULT_PASSWORD' value='smeniParol123'  description='Пароль по умолчанию' />
<@requirement.PARAM name='MIGRATION_MODE' values='skip,replace,merge' value='skip' type='select' description='Алгоритм обработки существующих записей' />
<@requirement.PARAM name='DISABLE_ORIGINAL_ACCOUNTS' values='True,False' value='True' type='select' description='Блокировать учетные записи в исходном домене' />
<@requirement.PARAM name='PROCESSING_MODE' values='single,continuous' value='single' type='select' description='Алгоритм обработки существующих записей' />
<@requirement.PARAM name='MAX_ACCOUNTS' value='1000'  description='Максимальное количество записей для миграции' />
<@requirement.PARAM name='MUST_CHANGE_PASSWORD' values='true,false' value='false' type='select' description='Требовать смены пароля при первом входе' />
<@requirement.PARAM name='UPDATE_INTERVAL' value='3600'  description='Интервал между инкрементальной миграцией (секунды)' />

<@img.TASK 'sc-migrator-${namespace}' 'registry:5000/mig:${PARAMS.TAG}'>
  <@img.NODE_REF 'sc-dc' />
  <@img.SHARED_VOLUME '/var/lib/samba' '${PARAMS.VOLNAME}' 'local' />
  <@img.ENV 'AD_SERVER_HOST'   PARAMS.AD_SERVER_HOST />
  <@img.ENV 'AD_SERVER_PORT' PARAMS.AD_SERVER_PORT />
  <@img.ENV 'AD_SERVER_SSL'  PARAMS.AD_SERVER_SSL />
  <@img.ENV 'AD_SERVER_TLS'  PARAMS.AD_SERVER_TLS />
  <@img.ENV 'AD_SERVER_USER' PARAMS.AD_SERVER_USER />
  <@img.ENV 'AD_SERVER_PASS' PARAMS.AD_SERVER_PASS />
  <@img.ENV 'AD_USER_CONTAINER' PARAMS.AD_USER_CONTAINER />
  <@img.ENV 'AD_USER_ATTRIBUTES' PARAMS.AD_USER_ATTRIBUTES />
  <@img.ENV 'AD_GROUP_CONTAINER' PARAMS.AD_GROUP_CONTAINER />
  <@img.ENV 'SELENGA_SERVER_HOST'  PARAMS.SELENGA_SERVER_HOST />
  <@img.ENV 'SELENGA_SERVER_PORT'  PARAMS.SELENGA_SERVER_PORT />
  <@img.ENV 'SELENGA_SERVER_SSL'   PARAMS.SELENGA_SERVER_SSL  />
  <@img.ENV 'SELENGA_SERVER_TLS'   PARAMS.SELENGA_SERVER_TLS  />
  <@img.ENV 'SELENGA_SERVER_USER'  PARAMS.SELENGA_SERVER_USER />
  <@img.ENV 'SELENGA_SERVER_PASS'  PARAMS.SELENGA_SERVER_PASS />
  <@img.ENV 'SELENGA_USER_CONTAINER' PARAMS.SELENGA_USER_CONTAINER />
  <@img.ENV 'SELENGA_GROUP_CONTAINER' PARAMS.SELENGA_GROUP_CONTAINER />
  <@img.ENV 'DEFAULT_PASSWORD' PARAMS.DEFAULT_PASSWORD />
  <@img.ENV 'MIGRATION_MODE' PARAMS.MIGRATION_MODE />
  <@img.ENV 'DISABLE_ORIGINAL_ACCOUNTS' PARAMS.DISABLE_ORIGINAL_ACCOUNTS />
  <@img.ENV 'PROCESSING_MODE' PARAMS.PROCESSING_MODE />
  <@img.ENV 'MAX_ACCOUNTS' PARAMS.MAX_ACCOUNTS />
  <@img.ENV 'MUST_CHANGE_PASSWORD' PARAMS.MUST_CHANGE_PASSWORD />
  <@img.ENV 'UPDATE_INTERVAL' PARAMS.UPDATE_INTERVAL />
</@img.TASK> 
