#!/bin/bash
ECLIPSE_URL="https://mirror.dkm.cz/eclipse/eclipse/downloads/drops4/R-4.30-202312010110/eclipse-platform-4.30-linux-gtk-x86_64.tar.gz"
JAVA_URL="https://cdn.azul.com/zulu/bin/zulu21.30.15-ca-fx-jdk21.0.1-linux_x64.tar.gz"

ECLIPSE_SEM_VER="4.30"
ECLIPSE_DATE_VER="2023-12"

if [ -f "java.tar.gz" ];
then
    rm -f "java.tar.gz"
fi

# Download Java
wget -O "java.tar.gz" "$JAVA_URL"

if [ -d "java_out" ];
then
    rm -rf "java_out"
fi

# Extract Java
mkdir "java_out"
tar -x -f java.tar.gz -C "java_out"

for DIR in `ls java_out`
do
    PATH="$(pwd)/java_out/${DIR}/bin:$PATH"
done

REPOS="https://download.eclipse.org/releases/${ECLIPSE_DATE_VER}/,https://download.eclipse.org/eclipse/updates/${ECLIPSE_SEM_VER},https://download.springsource.com/release/TOOLS/sts4/update/e${ECLIPSE_SEM_VER}/,https://jasperstudio.sourceforge.net/updates/,https://download.eclipse.org/tools/orbit/downloads/drops/R20221123021534/repository,https://download.eclipse.org/staging/2020-12,https://dbeaver.io/update/ce/latest/,https://eclipse-uc.sonarlint.org,https://de-jcup.github.io/update-site-eclipse-bash-editor/update-site"

PACKAGES="org.eclipse.jgit.feature.group,org.eclipse.jgit.gpg.bc.feature.group,org.eclipse.jgit.http.apache.feature.group,org.eclipse.jgit.lfs.feature.group,org.eclipse.jgit.ssh.apache.feature.group,org.eclipse.jgit.ssh.jsch.feature.group,org.eclipse.buildship.feature.group,org.eclipse.jdt.feature.group,org.eclipse.jst.enterprise_ui.feature.feature.group,org.eclipse.jst.web_ui.feature.feature.group,org.eclipse.jst.web_js_support.feature.feature.group,org.eclipse.jdt.source.feature.group,org.eclipse.wst.web_ui.feature.feature.group,org.eclipse.wst.web_js_support.feature.feature.group,org.eclipse.wst.xml_ui.feature.feature.group,org.eclipse.wst.xsl.feature.feature.group,org.eclipse.wst.jsdt.feature.feature.group,org.eclipse.wst.jsdt.chromium.debug.feature.feature.group,org.eclipse.wildwebdeveloper.feature.feature.group,org.eclipse.egit.feature.group,org.eclipse.egit.gitflow.feature.feature.group,org.eclipse.m2e.sdk.feature.feature.group,org.eclipse.m2e.feature.feature.group,org.eclipse.m2e.pde.feature.feature.group,org.eclipse.m2e.logback.feature.feature.group,org.eclipse.epp.mpc.feature.group,org.springframework.tooling.boot.ls.feature.feature.group,org.springframework.ide.eclipse.boot.dash.feature.feature.group,org.springframework.boot.ide.main.feature.feature.group,com.jaspersoft.studio.feature.feature.group,org.jkiss.dbeaver.debug.feature.feature.group,org.jkiss.dbeaver.git.feature.feature.group,org.jkiss.dbeaver.ide.feature.feature.group,org.jkiss.dbeaver.ext.office.feature.feature.group,org.jkiss.dbeaver.ext.ui.svg.feature.feature.group,org.sonarlint.eclipse.feature.feature.group,de.jcup.basheditor.feature.group"


if [ -f "eclipse.tar.gz" ];
then
    rm -f "eclipse.tar.gz"
fi

if [ -d "eclipse_out" ];
then
    rm -rf "eclipse_out"
fi

wget -O "eclipse.tar.gz" "$ECLIPSE_URL"

# Extract Java
mkdir "eclipse_out"
tar -x -f eclipse.tar.gz -C "eclipse_out"

sed -i -e 's/Xms40/Xms1024/g' -e 's/Xmx512/Xmx4096/g' "eclipse_out/eclipse/eclipse.ini"
./eclipse_out/eclipse/eclipse -application "org.eclipse.equinox.p2.director" -repository "$REPOS" -installIU "$PACKAGES"