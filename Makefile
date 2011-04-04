#
# Package and Deploy to the Playbook
#
# Getting Started:
#
#   1. Update ADDRESS  with your Playbook IP Address
#   2. Update PASSWORD with your Playbook password
#   3. Update SDK_DIR  with the path to the Playbook WebWorks SDK
#
# Usage:
#
#   $ make
#
# Assumption:
#
#   Directory structure is as follows:
#
#        Makefile ..... this file
#        www/ ......... WebWorks app (HTML / CSS / JS / etc)
#
.SILENT: build clean

ADDRESS  = 172.16.207.130
PASSWORD = "password"
SDK_DIR  = ~/Development/blackberry-tablet-sdk-0.9.4

# Change for Windows environments (.exe)
AMXMLC_BIN = ${SDK_DIR}/bin/amxmlc
AIRPKG_BIN = ${SDK_DIR}/bin/blackberry-airpackager
DEPLOY_BIN = ${SDK_DIR}/bin/blackberry-deploy

BUILD_DIR = bin
LIB_DIR   = lib
SRC_FILE  = AppMenuDemo.as
SRC_DIR	  = src
SWF_FILE  = AppMenuDemo.swf
BAR_FILE  = AppMenuDemo.bar
XML_FILE  = AppMenuDemo-app.xml
ASSETS_DIR = assets

build: clean
	mkdir -p ${BUILD_DIR}
	${AMXMLC_BIN} ${SRC_DIR}/${SRC_FILE} -debug -library-path+=${LIB_DIR} -output ${BUILD_DIR}/${SWF_FILE}
	${AIRPKG_BIN} -package ${BUILD_DIR}/${BAR_FILE} -target bar-debug ${SRC_DIR}/${XML_FILE} ${BUILD_DIR}/${SWF_FILE} ${ASSETS_DIR}
	${DEPLOY_BIN} -installApp -password ${PASSWORD} -device ${ADDRESS} -package ${BUILD_DIR}/${BAR_FILE}

release: clean
	mkdir -p ${BUILD_DIR}
	${AMXMLC_BIN} ${SRC_DIR}/${SRC_FILE} -library-path+=${LIB_DIR} -output ${BUILD_DIR}/${SWF_FILE}
	${AIRPKG_BIN} -package ${BUILD_DIR}/${BAR_FILE} -target bar ${SRC_DIR}/${XML_FILE} ${BUILD_DIR}/${SWF_FILE} ${ASSETS_DIR}
	${DEPLOY_BIN} -installApp -password ${PASSWORD} -device ${ADDRESS} -package ${BUILD_DIR}/${BAR_FILE}

clean:
	if test -d ${BUILD_DIR}; then \
		rm -rf ${BUILD_DIR}; \
	fi
