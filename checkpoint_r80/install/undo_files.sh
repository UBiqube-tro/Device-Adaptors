#!/bin/sh

UNDO_ALL=$1

## 他のNECデバイスアダプタが存在する場合を考慮し、削除しない
if [ "$UNDO_ALL" == "all" ]; then
  grep "^18082900," /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties > /dev/null
  if [ $? -eq 0 ]; then
    echo "  Modifying(undo) /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties"
    grep -v "^70000," /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties > /tmp/msa.$$
    /bin/cp /tmp/msa.$$ /opt/ubi-jentreprise/resources/templates/conf/device/manufacturers.properties
    /bin/rm -f /tmp/msa.$$
  fi
fi

grep "^18082900," /opt/ubi-jentreprise/resources/templates/conf/device/models.properties > /dev/null
if [ $? -eq 0 ]; then
  echo "  Modifying(undo) /opt/ubi-jentreprise/resources/templates/conf/device/models.properties"
  grep -v "^18082900," /opt/ubi-jentreprise/resources/templates/conf/device/models.properties > /tmp/msa.$$
  /bin/cp /tmp/msa.$$ /opt/ubi-jentreprise/resources/templates/conf/device/models.properties
  /bin/rm -f /tmp/msa.$$
fi

grep "checkpoint_r80" /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties > /dev/null
if [ $? -eq 0 ]; then
  echo "  Modifying(undo) /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties"
  grep -v "checkpoint_r80" /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties > /tmp/msa.$$
  /bin/cp /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/sdExtendedInfo.properties
  /bin/rm -f /tmp/msa.$$
fi

grep "checkpoint_r80" /opt/ses/properties/specifics/server_ALL/manageLinks.properties > /dev/null
if [ $? -eq 0 ]; then
  echo "  Modifying(undo) /opt/ses/properties/specifics/server_ALL/manageLinks.properties"
  sed 's/ checkpoint_r80//' /opt/ses/properties/specifics/server_ALL/manageLinks.properties > /tmp/msa.$$
  /bin/cp /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/manageLinks.properties
  /bin/rm -f /tmp/msa.$$
fi

## 他のNECデバイスアダプタが存在する場合を考慮し、削除しない
if [ "$UNDO_ALL" == "all" ]; then
  grep "^soc.device.supported.checkpoint" /opt/ses/properties/specifics/server_ALL/ses.properties > /dev/null
  if [ $? -eq 0 ]; then
    echo "  Modifying(undo) /opt/ses/properties/specifics/server_ALL/ses.properties"
    grep -v "^soc.device.supported.checkpoint" /opt/ses/properties/specifics/server_ALL/ses.properties > /tmp/msa.$$
    /bin/cp /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/ses.properties
    /bin/rm -f /tmp/msa.$$
  fi
fi

## 他のNECデバイスアダプタが存在する場合を考慮し、削除しない
if [ "$UNDO_ALL" == "all" ]; then
  grep "^repository.manufacturer.* CheckPoint.*" /opt/ses/properties/specifics/server_ALL/repository.properties > /dev/null
  if [ $? -eq 0 ]; then
    echo "  Modifying(undo1) /opt/ses/properties/specifics/server_ALL/repository.properties"
    sed 's/ CheckPoint//' /opt/ses/properties/specifics/server_ALL/repository.properties > /tmp/msa.$$
    /bin/cp /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/repository.properties
    /bin/rm -f /tmp/msa.$$
  fi
fi

if [ "$UNDO_ALL" == "all" ]; then
  grep "^repository.access.checkpoint=" /opt/ses/properties/specifics/server_ALL/repository.properties > /dev/null
  if [ $? -eq 0 ]; then
    echo "  Modifying(undo2) /opt/ses/properties/specifics/server_ALL/repository.properties"
    grep -v "^repository.model.checkpoint=" /opt/ses/properties/specifics/server_ALL/repository.properties \
      | grep -v "^repository.access.checkpoint=" > /tmp/msa.$$
    /bin/cp /tmp/msa.$$ /opt/ses/properties/specifics/server_ALL/repository.properties
    /bin/rm -f /tmp/msa.$$
  fi
fi

exit 0

## End of File
