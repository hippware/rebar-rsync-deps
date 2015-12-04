%% -*- mode: erlang; erlang-indent-level: 2; indent-tabs-mode: nil -*-
%% ex: ts=2 sw=2 ft=erlang et

-module(rebar_rsync_resource).

-behaviour(rebar_resource).

-export([lock/2
        ,download/3
        ,needs_update/2
        ,make_vsn/1]).

lock(_Dir, {rsync, Url}) ->
    {rsync, Url, "1.0"}.

download(Dir, Source, _State) ->
    ok = filelib:ensure_dir(Dir),
    Cmd = lists:flatten(io_lib:format("rsync -az --delete ~s/ ~s",
                                      [Source, Dir])),
    rebar_utils:sh(Cmd, []).

needs_update(_Dir, _Source) ->
    false.

make_vsn(_Dir) ->
    {plain, "1.0"}.

