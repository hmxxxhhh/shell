#!/bin/bash
buildDay=$(date +%Y%m%d)

buildTime=$(date +%H%M)

################配置信息###############

scheme="sse"

buildConfiguration="sse"

profile="SSE GW Inhouse"


################路径信息###################
buildPath="./${scheme}.xcarchive"

ipaPath="../ipa"

if [ ! -d "${ipaPath}" ]
then
mkdir -p "${ipaPath}"
fi

if [ ! -d "${ipaPath}/${buildDay}" ]
then
mkdir -p "${ipaPath}/${buildDay}"
fi

ipaName="${ipaPath}/${buildDay}/${scheme}${buildTime}.ipa"



#
#scp "${ipaPath}/${buildDay}sse1406.ipa" "mitake:m1t@ke@10.10.10.100:/项目小组/移动互联网研发创新团队/APP上交所/历史版本"
#
#
if [ -e "./${buildConfiguration}.xcworkspace" ]
then
xctool -workspace "${buildConfiguration}.xcworkspace" -scheme ${scheme} -configuration ${buildConfiguration} clean

xctool -workspace "${buildConfiguration}.xcworkspace" -scheme ${scheme} -configuration ${buildConfiguration} archive -archivePath ${buildPath}
else
echo "bu"
xctool -scheme ${scheme} -configuration ${buildConfiguration} clean

xctool -scheme ${scheme} -configuration ${buildConfiguration} archive -archivePath ${buildPath}

fi

xcodebuild -exportArchive -exportFormat IPA -archivePath ${buildPath} -exportPath ${ipaName} -exportProvisioningProfile "$profile"

cp -R "${buildPath}" "${ipaPath}/${buildDay}/${scheme}${buildTime}.xcarchive"
rm -r "${buildPath}"
open "${ipaPath}"
open  "smb://mitake@10.10.10.100:/项目小组/移动互联网研发创新团队/APP上交所/历史版本"