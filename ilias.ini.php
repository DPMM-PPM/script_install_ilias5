; <?php exit; ?>
[server]
http_path = "http://path"
absolute_path = "absolute_path"
presetting = ""
timezone = "Europe/Paris"

[clients]
path = "data"
inifile = "client.ini.php"
datadir = "externe_path"
default = "eformarine"
list = "0"

[setup]
pass = "md5_setup_pass"

[tools]
convert = "/usr/bin/convert"
zip = "/usr/bin/zip"
unzip = "/usr/bin/unzip"
java = ""
ffmpeg = "/usr/bin/ffmpeg"
ghostscript = "/usr/bin/gs"
latex = ""
vscantype = "none"
scancommand = ""
cleancommand = ""
enable_system_styles_management = "1"
lessc = "lessc"
phantomjs = ""

[log]
path = "/var/www/dataout"
file = "ilias.log"
enabled = "1"
level = "WARNING"
error_path = "/var/www/dataout/error"

[debian]
data_dir = "/var/opt/ilias"
log = "/var/log/ilias/ilias.log"
convert = "/usr/bin/convert"
zip = "/usr/bin/zip"
unzip = "/usr/bin/unzip"
java = ""
ffmpeg = "/usr/bin/ffmpeg"

[redhat]
data_dir = ""
log = ""
convert = ""
zip = ""
unzip = ""
java = ""

[suse]
data_dir = ""
log = ""
convert = ""
zip = ""
unzip = ""
java = ""

[https]
auto_https_detect_enabled = "0"
auto_https_detect_header_name = ""
auto_https_detect_header_value = ""
