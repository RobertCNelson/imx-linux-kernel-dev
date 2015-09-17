#!/bin/sh
#
# Copyright (c) 2009-2015 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

. ${DIR}/version.sh
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

#Debian 7 (Wheezy): git version 1.7.10.4 and later needs "--no-edit"
unset git_opts
git_no_edit=$(LC_ALL=C git help pull | grep -m 1 -e "--no-edit" || true)
if [ ! "x${git_no_edit}" = "x" ] ; then
	git_opts="--no-edit"
fi

git="git am"
git_patchset="git://git.freescale.com/imx/linux-2.6-imx.git"
#git_opts

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

start_cleanup () {
	git="git am --whitespace=fix"
}

cleanup () {
	if [ "${number}" ] ; then
		git format-patch -${number} -o ${DIR}/patches/
	fi
	exit 2
}

pick () {
	if [ ! -d ../patches/${pick_dir} ] ; then
		mkdir -p ../patches/${pick_dir}
	fi
	git format-patch -1 ${SHA} --start-number ${num} -o ../patches/${pick_dir}
	num=$(($num+1))
}

linux_backports () {
	echo "dir: backport-4.1.x"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		start_cleanup
	fi

	${git} "${DIR}/patches/backport-4.1.x/0001-Copied-backport.patch"
	${git} "${DIR}/patches/backport-4.1.x/0002-Add-driver-sources.patch"
	${git} "${DIR}/patches/backport-4.1.x/0003-Copied-backport.patch"
	${git} "${DIR}/patches/backport-4.1.x/0004-Add-driver-sources.patch"
	${git} "${DIR}/patches/backport-4.1.x/0005-verify-sources-for-automatic-backports.patch"
	${git} "${DIR}/patches/backport-4.1.x/0006-modify-top-level-backports-Kconfig-with-backports-id.patch"

	if [ "x${regenerate}" = "xenable" ] ; then
	#	${git} "${DIR}/patches/backport-4.1.x/0007-Add-automatic-backports.patch"
		git commit --allow-empty -a -m 'Add-automatic-backports'
	fi

	${git} "${DIR}/patches/backport-4.1.x/0008-apply-backport-patch-0000-upstream-backport-changes-.patch"
	${git} "${DIR}/patches/backport-4.1.x/0009-apply-backport-patch-backport-adjustments-crypto-ccm.patch"
	${git} "${DIR}/patches/backport-4.1.x/0010-apply-backport-patch-backport-adjustments-devcoredum.patch"
	${git} "${DIR}/patches/backport-4.1.x/0011-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0012-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0013-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0014-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0015-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0016-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0017-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0018-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0019-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0020-apply-backport-patch-collateral-evolutions-media-000.patch"
	${git} "${DIR}/patches/backport-4.1.x/0021-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0022-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0023-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0024-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0025-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0026-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0027-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0028-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0029-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0030-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0031-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0032-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0033-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0034-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0035-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0036-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0037-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0038-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0039-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0040-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0041-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0042-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0043-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0044-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0045-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0046-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0047-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0048-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0049-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0050-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0051-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0052-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0053-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0054-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0055-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0056-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0057-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0058-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0059-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0060-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0061-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0062-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0063-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0064-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0065-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0066-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0067-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0068-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0069-apply-backport-patch-collateral-evolutions-network-0.patch"
	${git} "${DIR}/patches/backport-4.1.x/0070-apply-backport-SmPL-patch-collateral-evolutions-gene.patch"
	${git} "${DIR}/patches/backport-4.1.x/0071-apply-backport-SmPL-patch-collateral-evolutions-gene.patch"
	${git} "${DIR}/patches/backport-4.1.x/0072-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0073-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0074-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0075-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0076-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0077-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0078-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0079-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0080-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0081-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0082-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0083-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0084-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0085-apply-backport-SmPL-patch-collateral-evolutions-netw.patch"
	${git} "${DIR}/patches/backport-4.1.x/0086-generate-kernel-version-requirement-Kconfig-file.patch"

	if [ "x${regenerate}" = "xenable" ] ; then
	#	${git} "${DIR}/patches/backport-4.1.x/0087-verify-sources-on-top-level-backports-Kconfig.patch"
	#	${git} "${DIR}/patches/backport-4.1.x/0088-prune-Kconfig-tree.patch"

		git commit --allow-empty -a -m 'verify-sources-on-top-level-backports-Kconfig'
		git commit --allow-empty -a -m 'prune-Kconfig-tree'
	fi

	${git} "${DIR}/patches/backport-4.1.x/0089-adjust-backports-config-symbols-we-port.patch"
	${git} "${DIR}/patches/backport-4.1.x/0090-convert-select-to-depends-on.patch"

	if [ "x${regenerate}" = "xenable" ] ; then
	#	${git} "${DIR}/patches/backport-4.1.x/0091-add-useful-defconfig-files.patch"
		git commit --allow-empty -a -m 'add-useful-defconfig-files'
	fi

	${git} "${DIR}/patches/backport-4.1.x/0092-rename-config-symbol-srctree-usage.patch"
	${git} "${DIR}/patches/backport-4.1.x/0093-disable-impossible-kconfig-symbols.patch"

	if [ "x${regenerate}" = "xenable" ] ; then
	#	${git} "${DIR}/patches/backport-4.1.x/0094-add-kernel-version-dependencies.patch"
		git commit --allow-empty -a -m 'add-kernel-version-dependencies'
	fi

	${git} "${DIR}/patches/backport-4.1.x/0095-disable-unsatisfied-Makefile-parts.patch"
	${git} "${DIR}/patches/backport-4.1.x/0096-hooked-backport-to-top-level-Kconfig.patch"
	${git} "${DIR}/patches/backport-4.1.x/0097-apply-integration-patch-001-enable-backports-0001-en.patch"

	if [ "x${regenerate}" = "xenable" ] ; then
		number=97
		cleanup
	fi

	${git} "${DIR}/patches/backport-4.1.x/0001-backports-missed-rhashtable.c.patch"
}

external_git () {
	git_tag="rel_imx_3.14.28_1.0.0_ga"
	echo "pulling: ${git_tag}"
	git pull ${git_opts} ${git_patchset} ${git_tag}

	git_tag="imx_3.14.28_1.0.0_ga_neo"
	git_patchset="https://github.com/UDOOboard/linux_kernel/"
	echo "pulling: ${git_tag}"
	git pull ${git_opts} ${git_patchset} ${git_tag}
}

rt_cleanup () {
	echo "rt: needs fixup"
	exit 2
}

rt () {
	echo "dir: rt"
	rt_patch="${KERNEL_REL}${kernel_rt}"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		wget -c https://www.kernel.org/pub/linux/kernel/projects/rt/${KERNEL_REL}/patch-${rt_patch}.patch.xz
		xzcat patch-${rt_patch}.patch.xz | patch -p1 || rt_cleanup
		rm -f patch-${rt_patch}.patch.xz
		rm -f localversion-rt
		git add .
		git commit -a -m 'merge: CONFIG_PREEMPT_RT Patch Set' -s
		git format-patch -1 -o ../patches/rt/

		exit 2
	fi

	${git} "${DIR}/patches/rt/0001-merge-CONFIG_PREEMPT_RT-Patch-Set.patch"
}

local_patch () {
	echo "dir: dir"
	${git} "${DIR}/patches/dir/0001-patch.patch"
}

#linux_backports
external_git
#rt
#local_patch

dts () {
	echo "dir: dts"
	${git} "${DIR}/patches/dts/0001-neo-add-bluetooth.patch"
}

ti_wl () {
	echo "dir: ti_wl"
	${git} "${DIR}/patches/ti_wl/0001-imx6q-sabresd-add-support-for-wilink8-wlan-and-bluet.patch"
	${git} "${DIR}/patches/ti_wl/0002-Bluetooth-Add-tty-HCI-driver.patch"
	${git} "${DIR}/patches/ti_wl/0003-imx_v7_defconfig-enable-Wilink8-related-switches.patch"
	${git} "${DIR}/patches/ti_wl/0004-st_kim-do-not-use-debugfs-functions-if-not-enabled.patch"
	${git} "${DIR}/patches/ti_wl/0005-st_kim-allow-suspend-if-callback-is-not-registered.patch"
	${git} "${DIR}/patches/ti_wl/0006-btwilink-add-minimal-device-tree-support.patch"
	${git} "${DIR}/patches/ti_wl/0007-ti-st-add-device-tree-support.patch"
	${git} "${DIR}/patches/ti_wl/0008-imx6sl-evk-add-support-for-wilink8-wlan-and-bluetoot.patch"
	${git} "${DIR}/patches/ti_wl/0009-imx6-decrease-wilink8-sdio-pins-drive-strength.patch"
}

linux_backports
dts
#ti_wl

packaging () {
	echo "dir: packaging"
	#regenerate="enable"
	if [ "x${regenerate}" = "xenable" ] ; then
		cp -v "${DIR}/3rdparty/packaging/builddeb" "${DIR}/KERNEL/scripts/package"
		git commit -a -m 'packaging: sync builddeb changes' -s
		git format-patch -1 -o "${DIR}/patches/packaging"
		exit 2
	else
		${git} "${DIR}/patches/packaging/0001-packaging-sync-builddeb-changes.patch"
	fi
}

packaging
echo "patch.sh ran successfully"
