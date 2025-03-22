source common/const

lifx() {
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
  cp $LIFX_PATH/lifx.lua $NVIM_CONFIG
  cp $LIFX_PATH/toggleLifx.sh $NVIM_SCRIPTS
  cp $LIFX_PATH/lifxAPIKey $NVIM_KEYS
}

config() {
  source config/bashrc.sh
}

lifx
config
