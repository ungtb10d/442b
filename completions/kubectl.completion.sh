#! bash 442b.module

# kubectl (Kubernetes CLI) completion

if _omb_util_command_exists kubectl
then
  eval "$(kubectl completion bash)"
fi
