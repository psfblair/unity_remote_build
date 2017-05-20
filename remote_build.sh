VALID_CMD=0

[[ -n "${REMOTE_USER}" ]] || { echo "export REMOTE_USER="; VALID_CMD=1; }
[[ -n "${REMOTE_HOST}" ]] || { echo "export REMOTE_HOST="; VALID_CMD=1; }
[[ -n "${REMOTE_PROJECT_DIR}" ]] || { echo "export REMOTE_PROJECT_DIR="; VALID_CMD=1; }
[[ -n "${UNITY_FOLDER}" ]] || { echo "export UNITY_FOLDER="; VALID_CMD=1; }
[[ -n "${SCENES_TO_BUILD}" ]] || { echo "export SCENES_TO_BUILD="; VALID_CMD=1; }
[[ -n "${SOLUTION_FILE_NAME}" ]] || { echo "export SOLUTION_FILE_NAME="; VALID_CMD=1; }

if [[ ${VALID_CMD} -eq 1 ]] ; then
  echo "Please configure the above environment variables before running this script."
  exit 1
fi

ssh $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_PROJECT_DIR && unity_headless_build.bat \"$UNITY_FOLDER\" $SCENES_TO_BUILD && msbuild_headless.bat $SOLUTION_FILE_NAME"
