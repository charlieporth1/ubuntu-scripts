#!/bin/bash
#
#   Copyright 2012 Marco Vermeulen
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# Global variables
SDKMAN_SERVICE="https://api.sdkman.io/1"
SDKMAN_VERSION="5.5.9+231"

if [ -z "$SDKMAN_DIR" ]; then
    SDKMAN_DIR="$HOME/.sdkman"
fi

# Local variables
sdkman_bin_folder="${SDKMAN_DIR}/bin"
sdkman_src_folder="${SDKMAN_DIR}/src"
sdkman_tmp_folder="${SDKMAN_DIR}/tmp"
sdkman_stage_folder="${sdkman_tmp_folder}/stage"
sdkman_zip_file="${sdkman_tmp_folder}/res-${SDKMAN_VERSION}.zip"
sdkman_ext_folder="${SDKMAN_DIR}/ext"
sdkman_etc_folder="${SDKMAN_DIR}/etc"
sdkman_var_folder="${SDKMAN_DIR}/var"
sdkman_archives_folder="${SDKMAN_DIR}/archives"
sdkman_candidates_folder="${SDKMAN_DIR}/candidates"
sdkman_config_file="${sdkman_etc_folder}/config"
sdkman_bash_profile="${HOME}/.bash_profile"
sdkman_profile="${HOME}/.profile"
sdkman_bashrc="${HOME}/.bashrc"
sdkman_zshrc="${HOME}/.zshrc"
sdkman_platform=$(uname)

sdkman_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$SDKMAN_DIR"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
EOF
)

# OS specific support (must be 'true' or 'false').
cygwin=false;
darwin=false;
solaris=false;
freebsd=false;
case "$(uname)" in
    CYGWIN*)
        cygwin=true
        ;;
    Darwin*)
        darwin=true
        ;;
    SunOS*)
        solaris=true
        ;;
    FreeBSD*)
        freebsd=true
esac

echo '                                                               		         '
echo 'Thanks for using...                                            		         '
echo '                                                               		         '
echo '                                                               		         '
echo '     SSSSSSSSSSSSSSS DDDDDDDDDDDDD       KKKKKKKKK    KKKKKKK                  '
echo '   SS:::::::::::::::SD::::::::::::DDD    K:::::::K    K:::::K                  '
echo '  S:::::SSSSSS::::::SD:::::::::::::::DD  K:::::::K    K:::::K                  '
echo '  S:::::S     SSSSSSSDDD:::::DDDDD:::::D K:::::::K   K::::::K                  '
echo '  S:::::S              D:::::D    D:::::DKK::::::K  K:::::KKK                  '
echo '  S:::::S              D:::::D     D:::::D K:::::K K:::::K                     '
echo '   S::::SSSS           D:::::D     D:::::D K::::::K:::::K                      '
echo '    SS::::::SSSSS      D:::::D     D:::::D K:::::::::::K                       '
echo '      SSS::::::::SS    D:::::D     D:::::D K:::::::::::K                       '
echo '         SSSSSS::::S   D:::::D     D:::::D K::::::K:::::K                      '
echo '              S:::::S  D:::::D     D:::::D K:::::K K:::::K                     '
echo '              S:::::S  D:::::D    D:::::DKK::::::K  K:::::KKK                  '
echo '  SSSSSSS     S:::::SDDD:::::DDDDD:::::D K:::::::K   K::::::K                  '
echo '  S::::::SSSSSS:::::SD:::::::::::::::DD  K:::::::K    K:::::K                  '
echo '  S:::::::::::::::SS D::::::::::::DDD    K:::::::K    K:::::K                  '
echo '   SSSSSSSSSSSSSSS   DDDDDDDDDDDDD       KKKKKKKKK    KKKKKKK                  '
echo '                                                                               '
echo '                                                                               '
echo '                      mmmmmmm    mmmmmmm     aaaaaaaaaaaaa  nnnn  nnnnnnnn     '
echo '                    mm:::::::m  m:::::::mm   a::::::::::::a n:::nn::::::::nn   '
echo '                   m::::::::::mm::::::::::m  aaaaaaaaa:::::an::::::::::::::nn  '
echo '                   m::::::::::::::::::::::m           a::::ann:::::::::::::::n '
echo '                   m:::::mmm::::::mmm:::::m    aaaaaaa:::::a  n:::::nnnn:::::n '
echo '                   m::::m   m::::m   m::::m  aa::::::::::::a  n::::n    n::::n '
echo '                   m::::m   m::::m   m::::m a::::aaaa::::::a  n::::n    n::::n '
echo '                   m::::m   m::::m   m::::ma::::a    a:::::a  n::::n    n::::n '
echo '                   m::::m   m::::m   m::::ma::::a    a:::::a  n::::n    n::::n '
echo '                   m::::m   m::::m   m::::ma:::::aaaa::::::a  n::::n    n::::n '
echo '                   m::::m   m::::m   m::::m a::::::::::aa:::a n::::n    n::::n '
echo '                   mmmmmm   mmmmmm   mmmmmm  aaaaaaaaaa  aaaa nnnnnn    nnnnnn '
echo '            								                                     '
echo '            								                                     '
echo '                                                 Now attempting installation...'
echo '                                                                               '


# Sanity checks

echo "Looking for a previous installation of SDKMAN..."
if [ -d "$SDKMAN_DIR" ]; then
	echo "SDKMAN found."
	echo ""
	echo "======================================================================================================"
	echo " You already have SDKMAN installed."
	echo " SDKMAN was found at:"
	echo ""
	echo "    ${SDKMAN_DIR}"
	echo ""
	echo " Please consider running the following if you need to upgrade."
	echo ""
	echo "    $ sdk selfupdate force"
	echo ""
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for unzip..."
if [ -z $(which unzip) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install unzip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing unzip."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for zip..."
if [ -z $(which zip) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install zip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing zip."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for curl..."
if [ -z $(which curl) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install curl on your system using your favourite package manager."
	echo ""
	echo " Restart after installing curl."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

if [[ "$solaris" == true ]]; then
	echo "Looking for gsed..."
	if [ -z $(which gsed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install gsed on your solaris system."
		echo ""
		echo " SDKMAN uses gsed extensively."
		echo ""
		echo " Restart after installing gsed."
		echo "======================================================================================================"
		echo ""
		exit 0
	fi
else
	echo "Looking for sed..."
	if [ -z $(which sed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install sed on your system using your favourite package manager."
		echo ""
		echo " Restart after installing sed."
		echo "======================================================================================================"
		echo ""
		exit 0
	fi
fi


echo "Installing SDKMAN scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "$sdkman_bin_folder"
mkdir -p "$sdkman_src_folder"
mkdir -p "$sdkman_tmp_folder"
mkdir -p "$sdkman_stage_folder"
mkdir -p "$sdkman_ext_folder"
mkdir -p "$sdkman_etc_folder"
mkdir -p "$sdkman_var_folder"
mkdir -p "$sdkman_archives_folder"
mkdir -p "$sdkman_candidates_folder"

echo "Getting available candidates..."
SDKMAN_CANDIDATES_CSV=$(curl -s "https://api.sdkman.io/2/candidates/all")
echo "$SDKMAN_CANDIDATES_CSV" > "${SDKMAN_DIR}/var/candidates"

echo "Prime the config file..."
touch "$sdkman_config_file"
echo "sdkman_auto_answer=false" >> "$sdkman_config_file"
echo "sdkman_auto_selfupdate=false" >> "$sdkman_config_file"
echo "sdkman_insecure_ssl=false" >> "$sdkman_config_file"
echo "sdkman_disable_gvm_alias=false" >> "$sdkman_config_file"
echo "sdkman_curl_connect_timeout=7" >> "$sdkman_config_file"
echo "sdkman_curl_max_time=10" >> "$sdkman_config_file"
echo "sdkman_beta_channel=false" >> "$sdkman_config_file"
echo "sdkman_debug_mode=false" >> "$sdkman_config_file"
echo "sdkman_colour_enable=true" >> "$sdkman_config_file"

echo "Download script archive..."
curl -L "${SDKMAN_SERVICE}/res?platform=${sdkman_platform}&purpose=install" > "$sdkman_zip_file"

echo "Extract script archive..."
if [[ "$cygwin" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	sdkman_zip_file=$(cygpath -w "$sdkman_zip_file")
	sdkman_stage_folder=$(cygpath -w "$sdkman_stage_folder")
fi
unzip -qo "$sdkman_zip_file" -d "$sdkman_stage_folder"


echo "Install scripts..."
mv "${sdkman_stage_folder}/sdkman-init.sh" "$sdkman_bin_folder"
mv "$sdkman_stage_folder"/sdkman-* "$sdkman_src_folder"


echo "Set version to $SDKMAN_VERSION ..."
echo "$SDKMAN_VERSION" > "${SDKMAN_DIR}/var/version"


echo "Attempt update of bash profiles..."
if [ ! -f "$sdkman_bash_profile" -a ! -f "$sdkman_profile" ]; then
	echo "#!/bin/bash" > "$sdkman_bash_profile"
	echo "$sdkman_init_snippet" >> "$sdkman_bash_profile"
	echo "Created and initialised ${sdkman_bash_profile}"
else
	if [ -f "$sdkman_bash_profile" ]; then
		if [[ -z `grep 'sdkman-init.sh' "$sdkman_bash_profile"` ]]; then
			echo -e "\n$sdkman_init_snippet" >> "$sdkman_bash_profile"
			echo "Updated existing ${sdkman_bash_profile}"
		fi
	fi

	if [ -f "$sdkman_profile" ]; then
		if [[ -z `grep 'sdkman-init.sh' "$sdkman_profile"` ]]; then
			echo -e "\n$sdkman_init_snippet" >> "$sdkman_profile"
			echo "Updated existing ${sdkman_profile}"
		fi
	fi
fi

if [ ! -f "$sdkman_bashrc" ]; then
	echo "#!/bin/bash" > "$sdkman_bashrc"
	echo "$sdkman_init_snippet" >> "$sdkman_bashrc"
	echo "Created and initialised ${sdkman_bashrc}"
else
	if [[ -z `grep 'sdkman-init.sh' "$sdkman_bashrc"` ]]; then
		echo -e "\n$sdkman_init_snippet" >> "$sdkman_bashrc"
		echo "Updated existing ${sdkman_bashrc}"
	fi
fi

echo "Attempt update of zsh profiles..."
if [ ! -f "$sdkman_zshrc" ]; then
	echo "$sdkman_init_snippet" >> "$sdkman_zshrc"
	echo "Created and initialised ${sdkman_zshrc}"
else
	if [[ -z `grep 'sdkman-init.sh' "$sdkman_zshrc"` ]]; then
		echo -e "\n$sdkman_init_snippet" >> "$sdkman_zshrc"
		echo "Updated existing ${sdkman_zshrc}"
	fi
fi

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${SDKMAN_DIR}/bin/sdkman-init.sh\""
echo ""
echo "Then issue the following command:"
echo ""
echo "    sdk help"
echo ""
echo "Enjoy!!!"
