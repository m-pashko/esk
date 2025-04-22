<@requirement.NODE 'sc-ds' 'sc-ds-${namespace}' 'sc-ds-standby-${namespace}' />
<@requirement.PARAM name='BASE_DN' required='true' value='dc=example,dc=com' />
<@requirement.PARAM name='ROOT_USER_DN' required='true' value='cn=Directory Manager' />
<@requirement.PARAM name='ROOT_PASSWORD' required='true' type="password" value='' />
<@requirement.PARAM name='REPLICATION_TYPE' values='none,simple,srs,sdsr,rg' value='none' type='select' />
<@requirement.PARAM name='SSL_OPTIONS' required='true' value='--generateSelfSignedCertificate' />
<@requirement.PARAM name='OPENDJ_JAVA_ARGS' required='true' value='-Xmx512m' />
<@requirement.PARAM name='LDAP_PUBLISHED_PORT' required='false' value='389' type='port' />
<@requirement.PARAM name='LDAPS_PUBLISHED_PORT' required='false' value='636' type='port' />
<@requirement.PARAM name='ADMIN_PUBLISHED_PORT' required='false' value='4444' type='port' />
<@requirement.PARAM name='RPL_PUBLISHED_PORT' required='false' value='8989' type='port' />

<@requirement.PARAM name='MASTER_SERVER' required='false' value='' />
<@requirement.PARAM name='MASTER_ADMIN_PORT' required='false' value='4444' />
<@requirement.PARAM name='MASTER_RPL_PORT' required='false' value='8989' />
<@requirement.PARAM name='MYHOSTNAME' required='false' value='' />

<@requirement.PARAM name='VIRTUAL_VOLUME' value='false' type='boolean' /> 
<@requirement.PARAM name='VIRTUAL_VOLUME_SIZE_MB' values='128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576' value='1024' type='select' depends='VIRTUAL_VOLUME' /> 
<@requirement.PARAM name='TAG' value='' type='tag' />


<@img.TASK 'sc-ds-${namespace}' 'registry:5000/ds:${PARAMS.TAG}'> 
  <@img.NODE_REF 'sc-ds' />
  <@img.VOLUME '/opt/opendj/data' PARAMS.VIRTUAL_VOLUME?boolean?then('virtual','local') PARAMS.VIRTUAL_VOLUME_SIZE_MB />
  <@img.PORT PARAMS.LDAP_PUBLISHED_PORT PARAMS.LDAP_PUBLISHED_PORT />
  <@img.PORT PARAMS.LDAPS_PUBLISHED_PORT PARAMS.LDAPS_PUBLISHED_PORT />
  <@img.PORT PARAMS.ADMIN_PUBLISHED_PORT PARAMS.ADMIN_PUBLISHED_PORT />
  <@img.PORT PARAMS.RPL_PUBLISHED_PORT '8989' />
  <@img.ENV 'ROOT_USER_DN' PARAMS.ROOT_USER_DN />
  <@img.ENV 'ROOT_PASSWORD' PARAMS.ROOT_PASSWORD />
  <@img.ENV 'OPENDJ_REPLICATION_TYPE' PARAMS.REPLICATION_TYPE/>

  <@img.ENV 'MASTER_SERVER' PARAMS.MASTER_SERVER />
  <@img.ENV 'MASTER_ADMIN_PORT' PARAMS.MASTER_ADMIN_PORT />
  <@img.ENV 'MASTER_RPL_PORT' PARAMS.MASTER_RPL_PORT />
  <@img.ENV 'MYHOSTNAME' PARAMS.MYHOSTNAME />

  <@img.ENV 'OPENDJ_JAVA_ARGS' PARAMS.OPENDJ_JAVA_ARGS />
  <@img.ENV 'OPENDJ_SSL_OPTIONS' PARAMS.SSL_OPTIONS />
  <@img.ENV 'BASE_DN' PARAMS.BASE_DN />
  <@img.ENV 'PORT' PARAMS.LDAP_PUBLISHED_PORT />
  <@img.ENV 'LDAPS_PORT' PARAMS.LDAPS_PUBLISHED_PORT />
  <@img.ENV 'ADMIN_PORT' PARAMS.ADMIN_PUBLISHED_PORT />
  <@img.ENV 'RPL_PORT' PARAMS.RPL_PUBLISHED_PORT />
  <@img.CHECK_PORT PARAMS.LDAP_PUBLISHED_PORT />
</@img.TASK>
