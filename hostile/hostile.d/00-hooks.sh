# hooks

#
# Copyright (C) 2009-2010 /tmp/lap <contact@tmplab.org>
#
# This is free software, licensed under the Exception General Public 
# License v2. See /COPYING for more information.
#

h_hook_register_handler() {
	local hook
	local handler
	local handlers
	local hook_var
	hook=$1
	handler=$2
	hook_var="H_HOOK_$hook"
	eval "handlers=\"\${$hook_var}\""
	eval "$hook_var=\"$handlers $handler \""
}

h_hook_unregister_handler() {
	local hook
	local handler
	local handlers
	local hook_var
	hook=$1
	handler=$2
	hook_var="H_HOOK_$hook"
	eval "handlers=\"\${$hook_var}\""
	eval "$hook_var=\"\$(echo $handlers | sed -e 's/ $handler / /')\""
}

h_hook_call_handlers() {
	local hook
	local args
	local handler
	local handlers
	local hook_var
	hook=$1
	shift
	args="$*"
	hook_var="H_HOOK_$hook"
	eval "handlers=\"\${$hook_var}\""
	for handler in $handlers; do
		$handler $args # || return
	done
}
