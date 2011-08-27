# **pāmisshon** (パーミッション)

**pāmisshon** is a gem for easy permission handling in apps.

The word _pāmisshon_ (jap. パーミッション) for english "permission" was chosen, because it's less used so far.

**pāmisshon** is designed to work best with the CanCan gem, but also can be used as a standalone plugin to work with.

## Installation

In your Gemfile:

    gem "pamisshon"

and then `bundle install`.

## Getting started

### Initializer (Rails)

…

### Manual integration

…

## Rails, Padrino, Environments

**pāmisshon** uses `Redis::Namespace` as its redis client, so this gem will set a namespace for its keys.

Default namespace is `pamisshon`.

For automatic namespacing, the gem will try RAILS_ENV, PADRINO_ENV and PAMISSHON_ENV first (in this order) and prepend the corresponding environment to the default name like `pamisshon_production` for a production environment of your framework.

The PAMISSHON_ENV variable can be used to override the environment of your framework.

You also can give an own namespace (~ prefix, if in any environment).

With option `:force_ns => true` you can override any environment suffixes and give a single and unique namespace.

If you need further ENV checks, please tell me, so I can add these ENVs.

## Structure

A basic redis key in pamisshon has the following structure:

    "namespace:subject(klass)/subject(id)/verb/object(klass)/object(id)" "(0|1)"
    
The delimiter is `/`, the namespace is normally stripped out (redis-namespace does this for us).

So the interesting parts are the 5 pieces of the key name and the short value of zero or one.

The value is the easiest part, it represents a boolean state: it is permitted or not.

The subject-verb-object part has to be more fine grained to meet the requirement of general class permissions and specific instance permission.

Example: You permit, that all users can read all pages and user 1 can also write to page 2, but can not delete it (and all users of course are not allowed to delete any page).

    "user/##ALL##/read/page/##ALL##" "1"
    "user/##ALL##/delete/page/##ALL##" "0"
    "user/1/write/page/2" "1"
    "user/1/delete/page/2" "0"

This structure is very cool, because now we can do traversals and searches in redis like:

    redis> keys *
    redis> keys user/*
    redis> keys user/##ALL##/*
    redis> keys user/1/*
    redis> keys */*/read/*/*
    redis> keys */*/*/page/##ALL##
    
    redis> keys */*/*/*/*

The last query shows the 5-pieces-match, which ensures, that the keys must have this key structure.

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

