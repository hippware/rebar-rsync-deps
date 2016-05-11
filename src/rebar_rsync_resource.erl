%% -*- mode: erlang; erlang-indent-level: 2; indent-tabs-mode: nil -*-
%% ex: ts=2 sw=2 ft=erlang et

-module(rebar_rsync_resource).

-behaviour(rebar_resource).

-export([
  lock/2,
  download/3,
  needs_update/2,
  make_vsn/1
]).


%% ===================================================================
%% Public API
%% ===================================================================

-spec lock(file:filename_all(), tuple()) -> rebar_resource:resource().
lock(_Dir, Source) ->
  Source.

-spec download(file:filename_all(), tuple(), rebar_state:t()) ->
  {tarball, file:filename_all()} | {ok, any()} | {error, any()}.
download(Dir, {rsync, Source, _}, State) ->
  download(Dir, {rsync, Source}, State);
download(Dir, {rsync, Source}, _State) ->
  ok = filelib:ensure_dir(Dir),
  Cmd = lists:flatten(io_lib:format("rsync -az --delete --exclude=ebin --exclude=priv/lib ~s/ ~s", [Source, Dir])),
  rebar_utils:sh(Cmd, []).

-spec needs_update(file:filename_all(), tuple()) -> boolean().
needs_update(_Dir, _Source) ->
  true.

-spec make_vsn(file:filename_all()) -> {plain, string()} | {error, string()}.
make_vsn(_Dir) ->
  {error, "Replacing version of type rsync not supported."}.
