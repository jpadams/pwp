
# pwp

### Setup

Put this module on your Puppet master.

## Usage

```
puppet task run pwp::get_environments --nodes <master_certname> --format json
puppet task run pwp::get_environments --nodes <master_certname> --format json | jq '.items | .[] | .results'
```


## Limitations

Under heavy development. Interface in flux and not guaranteed.
