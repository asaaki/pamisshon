# **pāmisshon** (パーミッション)

**pāmisshon** is a gem for easy permission handling in apps.

The word _pāmisshon_ (jap. パーミッション) for english "permission" was chosen, because it's less used so far.

Inspired by [redistat](https://github.com/jimeh/redistat)'s query structure ("node/subnode/subsub/123" as keys).

## Rails, Padrino, Environments

**pāmisshon** uses `Redis::Namespace` as its redis client, so this gem will set a namespace for its keys.

Default namespace is `pamisshon`.

For automatic namespacing, the gem will try RAILS_ENV, PADRINO_ENV and PAMISSHON_ENV first (in this order) and prepend the corresponding environment to the default name like `pamisshon_production` for a production environment of your framework.

The PAMISSHON_ENV variable can be used to override the environment of your framework.

You also can give an own namespace (~ prefix, if in any environment).

With option `:force_ns => true` you can override any environment suffixes and give a single and unique namespace.

If you need further ENV checks, please tell me, so I can add these ENVs.

----

## Contributing to pamisshon
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Christoph Grabo. See LICENSE.txt for
further details.

