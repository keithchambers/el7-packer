#!/bin/bash -x

# delete locales
localedef --list-archive | grep -a -v "en_US" | xargs localedef --delete-from-archive
cp /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive

mv /usr/share/locale/en /usr/share/locale/en_US /usr/share/locale/locale.alias /tmp
find /usr/share/locale -type f -delete
mv /tmp/en /tmp/en_US /tmp/locale.alias /usr/share/locale

mv /usr/share/i18n/locales/en_US /tmp
find /usr/share/i18n/locales -type f -delete
mv /tmp/en_US /usr/share/i18n/locales

# delete non-utf character sets
find /usr/lib64/gconv/ -type f ! -name "UTF*" -delete

# delete docs
find /usr/share/{man,doc,info,gnome} -type f -delete

# delete cracklib
find /usr/share/cracklib -type f -delete

# delete timezones
find /usr/share/zoneinfo -type f \( ! -name "Etc" ! -name "UTC" \) -delete

# delete kernel modules
KMODS=$(lsmod | awk 'NR>1 {print $1}')
find /lib/modules -type f -name '*.ko' | while read F
do
    echo "${KMODS}" | egrep -q "^$(basename ${F%%.ko})$" || rm -f "${F}"
done

# EOF
