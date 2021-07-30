#!/usr/bin/env bash
set -e
set -o pipefail

COMMAND="java -cp '.:/codesign/jar/*' com.ssl.code.signing.tool.CodeSignTool ${@}"

bash -c "set -e;  set -o pipefail; $COMMAND"
