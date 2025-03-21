lifx() {
  source "$(dirname "$0")/common/const"

  PATHS=(
    $NVIM_CONFIG
    $NVIM_SCRIPTS
    $NVIM_KEYS
  )

  # create directories
  for path in ${PATHS[@]}; do
    if [ ! -d $path ]; then
      mkdir $path
    fi
  done

  # override
  cp ./tools/lifx/lifx.lua $NVIM_CONFIG
  cp ./tools/lifx/toggleLifx.sh $NVIM_SCRIPTS
  cp ./tools/lifx/lifxAPIKey $NVIM_KEYS
}

lifx
