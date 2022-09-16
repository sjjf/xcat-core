#!/usr/bin/bash

# called by dracut
check() {
    # do not add this module by default
    return 255
}

# called by dracut
depends() {
    echo \
        network-legacy network kernel-modules kernel-network-modules \
        kernel-modules-extra terminfo syslog nfs chrony base
    return 0
}

#called by dracut
installkernel() {
    local _kver
    _kver=$(uname -r)
    if [ -e "/lib/modules/$_kver/modules.dep" ]; then
        while read -r line; do
            kmod=$(basename "$line")
            instmods "$kmod"
        done < <(awk -F: '{print $1}' < "/lib/modules/$_kver/modules.dep")
    fi
}

# called by dracut
install() {
    inst_multiple \
        wget openssl tar ipmitool cpio gzip lsmod ethtool modprobe touch \
        echo cut wc bash netstat sort uniq grep ip hostname /usr/bin/awk \
        egrep grep dirname expr mount.nfs sshd ssh-keygen scp \
        vi /usr/libexec/vi reboot parted screen mkfs mkfs.ext4 \
        mkfs.xfs xfs_db mkswap df vconfig ifenslave clear dhclient \
        lldpad lldptool poweroff hwclock date umount rpm chmod /sbin/route \
        /sbin/ifconfig /usr/bin/whoami /usr/bin/head /usr/bin/tail basename \
        ping tr logger sysctl find efibootmgr dmidecode pidof reset

    # lspci and lsusb have some necessary data files
    inst_multiple \
        lspci lsusb \
        /usr/share/hwdata/usb.ids \
        /usr/share/hwdata/pci.ids

    # mstflint and mstconfig have some necessary data files
    inst_multiple \
        mstflint mstconfig \
        /usr/share/mstflint/mlxconfig_dbs/mlxconfig_host.db \
        /usr/share/mstflint/mlxconfig_dbs/mlxconfig_switch.db

    inst "/usr/share/zoneinfo/posix/Zulu"
    inst "/usr/share/zoneinfo/posix/GMT-0"
    inst "/usr/share/zoneinfo/posix/Europe/Istanbul"
    inst "/usr/share/zoneinfo/posix/Europe/San_Marino"
    inst "/usr/share/zoneinfo/posix/Europe/Jersey"
    inst "/usr/share/zoneinfo/posix/Europe/Bucharest"
    inst "/usr/share/zoneinfo/posix/Europe/Gibraltar"
    inst "/usr/share/zoneinfo/posix/Europe/Uzhgorod"
    inst "/usr/share/zoneinfo/posix/Europe/Moscow"
    inst "/usr/share/zoneinfo/posix/Europe/Brussels"
    inst "/usr/share/zoneinfo/posix/Europe/Nicosia"
    inst "/usr/share/zoneinfo/posix/Europe/Zurich"
    inst "/usr/share/zoneinfo/posix/Europe/Berlin"
    inst "/usr/share/zoneinfo/posix/Europe/Guernsey"
    inst "/usr/share/zoneinfo/posix/Europe/Budapest"
    inst "/usr/share/zoneinfo/posix/Europe/Kiev"
    inst "/usr/share/zoneinfo/posix/Europe/Podgorica"
    inst "/usr/share/zoneinfo/posix/Europe/Isle_of_Man"
    inst "/usr/share/zoneinfo/posix/Europe/Mariehamn"
    inst "/usr/share/zoneinfo/posix/Europe/Belgrade"
    inst "/usr/share/zoneinfo/posix/Europe/Belfast"
    inst "/usr/share/zoneinfo/posix/Europe/Ljubljana"
    inst "/usr/share/zoneinfo/posix/Europe/Chisinau"
    inst "/usr/share/zoneinfo/posix/Europe/Andorra"
    inst "/usr/share/zoneinfo/posix/Europe/Athens"
    inst "/usr/share/zoneinfo/posix/Europe/Stockholm"
    inst "/usr/share/zoneinfo/posix/Europe/Vienna"
    inst "/usr/share/zoneinfo/posix/Europe/Lisbon"
    inst "/usr/share/zoneinfo/posix/Europe/London"
    inst "/usr/share/zoneinfo/posix/Europe/Paris"
    inst "/usr/share/zoneinfo/posix/Europe/Oslo"
    inst "/usr/share/zoneinfo/posix/Europe/Zagreb"
    inst "/usr/share/zoneinfo/posix/Europe/Helsinki"
    inst "/usr/share/zoneinfo/posix/Europe/Warsaw"
    inst "/usr/share/zoneinfo/posix/Europe/Copenhagen"
    inst "/usr/share/zoneinfo/posix/Europe/Riga"
    inst "/usr/share/zoneinfo/posix/Europe/Vaduz"
    inst "/usr/share/zoneinfo/posix/Europe/Vilnius"
    inst "/usr/share/zoneinfo/posix/Europe/Volgograd"
    inst "/usr/share/zoneinfo/posix/Europe/Amsterdam"
    inst "/usr/share/zoneinfo/posix/Europe/Tiraspol"
    inst "/usr/share/zoneinfo/posix/Europe/Tallinn"
    inst "/usr/share/zoneinfo/posix/Europe/Kaliningrad"
    inst "/usr/share/zoneinfo/posix/Europe/Malta"
    inst "/usr/share/zoneinfo/posix/Europe/Sarajevo"
    inst "/usr/share/zoneinfo/posix/Europe/Madrid"
    inst "/usr/share/zoneinfo/posix/Europe/Zaporozhye"
    inst "/usr/share/zoneinfo/posix/Europe/Simferopol"
    inst "/usr/share/zoneinfo/posix/Europe/Sofia"
    inst "/usr/share/zoneinfo/posix/Europe/Skopje"
    inst "/usr/share/zoneinfo/posix/Europe/Monaco"
    inst "/usr/share/zoneinfo/posix/Europe/Rome"
    inst "/usr/share/zoneinfo/posix/Europe/Prague"
    inst "/usr/share/zoneinfo/posix/Europe/Luxembourg"
    inst "/usr/share/zoneinfo/posix/Europe/Minsk"
    inst "/usr/share/zoneinfo/posix/Europe/Vatican"
    inst "/usr/share/zoneinfo/posix/Europe/Dublin"
    inst "/usr/share/zoneinfo/posix/Europe/Samara"
    inst "/usr/share/zoneinfo/posix/Europe/Tirane"
    inst "/usr/share/zoneinfo/posix/Europe/Bratislava"
    inst "/usr/share/zoneinfo/posix/Greenwich"
    inst "/usr/share/zoneinfo/posix/US/Indiana-Starke"
    inst "/usr/share/zoneinfo/posix/US/Alaska"
    inst "/usr/share/zoneinfo/posix/US/Michigan"
    inst "/usr/share/zoneinfo/posix/US/Aleutian"
    inst "/usr/share/zoneinfo/posix/US/Hawaii"
    inst "/usr/share/zoneinfo/posix/US/Central"
    inst "/usr/share/zoneinfo/posix/US/Eastern"
    inst "/usr/share/zoneinfo/posix/US/Pacific"
    inst "/usr/share/zoneinfo/posix/US/Samoa"
    inst "/usr/share/zoneinfo/posix/US/Mountain"
    inst "/usr/share/zoneinfo/posix/US/Arizona"
    inst "/usr/share/zoneinfo/posix/US/East-Indiana"
    inst "/usr/share/zoneinfo/posix/EST"
    inst "/usr/share/zoneinfo/posix/HST"
    inst "/usr/share/zoneinfo/posix/Eire"
    inst "/usr/share/zoneinfo/posix/America/Cancun"
    inst "/usr/share/zoneinfo/posix/America/Santo_Domingo"
    inst "/usr/share/zoneinfo/posix/America/Jujuy"
    inst "/usr/share/zoneinfo/posix/America/Guatemala"
    inst "/usr/share/zoneinfo/posix/America/Monterrey"
    inst "/usr/share/zoneinfo/posix/America/Ensenada"
    inst "/usr/share/zoneinfo/posix/America/Dawson_Creek"
    inst "/usr/share/zoneinfo/posix/America/Mendoza"
    inst "/usr/share/zoneinfo/posix/America/Coral_Harbour"
    inst "/usr/share/zoneinfo/posix/America/Martinique"
    inst "/usr/share/zoneinfo/posix/America/Cordoba"
    inst "/usr/share/zoneinfo/posix/America/Recife"
    inst "/usr/share/zoneinfo/posix/America/Cayman"
    inst "/usr/share/zoneinfo/posix/America/Shiprock"
    inst "/usr/share/zoneinfo/posix/America/Tortola"
    inst "/usr/share/zoneinfo/posix/America/Lima"
    inst "/usr/share/zoneinfo/posix/America/Antigua"
    inst "/usr/share/zoneinfo/posix/America/Blanc-Sablon"
    inst "/usr/share/zoneinfo/posix/America/Nipigon"
    inst "/usr/share/zoneinfo/posix/America/Nome"
    inst "/usr/share/zoneinfo/posix/America/Montserrat"
    inst "/usr/share/zoneinfo/posix/America/Atka"
    inst "/usr/share/zoneinfo/posix/America/St_Thomas"
    inst "/usr/share/zoneinfo/posix/America/Halifax"
    inst "/usr/share/zoneinfo/posix/America/Montreal"
    inst "/usr/share/zoneinfo/posix/America/Curacao"
    inst "/usr/share/zoneinfo/posix/America/Cuiaba"
    inst "/usr/share/zoneinfo/posix/America/Winnipeg"
    inst "/usr/share/zoneinfo/posix/America/North_Dakota/New_Salem"
    inst "/usr/share/zoneinfo/posix/America/North_Dakota/Center"
    inst "/usr/share/zoneinfo/posix/America/Panama"
    inst "/usr/share/zoneinfo/posix/America/Rosario"
    inst "/usr/share/zoneinfo/posix/America/Anguilla"
    inst "/usr/share/zoneinfo/posix/America/Ojinaga"
    inst "/usr/share/zoneinfo/posix/America/Guyana"
    inst "/usr/share/zoneinfo/posix/America/Eirunepe"
    inst "/usr/share/zoneinfo/posix/America/Grand_Turk"
    inst "/usr/share/zoneinfo/posix/America/Rio_Branco"
    inst "/usr/share/zoneinfo/posix/America/Santa_Isabel"
    inst "/usr/share/zoneinfo/posix/America/Scoresbysund"
    inst "/usr/share/zoneinfo/posix/America/Adak"
    inst "/usr/share/zoneinfo/posix/America/Menominee"
    inst "/usr/share/zoneinfo/posix/America/Resolute"
    inst "/usr/share/zoneinfo/posix/America/Guadeloupe"
    inst "/usr/share/zoneinfo/posix/America/Indianapolis"
    inst "/usr/share/zoneinfo/posix/America/Vancouver"
    inst "/usr/share/zoneinfo/posix/America/Glace_Bay"
    inst "/usr/share/zoneinfo/posix/America/Buenos_Aires"
    inst "/usr/share/zoneinfo/posix/America/Virgin"
    inst "/usr/share/zoneinfo/posix/America/Belem"
    inst "/usr/share/zoneinfo/posix/America/Catamarca"
    inst "/usr/share/zoneinfo/posix/America/Bahia"
    inst "/usr/share/zoneinfo/posix/America/Fort_Wayne"
    inst "/usr/share/zoneinfo/posix/America/Hermosillo"
    inst "/usr/share/zoneinfo/posix/America/Rankin_Inlet"
    inst "/usr/share/zoneinfo/posix/America/Mexico_City"
    inst "/usr/share/zoneinfo/posix/America/Belize"
    inst "/usr/share/zoneinfo/posix/America/Maceio"
    inst "/usr/share/zoneinfo/posix/America/Dominica"
    inst "/usr/share/zoneinfo/posix/America/Swift_Current"
    inst "/usr/share/zoneinfo/posix/America/St_Johns"
    inst "/usr/share/zoneinfo/posix/America/St_Barthelemy"
    inst "/usr/share/zoneinfo/posix/America/Yellowknife"
    inst "/usr/share/zoneinfo/posix/America/Costa_Rica"
    inst "/usr/share/zoneinfo/posix/America/Pangnirtung"
    inst "/usr/share/zoneinfo/posix/America/Bogota"
    inst "/usr/share/zoneinfo/posix/America/Port-au-Prince"
    inst "/usr/share/zoneinfo/posix/America/Phoenix"
    inst "/usr/share/zoneinfo/posix/America/Port_of_Spain"
    inst "/usr/share/zoneinfo/posix/America/Matamoros"
    inst "/usr/share/zoneinfo/posix/America/Puerto_Rico"
    inst "/usr/share/zoneinfo/posix/America/Detroit"
    inst "/usr/share/zoneinfo/posix/America/Edmonton"
    inst "/usr/share/zoneinfo/posix/America/Toronto"
    inst "/usr/share/zoneinfo/posix/America/Cambridge_Bay"
    inst "/usr/share/zoneinfo/posix/America/Godthab"
    inst "/usr/share/zoneinfo/posix/America/Atikokan"
    inst "/usr/share/zoneinfo/posix/America/Juneau"
    inst "/usr/share/zoneinfo/posix/America/Managua"
    inst "/usr/share/zoneinfo/posix/America/Anchorage"
    inst "/usr/share/zoneinfo/posix/America/Merida"
    inst "/usr/share/zoneinfo/posix/America/Thunder_Bay"
    inst "/usr/share/zoneinfo/posix/America/Porto_Velho"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Jujuy"
    inst "/usr/share/zoneinfo/posix/America/Argentina/La_Rioja"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Mendoza"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Cordoba"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Ushuaia"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Rio_Gallegos"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Buenos_Aires"
    inst "/usr/share/zoneinfo/posix/America/Argentina/San_Juan"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Catamarca"
    inst "/usr/share/zoneinfo/posix/America/Argentina/San_Luis"
    inst "/usr/share/zoneinfo/posix/America/Argentina/ComodRivadavia"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Salta"
    inst "/usr/share/zoneinfo/posix/America/Argentina/Tucuman"
    inst "/usr/share/zoneinfo/posix/America/Iqaluit"
    inst "/usr/share/zoneinfo/posix/America/Chicago"
    inst "/usr/share/zoneinfo/posix/America/Miquelon"
    inst "/usr/share/zoneinfo/posix/America/Havana"
    inst "/usr/share/zoneinfo/posix/America/Guayaquil"
    inst "/usr/share/zoneinfo/posix/America/St_Vincent"
    inst "/usr/share/zoneinfo/posix/America/St_Lucia"
    inst "/usr/share/zoneinfo/posix/America/Boise"
    inst "/usr/share/zoneinfo/posix/America/Yakutat"
    inst "/usr/share/zoneinfo/posix/America/Santarem"
    inst "/usr/share/zoneinfo/posix/America/Campo_Grande"
    inst "/usr/share/zoneinfo/posix/America/Santiago"
    inst "/usr/share/zoneinfo/posix/America/Porto_Acre"
    inst "/usr/share/zoneinfo/posix/America/Sao_Paulo"
    inst "/usr/share/zoneinfo/posix/America/Thule"
    inst "/usr/share/zoneinfo/posix/America/New_York"
    inst "/usr/share/zoneinfo/posix/America/Nassau"
    inst "/usr/share/zoneinfo/posix/America/Dawson"
    inst "/usr/share/zoneinfo/posix/America/Louisville"
    inst "/usr/share/zoneinfo/posix/America/Asuncion"
    inst "/usr/share/zoneinfo/posix/America/Inuvik"
    inst "/usr/share/zoneinfo/posix/America/Paramaribo"
    inst "/usr/share/zoneinfo/posix/America/Chihuahua"
    inst "/usr/share/zoneinfo/posix/America/Mazatlan"
    inst "/usr/share/zoneinfo/posix/America/Grenada"
    inst "/usr/share/zoneinfo/posix/America/Denver"
    inst "/usr/share/zoneinfo/posix/America/Los_Angeles"
    inst "/usr/share/zoneinfo/posix/America/Marigot"
    inst "/usr/share/zoneinfo/posix/America/Manaus"
    inst "/usr/share/zoneinfo/posix/America/Regina"
    inst "/usr/share/zoneinfo/posix/America/Barbados"
    inst "/usr/share/zoneinfo/posix/America/Noronha"
    inst "/usr/share/zoneinfo/posix/America/Montevideo"
    inst "/usr/share/zoneinfo/posix/America/Caracas"
    inst "/usr/share/zoneinfo/posix/America/Rainy_River"
    inst "/usr/share/zoneinfo/posix/America/La_Paz"
    inst "/usr/share/zoneinfo/posix/America/Jamaica"
    inst "/usr/share/zoneinfo/posix/America/Moncton"
    inst "/usr/share/zoneinfo/posix/America/Whitehorse"
    inst "/usr/share/zoneinfo/posix/America/Fortaleza"
    inst "/usr/share/zoneinfo/posix/America/Kentucky/Monticello"
    inst "/usr/share/zoneinfo/posix/America/Kentucky/Louisville"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Marengo"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Indianapolis"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Knox"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Tell_City"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Petersburg"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Winamac"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Vincennes"
    inst "/usr/share/zoneinfo/posix/America/Indiana/Vevay"
    inst "/usr/share/zoneinfo/posix/America/Danmarkshavn"
    inst "/usr/share/zoneinfo/posix/America/St_Kitts"
    inst "/usr/share/zoneinfo/posix/America/Aruba"
    inst "/usr/share/zoneinfo/posix/America/Boa_Vista"
    inst "/usr/share/zoneinfo/posix/America/Bahia_Banderas"
    inst "/usr/share/zoneinfo/posix/America/Tegucigalpa"
    inst "/usr/share/zoneinfo/posix/America/Araguaina"
    inst "/usr/share/zoneinfo/posix/America/El_Salvador"
    inst "/usr/share/zoneinfo/posix/America/Cayenne"
    inst "/usr/share/zoneinfo/posix/America/Tijuana"
    inst "/usr/share/zoneinfo/posix/America/Knox_IN"
    inst "/usr/share/zoneinfo/posix/America/Goose_Bay"
    inst "/usr/share/zoneinfo/posix/EET"
    inst "/usr/share/zoneinfo/posix/EST5EDT"
    inst "/usr/share/zoneinfo/posix/MST"
    inst "/usr/share/zoneinfo/posix/Iceland"
    inst "/usr/share/zoneinfo/posix/Atlantic/Faeroe"
    inst "/usr/share/zoneinfo/posix/Atlantic/Stanley"
    inst "/usr/share/zoneinfo/posix/Atlantic/Reykjavik"
    inst "/usr/share/zoneinfo/posix/Atlantic/St_Helena"
    inst "/usr/share/zoneinfo/posix/Atlantic/Faroe"
    inst "/usr/share/zoneinfo/posix/Atlantic/South_Georgia"
    inst "/usr/share/zoneinfo/posix/Atlantic/Jan_Mayen"
    inst "/usr/share/zoneinfo/posix/Atlantic/Azores"
    inst "/usr/share/zoneinfo/posix/Atlantic/Cape_Verde"
    inst "/usr/share/zoneinfo/posix/Atlantic/Madeira"
    inst "/usr/share/zoneinfo/posix/Atlantic/Bermuda"
    inst "/usr/share/zoneinfo/posix/Atlantic/Canary"
    inst "/usr/share/zoneinfo/posix/GMT0"
    inst "/usr/share/zoneinfo/posix/Poland"
    inst "/usr/share/zoneinfo/posix/Indian/Chagos"
    inst "/usr/share/zoneinfo/posix/Indian/Maldives"
    inst "/usr/share/zoneinfo/posix/Indian/Comoro"
    inst "/usr/share/zoneinfo/posix/Indian/Mauritius"
    inst "/usr/share/zoneinfo/posix/Indian/Mayotte"
    inst "/usr/share/zoneinfo/posix/Indian/Christmas"
    inst "/usr/share/zoneinfo/posix/Indian/Antananarivo"
    inst "/usr/share/zoneinfo/posix/Indian/Kerguelen"
    inst "/usr/share/zoneinfo/posix/Indian/Mahe"
    inst "/usr/share/zoneinfo/posix/Indian/Cocos"
    inst "/usr/share/zoneinfo/posix/Indian/Reunion"
    inst "/usr/share/zoneinfo/posix/Mexico/BajaNorte"
    inst "/usr/share/zoneinfo/posix/Mexico/BajaSur"
    inst "/usr/share/zoneinfo/posix/Mexico/General"
    inst "/usr/share/zoneinfo/posix/Turkey"
    inst "/usr/share/zoneinfo/posix/Egypt"
    inst "/usr/share/zoneinfo/posix/Hongkong"
    inst "/usr/share/zoneinfo/posix/GB"
    inst "/usr/share/zoneinfo/posix/GMT+0"
    inst "/usr/share/zoneinfo/posix/ROK"
    inst "/usr/share/zoneinfo/posix/Antarctica/Mawson"
    inst "/usr/share/zoneinfo/posix/Antarctica/Macquarie"
    inst "/usr/share/zoneinfo/posix/Antarctica/South_Pole"
    inst "/usr/share/zoneinfo/posix/Antarctica/Rothera"
    inst "/usr/share/zoneinfo/posix/Antarctica/Davis"
    inst "/usr/share/zoneinfo/posix/Antarctica/DumontDUrville"
    inst "/usr/share/zoneinfo/posix/Antarctica/McMurdo"
    inst "/usr/share/zoneinfo/posix/Antarctica/Casey"
    inst "/usr/share/zoneinfo/posix/Antarctica/Vostok"
    inst "/usr/share/zoneinfo/posix/Antarctica/Palmer"
    inst "/usr/share/zoneinfo/posix/Antarctica/Syowa"
    inst "/usr/share/zoneinfo/posix/Universal"
    inst "/usr/share/zoneinfo/posix/CET"
    inst "/usr/share/zoneinfo/posix/WET"
    inst "/usr/share/zoneinfo/posix/Navajo"
    inst "/usr/share/zoneinfo/posix/UTC"
    inst "/usr/share/zoneinfo/posix/Pacific/Enderbury"
    inst "/usr/share/zoneinfo/posix/Pacific/Johnston"
    inst "/usr/share/zoneinfo/posix/Pacific/Pago_Pago"
    inst "/usr/share/zoneinfo/posix/Pacific/Saipan"
    inst "/usr/share/zoneinfo/posix/Pacific/Norfolk"
    inst "/usr/share/zoneinfo/posix/Pacific/Chuuk"
    inst "/usr/share/zoneinfo/posix/Pacific/Galapagos"
    inst "/usr/share/zoneinfo/posix/Pacific/Palau"
    inst "/usr/share/zoneinfo/posix/Pacific/Tarawa"
    inst "/usr/share/zoneinfo/posix/Pacific/Fakaofo"
    inst "/usr/share/zoneinfo/posix/Pacific/Rarotonga"
    inst "/usr/share/zoneinfo/posix/Pacific/Wake"
    inst "/usr/share/zoneinfo/posix/Pacific/Kosrae"
    inst "/usr/share/zoneinfo/posix/Pacific/Tahiti"
    inst "/usr/share/zoneinfo/posix/Pacific/Fiji"
    inst "/usr/share/zoneinfo/posix/Pacific/Ponape"
    inst "/usr/share/zoneinfo/posix/Pacific/Tongatapu"
    inst "/usr/share/zoneinfo/posix/Pacific/Efate"
    inst "/usr/share/zoneinfo/posix/Pacific/Honolulu"
    inst "/usr/share/zoneinfo/posix/Pacific/Niue"
    inst "/usr/share/zoneinfo/posix/Pacific/Kwajalein"
    inst "/usr/share/zoneinfo/posix/Pacific/Guam"
    inst "/usr/share/zoneinfo/posix/Pacific/Funafuti"
    inst "/usr/share/zoneinfo/posix/Pacific/Majuro"
    inst "/usr/share/zoneinfo/posix/Pacific/Midway"
    inst "/usr/share/zoneinfo/posix/Pacific/Nauru"
    inst "/usr/share/zoneinfo/posix/Pacific/Samoa"
    inst "/usr/share/zoneinfo/posix/Pacific/Marquesas"
    inst "/usr/share/zoneinfo/posix/Pacific/Kiritimati"
    inst "/usr/share/zoneinfo/posix/Pacific/Noumea"
    inst "/usr/share/zoneinfo/posix/Pacific/Truk"
    inst "/usr/share/zoneinfo/posix/Pacific/Guadalcanal"
    inst "/usr/share/zoneinfo/posix/Pacific/Pohnpei"
    inst "/usr/share/zoneinfo/posix/Pacific/Pitcairn"
    inst "/usr/share/zoneinfo/posix/Pacific/Port_Moresby"
    inst "/usr/share/zoneinfo/posix/Pacific/Yap"
    inst "/usr/share/zoneinfo/posix/Pacific/Easter"
    inst "/usr/share/zoneinfo/posix/Pacific/Wallis"
    inst "/usr/share/zoneinfo/posix/Pacific/Apia"
    inst "/usr/share/zoneinfo/posix/Pacific/Auckland"
    inst "/usr/share/zoneinfo/posix/Pacific/Gambier"
    inst "/usr/share/zoneinfo/posix/Pacific/Chatham"
    inst "/usr/share/zoneinfo/posix/Japan"
    inst "/usr/share/zoneinfo/posix/Libya"
    inst "/usr/share/zoneinfo/posix/ROC"
    inst "/usr/share/zoneinfo/posix/Iran"
    inst "/usr/share/zoneinfo/posix/Brazil/West"
    inst "/usr/share/zoneinfo/posix/Brazil/East"
    inst "/usr/share/zoneinfo/posix/Brazil/Acre"
    inst "/usr/share/zoneinfo/posix/Brazil/DeNoronha"
    inst "/usr/share/zoneinfo/posix/Arctic/Longyearbyen"
    inst "/usr/share/zoneinfo/posix/Portugal"
    inst "/usr/share/zoneinfo/posix/MET"
    inst "/usr/share/zoneinfo/posix/W-SU"
    inst "/usr/share/zoneinfo/posix/Kwajalein"
    inst "/usr/share/zoneinfo/posix/CST6CDT"
    inst "/usr/share/zoneinfo/posix/GB-Eire"
    inst "/usr/share/zoneinfo/posix/Australia/Melbourne"
    inst "/usr/share/zoneinfo/posix/Australia/Broken_Hill"
    inst "/usr/share/zoneinfo/posix/Australia/Queensland"
    inst "/usr/share/zoneinfo/posix/Australia/South"
    inst "/usr/share/zoneinfo/posix/Australia/Eucla"
    inst "/usr/share/zoneinfo/posix/Australia/Yancowinna"
    inst "/usr/share/zoneinfo/posix/Australia/Lord_Howe"
    inst "/usr/share/zoneinfo/posix/Australia/Hobart"
    inst "/usr/share/zoneinfo/posix/Australia/NSW"
    inst "/usr/share/zoneinfo/posix/Australia/West"
    inst "/usr/share/zoneinfo/posix/Australia/LHI"
    inst "/usr/share/zoneinfo/posix/Australia/Perth"
    inst "/usr/share/zoneinfo/posix/Australia/ACT"
    inst "/usr/share/zoneinfo/posix/Australia/Darwin"
    inst "/usr/share/zoneinfo/posix/Australia/Lindeman"
    inst "/usr/share/zoneinfo/posix/Australia/Sydney"
    inst "/usr/share/zoneinfo/posix/Australia/North"
    inst "/usr/share/zoneinfo/posix/Australia/Canberra"
    inst "/usr/share/zoneinfo/posix/Australia/Adelaide"
    inst "/usr/share/zoneinfo/posix/Australia/Brisbane"
    inst "/usr/share/zoneinfo/posix/Australia/Victoria"
    inst "/usr/share/zoneinfo/posix/Australia/Tasmania"
    inst "/usr/share/zoneinfo/posix/Australia/Currie"
    inst "/usr/share/zoneinfo/posix/UCT"
    inst "/usr/share/zoneinfo/posix/Cuba"
    inst "/usr/share/zoneinfo/posix/Singapore"
    inst "/usr/share/zoneinfo/posix/GMT"
    inst "/usr/share/zoneinfo/posix/NZ-CHAT"
    inst "/usr/share/zoneinfo/posix/Asia/Istanbul"
    inst "/usr/share/zoneinfo/posix/Asia/Kuwait"
    inst "/usr/share/zoneinfo/posix/Asia/Saigon"
    inst "/usr/share/zoneinfo/posix/Asia/Urumqi"
    inst "/usr/share/zoneinfo/posix/Asia/Brunei"
    inst "/usr/share/zoneinfo/posix/Asia/Ujung_Pandang"
    inst "/usr/share/zoneinfo/posix/Asia/Muscat"
    inst "/usr/share/zoneinfo/posix/Asia/Kashgar"
    inst "/usr/share/zoneinfo/posix/Asia/Kamchatka"
    inst "/usr/share/zoneinfo/posix/Asia/Manila"
    inst "/usr/share/zoneinfo/posix/Asia/Vladivostok"
    inst "/usr/share/zoneinfo/posix/Asia/Jayapura"
    inst "/usr/share/zoneinfo/posix/Asia/Magadan"
    inst "/usr/share/zoneinfo/posix/Asia/Almaty"
    inst "/usr/share/zoneinfo/posix/Asia/Qyzylorda"
    inst "/usr/share/zoneinfo/posix/Asia/Anadyr"
    inst "/usr/share/zoneinfo/posix/Asia/Nicosia"
    inst "/usr/share/zoneinfo/posix/Asia/Kathmandu"
    inst "/usr/share/zoneinfo/posix/Asia/Qatar"
    inst "/usr/share/zoneinfo/posix/Asia/Jerusalem"
    inst "/usr/share/zoneinfo/posix/Asia/Yakutsk"
    inst "/usr/share/zoneinfo/posix/Asia/Karachi"
    inst "/usr/share/zoneinfo/posix/Asia/Samarkand"
    inst "/usr/share/zoneinfo/posix/Asia/Kolkata"
    inst "/usr/share/zoneinfo/posix/Asia/Ulaanbaatar"
    inst "/usr/share/zoneinfo/posix/Asia/Irkutsk"
    inst "/usr/share/zoneinfo/posix/Asia/Baku"
    inst "/usr/share/zoneinfo/posix/Asia/Gaza"
    inst "/usr/share/zoneinfo/posix/Asia/Seoul"
    inst "/usr/share/zoneinfo/posix/Asia/Chungking"
    inst "/usr/share/zoneinfo/posix/Asia/Amman"
    inst "/usr/share/zoneinfo/posix/Asia/Kuala_Lumpur"
    inst "/usr/share/zoneinfo/posix/Asia/Aqtobe"
    inst "/usr/share/zoneinfo/posix/Asia/Katmandu"
    inst "/usr/share/zoneinfo/posix/Asia/Tashkent"
    inst "/usr/share/zoneinfo/posix/Asia/Oral"
    inst "/usr/share/zoneinfo/posix/Asia/Dhaka"
    inst "/usr/share/zoneinfo/posix/Asia/Hovd"
    inst "/usr/share/zoneinfo/posix/Asia/Makassar"
    inst "/usr/share/zoneinfo/posix/Asia/Bangkok"
    inst "/usr/share/zoneinfo/posix/Asia/Tokyo"
    inst "/usr/share/zoneinfo/posix/Asia/Macao"
    inst "/usr/share/zoneinfo/posix/Asia/Riyadh"
    inst "/usr/share/zoneinfo/posix/Asia/Rangoon"
    inst "/usr/share/zoneinfo/posix/Asia/Jakarta"
    inst "/usr/share/zoneinfo/posix/Asia/Aden"
    inst "/usr/share/zoneinfo/posix/Asia/Calcutta"
    inst "/usr/share/zoneinfo/posix/Asia/Ashkhabad"
    inst "/usr/share/zoneinfo/posix/Asia/Beirut"
    inst "/usr/share/zoneinfo/posix/Asia/Harbin"
    inst "/usr/share/zoneinfo/posix/Asia/Novosibirsk"
    inst "/usr/share/zoneinfo/posix/Asia/Omsk"
    inst "/usr/share/zoneinfo/posix/Asia/Aqtau"
    inst "/usr/share/zoneinfo/posix/Asia/Bahrain"
    inst "/usr/share/zoneinfo/posix/Asia/Dili"
    inst "/usr/share/zoneinfo/posix/Asia/Pontianak"
    inst "/usr/share/zoneinfo/posix/Asia/Singapore"
    inst "/usr/share/zoneinfo/posix/Asia/Baghdad"
    inst "/usr/share/zoneinfo/posix/Asia/Novokuznetsk"
    inst "/usr/share/zoneinfo/posix/Asia/Dubai"
    inst "/usr/share/zoneinfo/posix/Asia/Dushanbe"
    inst "/usr/share/zoneinfo/posix/Asia/Damascus"
    inst "/usr/share/zoneinfo/posix/Asia/Krasnoyarsk"
    inst "/usr/share/zoneinfo/posix/Asia/Tbilisi"
    inst "/usr/share/zoneinfo/posix/Asia/Yerevan"
    inst "/usr/share/zoneinfo/posix/Asia/Pyongyang"
    inst "/usr/share/zoneinfo/posix/Asia/Bishkek"
    inst "/usr/share/zoneinfo/posix/Asia/Colombo"
    inst "/usr/share/zoneinfo/posix/Asia/Yekaterinburg"
    inst "/usr/share/zoneinfo/posix/Asia/Chongqing"
    inst "/usr/share/zoneinfo/posix/Asia/Ho_Chi_Minh"
    inst "/usr/share/zoneinfo/posix/Asia/Hong_Kong"
    inst "/usr/share/zoneinfo/posix/Asia/Thimbu"
    inst "/usr/share/zoneinfo/posix/Asia/Thimphu"
    inst "/usr/share/zoneinfo/posix/Asia/Ashgabat"
    inst "/usr/share/zoneinfo/posix/Asia/Shanghai"
    inst "/usr/share/zoneinfo/posix/Asia/Tehran"
    inst "/usr/share/zoneinfo/posix/Asia/Tel_Aviv"
    inst "/usr/share/zoneinfo/posix/Asia/Taipei"
    inst "/usr/share/zoneinfo/posix/Asia/Kabul"
    inst "/usr/share/zoneinfo/posix/Asia/Macau"
    inst "/usr/share/zoneinfo/posix/Asia/Choibalsan"
    inst "/usr/share/zoneinfo/posix/Asia/Vientiane"
    inst "/usr/share/zoneinfo/posix/Asia/Dacca"
    inst "/usr/share/zoneinfo/posix/Asia/Kuching"
    inst "/usr/share/zoneinfo/posix/Asia/Phnom_Penh"
    inst "/usr/share/zoneinfo/posix/Asia/Ulan_Bator"
    inst "/usr/share/zoneinfo/posix/Asia/Sakhalin"
    inst "/usr/share/zoneinfo/posix/MST7MDT"
    inst "/usr/share/zoneinfo/posix/Canada/Atlantic"
    inst "/usr/share/zoneinfo/posix/Canada/Central"
    inst "/usr/share/zoneinfo/posix/Canada/Eastern"
    inst "/usr/share/zoneinfo/posix/Canada/Yukon"
    inst "/usr/share/zoneinfo/posix/Canada/Pacific"
    inst "/usr/share/zoneinfo/posix/Canada/Saskatchewan"
    inst "/usr/share/zoneinfo/posix/Canada/Mountain"
    inst "/usr/share/zoneinfo/posix/Canada/Newfoundland"
    inst "/usr/share/zoneinfo/posix/Israel"
    inst "/usr/share/zoneinfo/posix/Africa/Lagos"
    inst "/usr/share/zoneinfo/posix/Africa/Kigali"
    inst "/usr/share/zoneinfo/posix/Africa/Lome"
    inst "/usr/share/zoneinfo/posix/Africa/Niamey"
    inst "/usr/share/zoneinfo/posix/Africa/Conakry"
    inst "/usr/share/zoneinfo/posix/Africa/Asmera"
    inst "/usr/share/zoneinfo/posix/Africa/Banjul"
    inst "/usr/share/zoneinfo/posix/Africa/Abidjan"
    inst "/usr/share/zoneinfo/posix/Africa/Bujumbura"
    inst "/usr/share/zoneinfo/posix/Africa/Luanda"
    inst "/usr/share/zoneinfo/posix/Africa/Kampala"
    inst "/usr/share/zoneinfo/posix/Africa/Ouagadougou"
    inst "/usr/share/zoneinfo/posix/Africa/Libreville"
    inst "/usr/share/zoneinfo/posix/Africa/Lubumbashi"
    inst "/usr/share/zoneinfo/posix/Africa/Dakar"
    inst "/usr/share/zoneinfo/posix/Africa/Bamako"
    inst "/usr/share/zoneinfo/posix/Africa/Nairobi"
    inst "/usr/share/zoneinfo/posix/Africa/Bangui"
    inst "/usr/share/zoneinfo/posix/Africa/Johannesburg"
    inst "/usr/share/zoneinfo/posix/Africa/Accra"
    inst "/usr/share/zoneinfo/posix/Africa/Bissau"
    inst "/usr/share/zoneinfo/posix/Africa/Timbuktu"
    inst "/usr/share/zoneinfo/posix/Africa/Nouakchott"
    inst "/usr/share/zoneinfo/posix/Africa/Maputo"
    inst "/usr/share/zoneinfo/posix/Africa/Ndjamena"
    inst "/usr/share/zoneinfo/posix/Africa/Maseru"
    inst "/usr/share/zoneinfo/posix/Africa/Tripoli"
    inst "/usr/share/zoneinfo/posix/Africa/Blantyre"
    inst "/usr/share/zoneinfo/posix/Africa/Gaborone"
    inst "/usr/share/zoneinfo/posix/Africa/Addis_Ababa"
    inst "/usr/share/zoneinfo/posix/Africa/Porto-Novo"
    inst "/usr/share/zoneinfo/posix/Africa/Kinshasa"
    inst "/usr/share/zoneinfo/posix/Africa/Dar_es_Salaam"
    inst "/usr/share/zoneinfo/posix/Africa/Douala"
    inst "/usr/share/zoneinfo/posix/Africa/Mogadishu"
    inst "/usr/share/zoneinfo/posix/Africa/Monrovia"
    inst "/usr/share/zoneinfo/posix/Africa/Mbabane"
    inst "/usr/share/zoneinfo/posix/Africa/Algiers"
    inst "/usr/share/zoneinfo/posix/Africa/Lusaka"
    inst "/usr/share/zoneinfo/posix/Africa/Khartoum"
    inst "/usr/share/zoneinfo/posix/Africa/Asmara"
    inst "/usr/share/zoneinfo/posix/Africa/Tunis"
    inst "/usr/share/zoneinfo/posix/Africa/Casablanca"
    inst "/usr/share/zoneinfo/posix/Africa/Sao_Tome"
    inst "/usr/share/zoneinfo/posix/Africa/Ceuta"
    inst "/usr/share/zoneinfo/posix/Africa/El_Aaiun"
    inst "/usr/share/zoneinfo/posix/Africa/Harare"
    inst "/usr/share/zoneinfo/posix/Africa/Freetown"
    inst "/usr/share/zoneinfo/posix/Africa/Windhoek"
    inst "/usr/share/zoneinfo/posix/Africa/Djibouti"
    inst "/usr/share/zoneinfo/posix/Africa/Malabo"
    inst "/usr/share/zoneinfo/posix/Africa/Cairo"
    inst "/usr/share/zoneinfo/posix/Africa/Brazzaville"
    inst "/usr/share/zoneinfo/posix/Etc/Zulu"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-0"
    inst "/usr/share/zoneinfo/posix/Etc/Greenwich"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+6"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+9"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-9"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+5"
    inst "/usr/share/zoneinfo/posix/Etc/GMT0"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-10"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+0"
    inst "/usr/share/zoneinfo/posix/Etc/Universal"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+12"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-5"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+2"
    inst "/usr/share/zoneinfo/posix/Etc/UTC"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+8"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-11"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-4"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-12"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+11"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+3"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+4"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+1"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-14"
    inst "/usr/share/zoneinfo/posix/Etc/UCT"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+7"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-6"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-2"
    inst "/usr/share/zoneinfo/posix/Etc/GMT"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-3"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-8"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-7"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-13"
    inst "/usr/share/zoneinfo/posix/Etc/GMT-1"
    inst "/usr/share/zoneinfo/posix/Etc/GMT+10"
    inst "/usr/share/zoneinfo/posix/PST8PDT"
    inst "/usr/share/zoneinfo/posix/Jamaica"
    inst "/usr/share/zoneinfo/posix/NZ"
    inst "/usr/share/zoneinfo/posix/PRC"
    inst "/usr/share/zoneinfo/posix/Chile/EasterIsland"
    inst "/usr/share/zoneinfo/posix/Chile/Continental"


    # shellcheck disable=2154
    inst "$moddir/xcatroot" "/sbin/xcatroot"
    inst "$moddir/dhclient.conf" "/etc/dhclient.conf"

    inst_hook cmdline 10 "$moddir/xcat-cmdline.sh"
    inst_hook pre-mount 10 "$moddir/xcat-pre-mount.sh"
    # install our fixed rsyslogd start script
    inst_hook initqueue/online 69 "$moddir/xcat-rsyslogd-start.sh"

    inst_rules "$moddir/80-net-name-slot.rules"

    # copy user entries over for a few things
    #
    # Note that chrony and the NFS related users are handled by other modules
    # shellcheck disable=2154
    if ! grep -q '^sshd:' "$initdir/etc/passwd" ; then
        grep '^sshd:' "$dracutsysrootdir"/etc/passwd >> "$initdir/etc/passwd"
        grep '^sshd:' "$dracutsysrootdir"/etc/group >> "$initdir/etc/group"
    fi
    if ! grep -q '^qemu:' "$initdir/etc/passwd" ; then
        grep '^qemu:' "$dracutsysrootdir"/etc/passwd >> "$initdir/etc/passwd"
        grep '^qemu:' "$dracutsysrootdir"/etc/group >> "$initdir/etc/group"
    fi

}

