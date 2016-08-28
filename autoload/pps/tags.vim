function s:tags_file_path() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return ''
    endif

    return dir . '/tags'
endfunction

function s:run_command(command)
    let log = system(a:command)
    if v:shell_error == 0
        echo 'Tags file updated'
        return 1
    else
        echo 'Updating failed with exit status' v:shell_error
        echo a:command
        echo log
        return 0
    endif
endfunction

function s:ctags_cmd_base() abort
    let cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q '

    if get(b:, 'pps_tags_recurse_dirs')
        let cmd .= '-R '
    endif

    return cmd
endfunction

function pps#tags#configure(active) abort
    let active = a:active

    if active
        let tags = s:tags_file_path()

        if (tags ==# '') || !filereadable(tags)
            let active = 0
        endif
    endif

    if active
        execute 'setlocal tags=' . tags

        augroup pps_tags
            autocmd!
            autocmd BufWritePost *.cpp,*.h,*.c call pps#tags#update_one()
        augroup END
    else
        setlocal tags=
    endif
endfunction

function pps#tags#update() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        echo 'You must create the project directory first'
        return
    endif

    let tags = s:tags_file_path()
    if tags ==# ''
        return
    endif

    let cmd = s:ctags_cmd_base() . '-f ' . tags . ' '

    for d in get(b:, 'pps_tags_subdirs', [''])
        let cmd .= simplify(fnameescape(getcwd() . '/' . d) . '/*') . ' '
    endfor

    if s:run_command(cmd)
        call pps#tags#configure(1)
    endif
endfunction

function pps#tags#erase() abort
    let dir = pps#utils#get_project_dir()
    if (dir ==# '') || !isdirectory(dir)
        return
    endif

    let tags = s:tags_file_path()
    if (tags ==# '') || !filereadable(tags)
        return
    endif

    if delete(tags) == 0
        call pps#tags#configure(1)
    endif
endfunction

function pps#tags#update_one() abort
    if !get(b:, 'pps_tags_autoupdate', 1)
        return
    endif

    let tags = s:tags_file_path()
    if (tags ==# '') || !filereadable(tags)
        return
    endif

    let temp = tags . '.tmp'

    let file = resolve(fnameescape(expand('%:p')))
    let path = fnamemodify(file, ':h')

    let matched = 0
    for d in get(b:, 'pps_tags_subdirs', [''])
        let ppath = resolve(fnameescape(getcwd() . '/' . d))
        if (path ==# ppath)
            let matched = 1
        endif
    endfor

    if !matched
        return
    endif

    let cmd = 'sed "/' . escape(file, './') . '/d" ' . tags . ' > ' . temp
    let cmd .= '; ' . s:ctags_cmd_base() . '-a -f ' . temp . ' ' . file
    let cmd .= '; mv ' . temp . ' ' . tags

    call s:run_command(cmd)
endfunction

