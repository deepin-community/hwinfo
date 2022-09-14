#!/bin/bash -eu

unset HWINFO_VERSION
repo=https://github.com/openSUSE/hwinfo.git
version=$(dpkg-parsechangelog | sed -ne 's/^Version: \(\([0-9]\+\):\)\?\(.*\)-.*/\3/p')
tmp=$(mktemp -d)

(
    cd "${tmp}"
    git clone "${repo}" hwinfo
    cd hwinfo
    git reset --hard "${version}"
    # the build system needs this
    make changelog # this creates VERSION as well
)

cp -f "${tmp}"/hwinfo/changelog debian/CHANGELOG
rm -rf "${tmp}"
git add debian/CHANGELOG
git commit -a -m "Updated upstream changelog"
