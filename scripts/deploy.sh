#!/usr/bin/env bash

BANG_DIR='src'
source "$BANG_DIR/bang.sh"


b.module.require opt
b.module.require debian
b.module.require requirement
b.module.require localhop

### Functions ###
function load_options () {
  # Help (--help and -h added as flags)
  #b.opt.add_flag --stderr "Prints to stdeer"

  # text (--text and -t added as options)
  #b.opt.add_opt --text "Specify text to be printed"
  #b.opt.add_alias --text -t

  # Set required args (will raise errors if not specified)
  #b.opt.required_args --text
  return 0;
}

function run () {
  #load_options
  #b.opt.init "$@"
  #if b.opt.check_required_args; then
  #  local text="$(b.opt.get_opt --text)"
  #  if b.opt.has_flag? --stderr; then
  #    echo "$text" 1>&2
  #  else
  #    echo "$text"
  #  fi
  #fi
  b.requirement.check;
}

# Run!
#b.try.do run "$@"
#b.catch RequiredOptionNotSet b.opt.show_usage
#b.try.end
b.localhop.run "$@"