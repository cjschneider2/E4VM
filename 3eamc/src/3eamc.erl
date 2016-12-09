%%%-------------------------------------------------------------------
%% @doc 3eamc public API
%% @end
%%%-------------------------------------------------------------------

-module('3eamc').

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, start_3eamc/1, start/0]).

%%====================================================================
%% API
%%====================================================================

start() ->
    start(normal, init:get_plain_arguments()).

start(_StartType, Args) ->
    start_3eamc(Args),
    init:stop(),
    {ok, self()}.

stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

start_3eamc([]) ->
    io:format("All arguments were processed~n", []),
    ok;
start_3eamc([F | Tail]) ->
    io:format("Processing: ~p...~n", [F]),
    try '3eamc_compiler':process(F)
    catch T:Err ->
        io:format("Failed~n~p ~p~n~p~n", [T, Err, erlang:get_stacktrace()])
    end,
    start_3eamc(Tail).