#!/usr/bin/env zsh
docker_prune() {
	docker system prune --volumes -fa
}

dfind_helper()
{
  result="$(docker ps --filter="name=$1" --format="{{.ID}}")"

  if [ "$result" = "" ]; then
    docker ps --filter "ID=$1" --format '{{.ID}}'
  else
    echo $result
  fi
}
dfind()
{
  result="$(dfind_helper $1)"
  if echo $result | grep " "; then
    >&2 echo "Error: More than one container matched the search string '$1'. You must provide a larger subset of the container name."
    kill -INT $$
  fi

  echo $result
}

dpid()
{
  dinspect --format '{{.State.Pid}}' "$@"
}

# Enter a container, denter <grep on something from docker ps>
denter()
{
  dexec $1 bash
}
dexec()
{
  docker exec -t -i $(dfind $1) "$@"
}

# Display stats about a container, dstats <grep on something from docker ps>
dstats()
{
  if [ $# -gt 0 ] ; then
    docker stats $(dfind $1)
  else
    docker stats $(docker ps --format {{.Names}})
  fi
}

# Display logs(stdout) from a container, dlogs <grep on something from docker ps>
dlogs()
{
  docker logs $2 $3 $4 $(dfind $1)
}

# Stop a container, dstop <grep on something from docker ps>
dstop()
{
  docker stop $(dfind $1)
}

# Kill a container, dkill <grep on something from docker ps>
dkill()
{
  docker kill $(dfind $1)
}

# Inspect a container, dinspect <grep on something from docker ps>
dinspect()
{
  docker inspect $2 $3 $4 $(dfind $1)
}

# Remove a bunch of <none> images.
d_rmi_all_none()
{
  for h in `docker images|grep none|awk '{print $3}'`; do
    docker rmi $h
  done
}

dsyslog()
{
  local lines=50
  if [ -n "$2" ] ; then
    lines="$2"
  fi
  dexec "$1" "tail -f -n $lines /var/log/syslog"
}

# denter, but attach instead of exec
dattach()
{
  docker attach $(dfind $1)
}

# figure out the bridge ip of a container
dbridge_ip()
{
  local container_id="$(dfind "$1")"
  local container_full_name="$(docker inspect -f '{{.Name}}' "$container_id" 2>/dev/null | cut -d / -f2)"
  if [ -n "$container_full_name" ]; then
    echo -e "${container_full_name}\t$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id |grep '\(172\|192\)')"
  else
    echo "unknown container: $1"
  fi
}

# show all docker ips and associated container names
dips()
{
  for id in $(docker ps --format '{{.ID}}')
  do dbridge_ip "$id"
  done
}

# show the environment for a container
dshowenv()
{
  local container_id="$(dfind "$1")"
  docker inspect $container_id | jq '.[] | .Config | .Env'
}
