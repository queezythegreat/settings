if [ -z "${CHROOT_ENVIRONMENTS}" ]; then
    CHROOT_ENVIRONMENTS="${HOME}/storage/chroots"
fi

# chroot_environment ENV_NAME
function chroot_environment {
    local CHROOT_NAME="${1}"
    local CHROOT_SCRIPT="${2}"
    local CHROOT_PATH="/srv/chroot/${CHROOT_NAME}"
    MOUNTED=$(df -a | grep "${CHROOT_PATH}$")

    # Mount chroot environment if not mounted
    [ -z "${MOUNTED}" ] && ${CHROOT_SCRIPT}

    # Enter chroot environment
    chroot ${CHROOT_PATH} /bin/bash -c "cd;export BUILD_ENVIRONMENT=${CHROOT_NAME};${SHELL}"
}

for ENV_SCRIPT in ${CHROOT_ENVIRONMENTS}/chroot-*; do
    local ENV_NAME=$(basename ${ENV_SCRIPT} | sed 's|chroot-\(.*\)|\1|' )
    local ALIAS_NAME="env_$(echo ${ENV_NAME}| tr -d '.-')"
    eval alias ${ALIAS_NAME}=\"chroot_environment ${ENV_NAME} ${ENV_SCRIPT}\"
done &> /dev/null

# Execute optional chroot environment initialization script (~/CHROOT_NAME.sh)
if [ ! -x "${BUILD_ENVIRONMENT}" -a -f "${BUILD_ENVIRONMENT}.sh" ]; then
    . "${BUILD_ENVIRONMENT}.sh"
fi
