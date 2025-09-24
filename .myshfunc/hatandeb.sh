HATAN() {
# Author: HATAN
# Contact: YOUR_CONTACT_INFO
# Usage: HATAN
echo -e "[HATAN] program running..."
subdir=("bin" "etc" "include" "lib" "libexec" "share" "src" "tmp" "var")
printf "[HATAN] check folder... "
if test ! -d ${HOME}/HATAN; then
	mkdir ${HOME}/HATAN
fi
echo -e "ok"
read -p "[HATAN] package name: " package_name
read -p "[HATAN] version code: " version_code
project_folder="${package_name}_${version_code}_all"
if test -d ${HOME}/HATAN/${project_folder}; then
	echo -e "[HATAN-${package_name}] project exists: ${HOME}/HATAN/${project_folder}"
	exit
else
	echo -e "[HATAN-${package_name}] creating project: ${HOME}/HATAN/${project_folder}"
	mkdir ${HOME}/HATAN/${project_folder}
fi
mkdir ${HOME}/HATAN/${project_folder}/DEBIAN
mkdir -p ${HOME}/HATAN/${project_folder}${PREFIX}
for dir in ${subdir[@]}; do
	read -p "[HATAN-${package_name}] mkdir ${dir}? [Y] " mkdir_subdir
	if [[ "${mkdir_subdir}" == "Y" || "${mkdir_subdir}" == "y" ]]; then
		mkdir ${HOME}/HATAN/${project_folder}${PREFIX}/${dir}
	elif [[ "${mkdir_subdir}" == "done" ]]; then
		break
	fi
done
echo -e "[HATAN-${package_name}] type \"done\" when you're done moving file"
while true; do
	read -p "[HATAN-${package_name}] copy file: " copy_file
	read -p "[HATAN-${package_name}] place them onto ( $(ls $PREFIX | tr '\n' ' ')): " filedest
	if test -f ${copy_file}; then
		cp ${copy_file} ${HOME}/HATAN/${project_folder}${PREFIX}/${filedest}
	elif [[ "${copy_file}" == "done" ]]; then
		cp ${copy_file} ${HOME}/HATAN/${project_folder}${PREFIX}/${filedest}
		break
	else
		echo -e "[HATAN-${package_name}] file not exists: ${copy_file}"
	fi
done
file_control=$(cat <<DOCUMENT
Package: ${package_name}
Version: ${version_code}-stable
Architecture: all
Homepages: http://example.com
Maintainer: YOURNAME <youremail>
Depends: python2
Installed-Size: 100 KB
Description: DESCRIPTION_OF_THE_PACKAGE
DOCUMENT
)
file_postinst=$(cat <<DOCUMENT
#!/data/data/com.termux/files/usr/sh
# write your command, command execute when user install the package

DOCUMENT
)
file_prerm=$(cat <<DOCUMENT
#!/data/data/com.termux/files/usr/sh
# write your command, command execute when user remove the package

DOCUMENT
)
printf "${file_control}\n" > ${HOME}/HATAN/${project_folder}/DEBIAN/control
read -p "[HATAN-${package_name}] add DEBIAN/${package_name}.postinst? [Y] " postinst_add
read -p "[HATAN-${package_name}] add DEBIAN/${package_name}.prerm? [Y] " prerm_add
if [[ "${postinst_add}" == "Y" || "${postinst_add}" == "y" ]]; then
	printf "${file_postinst}\n" > ${HOME}/HATAN/${project_folder}/DEBIAN/${package_name}.postinst
	nvim ${HOME}/HATAN/${project_folder}/DEBIAN/${package_name}.postinst
fi
if [[ "${prerm_add}" == "Y" || "${prerm_add}" == "y" ]]; then
	printf "${file_prerm}\n" > ${HOME}/HATAN/${project_folder}/DEBIAN/${package_name}.prerm
	nvim ${HOME}/HATAN/${project_folder}/DEBIAN/${package_name}.prerm
fi
echo -e "[HATAN-${package_name}] ready to enter editor mode"
nvim ${HOME}/HATAN/${project_folder}/DEBIAN/control
printf "[HATAN-${package_name}] building deb package... "
chmod -R 755 ${HOME}/HATAN/${project_folder}
cd ${HOME}/HATAN && dpkg-deb --build ${project_folder} > /dev/null
echo -e "done"
echo -e "[HATAN] output: ${HOME}/HATAN/${project_folder}.deb"
echo -e "[HATAN] close the program."
}
