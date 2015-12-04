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
lock(_Dir, {rsync, Url}) ->
  {rsync, Url, "1.0"}.

-spec download(file:filename_all(), tuple(), rebar_state:t()) ->
  {tarball, file:filename_all()} | {ok, any()} | {error, any()}.
download(Dir, Source, _State) ->
  ok = filelib:ensure_dir(Dir),
  Cmd = lists:flatten(io_lib:format("rsync -az --delete ~s/ ~s", [Source, Dir])),
  rebar_utils:sh(Cmd, []).

-spec needs_update(file:filename_all(), tuple()) -> boolean().
needs_update(_Dir, _Source) ->
  false.

-spec make_vsn(file:filename_all()) -> {plain, string()} | {error, string()}.
make_vsn(_Dir) ->
  {plain, "1.0"}.
