#!/bin/bash

PACKAGE_DIR="${BUILT_PRODUCTS_DIR}/package"

mkdir -pv "${PACKAGE_DIR}"

# prepare contents of package
# create package contents dir
mkdir "${BUILT_PRODUCTS_DIR}/packageContent"

# Move all we need to that dir
mv "${BUILT_PRODUCTS_DIR}/HelloGrantAccess.app" "${BUILT_PRODUCTS_DIR}/packageContent/HelloGrantAccess.app"

# create plugins dir
mkdir "${BUILT_PRODUCTS_DIR}/Plugins"

# Move all we need to that dir
mv "${BUILT_PRODUCTS_DIR}/GrantAccess.bundle" "${BUILT_PRODUCTS_DIR}/Plugins/GrantAccess.bundle"

cp "./GrantAccess/InstallerSections.plist" "${BUILT_PRODUCTS_DIR}/Plugins/"

PRODUCT_PACKAGE="${BUILT_PRODUCTS_DIR}/HelloInstallerPlugin.pkg"

pkgbuild --root "${BUILT_PRODUCTS_DIR}/packageContent" \
    --identifier "com.YourCompany.Identifier" \
	--ownership recommended \
	--install-location "/Applications/" \
	--scripts "./Package/scripts" \
	"${PACKAGE_DIR}/package.pkg"

productbuild --distribution "./Package/distribution.xml"
	--package-path "${PACKAGE_DIR}"
	--plugins "${BUILT_PRODUCTS_DIR}/Plugins/"
	"${PRODUCT_PACKAGE}"

rm -rf "${BUILT_PRODUCTS_DIR}/package"
rm -rf "${BUILT_PRODUCTS_DIR}/packageContent"
rm -rf "${BUILT_PRODUCTS_DIR}/Plugins"
