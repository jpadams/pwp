
# pwp (provisioning with puppet)

### Setup

Put this module on your Puppet master.

## Usage

```
puppet task run pwp::get_environments --nodes <master_certname> --format json
puppet task run pwp::get_environments --nodes <master_certname> --format json | jq '.items | .[] | .results'
```

```
curl -k -H 'X-Authentication:<RBAC_token>' https://<master_certname>:8143/orchestrator/v1/command/task -d @scope.json -X POST
```

example scope.json
```
{
  "environment" : "production",
  "task" : "pwp::get_environments",
  "params" : {
  },
  "scope" : {
    "nodes" : ["<master_certname>"]
  }
}
```

## Limitations

Under heavy development. Interface in flux and not guaranteed.
