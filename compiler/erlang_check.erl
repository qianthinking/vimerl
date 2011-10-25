#!/usr/bin/env escript

main([Filename]) ->
    main([Filename, ""]);
main([Filename,Includes]) ->
    Dir = filename:dirname(Filename),
    Inc = string:tokens(Includes, ":"),
    InitOptions = [strong_validation,
        warn_export_all,
        warn_export_vars,
        warn_shadow_vars,
        warn_obsolete_guard,
        warn_unused_import,
        report,
        {i, "include"}, {i, "../include"},
        {i, Dir ++ "/include"}, {i, Dir ++ "/../include"},
        {d, 'TEST'}, {d, 'DEBUG'}],
    Options = lists:foldl(fun(Path, Paths) ->
                [ {i, Path ++ "/include"} | [{i, Path} | Paths]]
        end, InitOptions, Inc),
    compile:file([Filename], Options).
