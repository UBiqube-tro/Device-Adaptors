#!/bin/sh
set -x
DEBUG=$1
NOW=$(date +"%Y%m%d%H%M")

grep "^18082900," /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties > /dev/null
if [ $? -ne 0 ]; then
  echo "  Modifying /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties"
  /bin/cp -p /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties.checkpoint.r80.$NOW

  ## ファイル末尾に改行がない場合の対処
  /bin/cat /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties | awk '{print}' > /tmp/msa.$$
  /bin/cp -p /tmp/msa.$$ /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties
  /bin/rm -f /tmp/msa.$$

  echo '18082900,"Check Point",1' >> /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties
fi

grep "^18082900," /opt/ubi-jentreprise/resources/templates/conf/device/models.properties > /dev/null
if [ $? -ne 0 ]; then
  echo "  Modifying /opt/ubi-jentreprise/resources/templates/conf/device/models.properties"
  /bin/cp -p /opt/ubi-jentreprise/resources/templates/conf/device/models.properties /opt/ubi-jentreprise/resources/templates/conf/device/models.properties.checkpoint.r80.$NOW

  ## ファイル末尾に改行がない場合の対処
  /bin/cat /opt/ubi-jentreprise/resources/templates/conf/device/models.properties | awk '{print}' > /tmp/msa.$$
  /bin/cp /tmp/msa.$$ /opt/ubi-jentreprise/resources/templates/conf/device/models.properties
  /bin/rm -f /tmp/msa.$$

  echo '18082900,18082900,"R80","H",0,0,0,0,0,1,0,0,0,0,0,SR,0,0' >> /opt/ubi-jentreprise/resources/templates/conf/device/models.properties
fi

if [ ! -f "/opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties" ]; then
  echo "  Copying /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties"
  /bin/cp -p /opt/ses/templates/server_ALL/sdExtendedInfo.properties /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties
fi

grep "checkpoint_r80" /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties > /dev/null
if [ $? -ne 0 ]; then
  echo "  Modifying /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties"
  /bin/cp -p /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties.checkpoint.r80.$NOW

  ## ファイル末尾に改行がない場合の対処
  /bin/cat /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties | awk '{print}' > /tmp/msa.$$
  /bin/cp /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties
  /bin/rm -f /tmp/msa.$$

  echo 'sdExtendedInfo.router.18082900-18082900 = checkpoint_r80' >> /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties
  echo 'sdExtendedInfo.jspType.18082900-18082900 = checkpoint_r80' >> /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties
fi

if [ ! -f "/opt/ses/properties/specifics/server_ALL/manageLinks.properties" ]; then
  echo "  Copying /opt/ses/properties/specifics/server_ALL/manageLinks.properties"
  /bin/cp -p /opt/ses/templates/server_ALL/manageLinks.properties /opt/ses/properties/specifics/server_ALL/manageLinks.properties
fi

grep "checkpoint_r80" /opt/ses/properties/specifics/server_ALL/manageLinks.properties > /dev/null
if [ $? -ne 0 ]; then
  echo "  Modifying /opt/ses/properties/specifics/server_ALL/manageLinks.properties"
  /bin/cp -p /opt/ses/properties/specifics/server_ALL/manageLinks.properties /opt/ses/properties/specifics/server_ALL/manageLinks.properties.checkpoint.r80.$NOW

  /bin/cat /opt/ses/properties/specifics/server_ALL/manageLinks.properties \
    | sed 's/^\(siteLink.initialProv.models.*\)/\1 checkpoint_r80/' \
    | sed 's/^\(siteLink.detailedReports.models.*\)/\1 checkpoint_r80/' \
    | sed 's/^\(siteLink.displayLogs.models.*\)/\1 checkpoint_r80/' \
    | sed 's/^\(device.cisco.license.manager.models.*\)/\1 checkpoint_r80/' \
    | sed 's/^\(device.wizard.managecertificate.models.*\)/\1 checkpoint_r80/' \
    | sed 's/^\(device.wizard.specific.rules.and.commands.models.*\)/\1 checkpoint_r80/' \
    | sed 's/^\(device.wizard.check.non.empty.credentials.models.*\)/\1 checkpoint_r80/' \
    | sed 's/^\(configobjectconsole.supported.models.*\)/\1 checkpoint_r80/' \
    > /tmp/msa.$$
  /bin/cp -p /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/manageLinks.properties
  /bin/rm -f /tmp/msa.$$
fi

if [ ! -f "/opt/ses/properties/specifics/server_ALL/ses.properties" ]; then
  echo "  Copying /opt/ses/properties/specifics/server_ALL/ses.properties"
  /bin/cp -p /opt/ses/templates/server_ALL/ses.properties /opt/ses/properties/specifics/server_ALL/ses.properties
fi

grep "^soc.device.supported.checkpoint" /opt/ses/properties/specifics/server_ALL/ses.properties > /dev/null
if [ $? -ne 0 ]; then
  echo "  Modifying /opt/ses/properties/specifics/server_ALL/ses.properties"
  /bin/cp -p /opt/ses/properties/specifics/server_ALL/ses.properties /opt/ses/properties/specifics/server_ALL/ses.properties.checkpoint.r80.$NOW
  echo 'soc.device.supported.checkpoint=1' >> /opt/ses/properties/specifics/server_ALL/ses.properties
fi

if [ ! -f "/opt/ses/properties/specifics/server_ALL/repository.properties" ]; then
  echo "  Copying /opt/ses/properties/specifics/server_ALL/repository.properties"
  /bin/cp -p /opt/ses/templates/server_ALL/repository.properties /opt/ses/properties/specifics/server_ALL/repository.properties
fi

CP_DONE=0
grep "^repository.manufacturer.* CheckPoint.*" /opt/ses/properties/specifics/server_ALL/repository.properties > /dev/null
if [ $? -ne 0 ]; then
  echo "  Modifying(1) /opt/ses/properties/specifics/server_ALL/repository.properties"
  /bin/cp -p /opt/ses/properties/specifics/server_ALL/repository.properties /opt/ses/properties/specifics/server_ALL/repository.properties.checkpoint.r80.$NOW
  CP_DONE=1
  /bin/cat /opt/ses/properties/specifics/server_ALL/repository.properties \
    | sed 's/^\(repository.manufacturer.*\)/\1 CheckPoint/' \
    > /tmp/msa.$$
  /bin/cp -p /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/repository.properties
  /bin/rm -f /tmp/msa.$$
fi

grep "^repository.access.checkpoint=" /opt/ses/properties/specifics/server_ALL/repository.properties > /dev/null
if [ $? -ne 0 ]; then
  echo "  Modifying(2) /opt/ses/properties/specifics/server_ALL/repository.properties"
  if [ $CP_DONE -eq 0 ]; then
    /bin/cp -p /opt/ses/properties/specifics/server_ALL/repository.properties /opt/ses/properties/specifics/server_ALL/repository.properties.checkpoint.r80.$NOW
    CP_DONE=1
  fi
  echo 'repository.model.checkpoint=18082900-18082900' >> /opt/ses/properties/specifics/server_ALL/repository.properties
  echo 'repository.access.checkpoint=|Configuration|Firmware|CommandDefinition|Datafiles|Reports|License|Orchestration|Process|' >> /opt/ses/properties/specifics/server_ALL/repository.properties
fi

## for debug
if [ "$DEBUG" == "debug" ]; then
  echo
  diff -u /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties.checkpoint.r80.$NOW /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties
  diff -u /opt/ubi-jentreprise/resources/templates/conf/device/models.properties.checkpoint.r80.$NOW /opt/ubi-jentreprise/resources/templates/conf/device/models.properties
  diff -u /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties.checkpoint.r80.$NOW /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties
  diff -u /opt/ses/properties/specifics/server_ALL/manageLinks.properties.checkpoint.r80.$NOW /opt/ses/properties/specifics/server_ALL/manageLinks.properties
  diff -u /opt/ses/properties/specifics/server_ALL/ses.properties.checkpoint.r80.$NOW /opt/ses/properties/specifics/server_ALL/ses.properties
  diff -u /opt/ses/properties/specifics/server_ALL/repository.properties.checkpoint.r80.$NOW /opt/ses/properties/specifics/server_ALL/repository.properties
fi

exit 0

## End of File
