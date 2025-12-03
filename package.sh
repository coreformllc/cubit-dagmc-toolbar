#! /bin/bash

curr_dir=$(dirname "$(realpath "$0")")
echo "Generating toolbar file for directory: ${curr_dir}"
sed "s|@TOOLBAR_INSTALL_DIR@|${curr_dir}|g" "${curr_dir}/toolbars/template.tmpl" > toolbars/dagmc_toolbar.ttb

sed "s|@TOOLBAR_INSTALL_DIR@|${curr_dir}|g" "${curr_dir}/mappings.tmpl" > .mappings
tar czvf cubit_dagmc_toolbar.tar.gz scripts toolbars/dagmc_toolbar.ttb icons .mappings

rm toolbars/dagmc_toolbar.ttb
rm .mappings
