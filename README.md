rebar-rsync-deps
=====

A rebar3 plugin to fetch dependencies with rsync

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

    {plugins, [
        { rebar-rsync-deps, ".*", {git, "git@host:user/rebar-rsync-deps.git", {tag, "0.1.0"}}}
    ]}.

Then just call your plugin directly in an existing application:


    $ rebar3 rebar-rsync-deps
    ===> Fetching rebar-rsync-deps
    ===> Compiling rebar-rsync-deps
    <Plugin Output>
