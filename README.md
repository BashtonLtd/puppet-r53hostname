# r53hostname

## Puppet module

Used internal at Bashton.  Maybe not so useful to people whose
environment naming conventions don't match ours.

Assumes Puppet 4.1+

## Usage

In hiera:

```yaml
classes:
 - r53hostname

r53hostname::service: jenkins
r53hostname::includeaz: false

```

Will add a hostname jenkins.example.com pointing to your machines IP.

