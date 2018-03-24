
# pwp (provisioning with puppet)

## Setup

* Put this module on your Puppet master.
* Get an RBAC token for a user with permission to run the tasks you'd like to use.
* https://puppet.com/docs/pe/2017.3/rbac/rbac_token_auth_intro.html#token-based-authentication

## Usage

### CLI
```
puppet task run pwp::get_environments --nodes <master_certname> --format json
puppet task run pwp::get_environments --nodes <master_certname> --format json | jq '.items | .[] | .results'
```
### API
example scope.json (task and target node):
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

```
curl -k -H 'X-Authentication:<RBAC_token>' https://<master_certname>:8143/orchestrator/v1/command/task -d @scope.json -X POST
```

example response (job 87):
```
POST
{
  "job" : {
    "id" : "https://<master_certname>:8143/orchestrator/v1/jobs/87",
    "name" : "87"
  }
}
```

followup to get node results for job:
```
curl -k -H 'X-Authentication:<RBAC_token>' https://<master_certname>:8143/orchestrator/v1jobs/87/nodes
{
  "items" : [ {
    "finish_timestamp" : "2018-03-23T21:37:20Z",
    "transaction_uuid" : null,
    "start_timestamp" : "2018-03-23T21:37:20Z",
    "name" : "<master_certname>",
    "duration" : 0.099,
    "state" : "finished",
    "details" : { },
    "result" : {
      "environments" : [ "dev", "production" ]
    },
    "latest-event-id" : 260,
    "timestamp" : "2018-03-23T21:37:20Z"
  } ],
  "next-events" : {
    "id" : "https://<master_certname>:8143/orchestrator/v1/jobs/87/events?start=261",
    "event" : "261"
  }
```

my result:
```
"result" : {
  "environments" : [ "dev", "production" ]
}
```

## Limitations

Under heavy development. Interface in flux and not guaranteed.
